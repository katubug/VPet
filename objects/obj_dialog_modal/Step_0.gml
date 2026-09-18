/// @description Handle animation, layout, and input

// Guard: if there are no buttons yet, do nothing.
// This can happen on the very first step before the spawning code has run.
var _btn_count = array_length(buttons);
if (_btn_count == 0) exit;

// Recalculate center every Step — the canvas may have been resized after Create ran
// (especially on Android where the surface resizes shortly after game start).
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
cx    = gui_w / 2;
cy    = gui_h / 2;


// ── MEASURE TEXT & BUTTONS ───────────────────────────────────────────────────
draw_set_font(fnt_Kubasta);

// Size each button to its label text + padding
var _btn_pad = 9;
for (var i = 0; i < _btn_count; i++) {
    buttons[i]._w = string_width(buttons[i].label) + _btn_pad * 2;
    buttons[i]._h = btn_h;
}

// Total button row width based on individual button sizes
var _total_btn_w = 0;
for (var i = 0; i < _btn_count; i++) {
    _total_btn_w += buttons[i]._w;
}
_total_btn_w += btn_gap * max(0, _btn_count - 1);

// ── PANEL BASE SIZE ───────────────────────────────────────────────────────────
// Panel width is 85% of screen width, but no smaller than minimum or button row
var _max_panel_w = gui_w * 0.85;
panel_base_w = clamp(
    max(panel_min_w, _total_btn_w + panel_padding * 2),
    panel_min_w,
    _max_panel_w
);

// Wrap text within available content width
content_w = panel_base_w - panel_padding * 2;
text_h    = string_height_ext(message, -1, content_w);

// Height: top padding + wrapped text + gap + button row + bottom margin
var _gap = 2;
panel_base_h = max(panel_min_h, panel_padding + text_h + _gap + btn_h + btn_margin_bottom + panel_padding);


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
btn_draw_h   = btn_h * scale;

// Button row Y: near the bottom of the panel
var _btn_row_y = cy + (panel_base_h / 2 - btn_margin_bottom - btn_h / 2) * scale;

// Distribute variable-width buttons centered on cx
// First calculate total scaled row width
var _scaled_row_w = _total_btn_w * scale;
var _cur_x = cx - _scaled_row_w / 2; // left edge of the row

for (var i = 0; i < _btn_count; i++) {
    var _bw = buttons[i]._w * scale;
    buttons[i].cx       = _cur_x + _bw / 2; // center of this button
    buttons[i].cy       = _btn_row_y;
    buttons[i].draw_w   = _bw;
    buttons[i].draw_h   = btn_draw_h;
    buttons[i].hover    = false;
    _cur_x += _bw + btn_gap * scale;
}


// ── INPUT (only when fully open) ──────────────────────────────────────────────

if (state == "idle") {

    // ── MOUSE HOVER ──────────────────────────────────────────────────────────
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    for (var i = 0; i < _btn_count; i++) {
        var _b = buttons[i];
        _b.hover = point_in_rectangle(_mx, _my,
            _b.cx - _b.draw_w / 2, _b.cy - _b.draw_h / 2,
            _b.cx + _b.draw_w / 2, _b.cy + _b.draw_h / 2);

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
