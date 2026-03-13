/// @description Handle animation, layout, and input

// Guard: if there are no buttons yet, do nothing.
// This can happen on the very first step before the spawning code has run.
var _btn_count = array_length(buttons);
if (_btn_count == 0) exit;


// ── MEASURE TEXT ─────────────────────────────────────────────────────────────
// Set the font before measuring so string_width/height are accurate.
draw_set_font(fnt_Quicksand);
var _text_w = string_width(message);
var _text_h = string_height(message);


// ── PANEL BASE SIZE ───────────────────────────────────────────────────────────
// Unscaled target size — what the panel looks like at scale 1.
// Must be wide enough for both the text and all buttons.
//
// Total button row width: (btn_w * count) + (btn_gap * gaps between them)
var _total_btn_w = btn_w * _btn_count + btn_gap * (_btn_count - 1);

// Panel is as wide as whichever is widest: minimum, text, or all buttons.
panel_base_w = max(panel_min_w, _text_w + panel_padding * 2, _total_btn_w + panel_padding * 2);

// Height: top padding + text + gap + button row + bottom margin.
panel_base_h = max(panel_min_h, _text_h + panel_padding + 8 + btn_h + btn_margin_bottom + panel_padding);


// ── ANIMATION ─────────────────────────────────────────────────────────────────

if (state == "opening") {
    anim_t += (1 / anim_speed);
    if (anim_t >= 1) {
        anim_t = 1;
        state  = "idle";
    }
    scale = _ease_out_back(anim_t);
}

if (state == "closing") {
    anim_t -= (1 / anim_speed);
    if (anim_t <= 0) {
        instance_destroy();   // CleanUp event resets global.dialog_open
        exit;
    }
    // Swap for _ease_out_back(anim_t) if you want a springy close too.
    scale = _ease_out_quad(anim_t);
}


// ── LAYOUT UPDATE ─────────────────────────────────────────────────────────────
// Convert unscaled dimensions into actual GUI-space positions.
// Everything scales outward from (cx, cy).

panel_draw_w = panel_base_w * scale;
panel_draw_h = panel_base_h * scale;
btn_draw_w   = btn_w * scale;
btn_draw_h   = btn_h * scale;

// Button row Y: near the bottom of the panel.
var _btn_row_y = cy + (panel_base_h / 2 - btn_margin_bottom - btn_h / 2) * scale;

// Distribute buttons evenly across the row, centered on cx.
// Start x is the center of the leftmost button.
//   total row width = _total_btn_w (unscaled)
//   leftmost button center = cx - (total_row_width / 2 - btn_w / 2) * scale
var _row_start_x = cx - (_total_btn_w / 2 - btn_w / 2) * scale;

for (var i = 0; i < _btn_count; i++) {
    // Each button steps one (btn_w + btn_gap) to the right of the previous.
    buttons[i].cx    = _row_start_x + i * (btn_w + btn_gap) * scale;
    buttons[i].cy    = _btn_row_y;
    buttons[i].hover = false;   // reset hover each frame before checking below
}


// ── INPUT (only when fully open) ──────────────────────────────────────────────

if (state == "idle") {

    // ── MOUSE HOVER ──────────────────────────────────────────────────────────
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    for (var i = 0; i < _btn_count; i++) {
        var _b = buttons[i];
        _b.hover = point_in_rectangle(_mx, _my,
            _b.cx - btn_draw_w / 2, _b.cy - btn_draw_h / 2,
            _b.cx + btn_draw_w / 2, _b.cy + btn_draw_h / 2);

        // Keep keyboard focus synced with mouse hover.
        if (_b.hover) focused_btn = i;
    }

    // ── MOUSE CLICK ──────────────────────────────────────────────────────────
    if (mouse_check_button_pressed(mb_left)) {
        for (var i = 0; i < _btn_count; i++) {
            if (buttons[i].hover) _do_activate(i);
        }
    }

    // ── KEYBOARD / GAMEPAD ───────────────────────────────────────────────────
    // Left/right verbs cycle through the buttons array.
    // wraps around at both ends (last → first, first → last).
    if (input_check_pressed("left")) {
        focused_btn = (focused_btn - 1 + _btn_count) mod _btn_count;
    }
    if (input_check_pressed("right")) {
        focused_btn = (focused_btn + 1) mod _btn_count;
    }

    // "accept" verb fires whichever button is currently focused.
    if (input_check_pressed("accept")) {
        _do_activate(focused_btn);
    }

    // "cancel" verb always activates the LAST button in the array.
    // By convention, put your Cancel/dismiss button last when building the dialog.
    if (input_check_pressed("cancel")) {
        _do_activate(_btn_count - 1);
    }

}
