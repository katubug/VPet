/// @description Draw the dialog — overlay, panel, text, and buttons

var _btn_count = array_length(buttons);
if (_btn_count == 0) exit;

// If Step hasn't run yet (instance was created mid-frame), button layout
// positions won't exist yet. Skip drawing for this one frame.
if (!struct_exists(buttons[0], "cy")) exit;


// ── SCREEN OVERLAY ────────────────────────────────────────────────────────────
// Semi-transparent black layer to dim the background.
// Adjust 0.55 to change darkness: 0.0 = no dim, 1.0 = pitch black.
draw_set_color(c_black);
draw_set_alpha(0.55 * scale);
draw_rectangle(0, 0, gui_w, gui_h, false);


// ── PANEL ─────────────────────────────────────────────────────────────────────
// draw_sprite_stretched respects the nine-slice config on spr_ui_box —
// corners stay crisp, middle stretches. c_white = no color tint.
draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_stretched(spr_ui_box, 0,
    cx - panel_draw_w / 2,
    cy - panel_draw_h / 2,
    panel_draw_w,
    panel_draw_h);


// ── MESSAGE TEXT ──────────────────────────────────────────────────────────────
// Fades in between scale 0.6 and 1.0 to avoid tiny compressed text
// during the opening animation.
// Lower the 0.6 threshold to make text appear sooner, raise it for later.
if (scale > 0.6) {
    var _text_alpha = (scale - 0.6) / 0.4;

    draw_set_font(fnt_Quicksand);
    draw_set_alpha(_text_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    // Positioned in the upper portion of the panel.
    // Adjust 0.25 if the text feels too high or too low.
    var _text_y = cy - (panel_base_h * 0.25) * scale;
    draw_text(cx, _text_y, message);
}


// ── BUTTONS ───────────────────────────────────────────────────────────────────
// The focused (or hovered) button gets a warm yellow tint to show selection.
// To use a different highlight color, replace make_color_rgb(255, 230, 100).
draw_set_alpha(scale);

for (var i = 0; i < _btn_count; i++) {
    var _b    = buttons[i];
    var _tint = (focused_btn == i) ? make_color_rgb(255, 230, 100) : c_white;

    draw_set_color(_tint);
    draw_sprite_stretched(spr_ui_button, 0,
        _b.cx - btn_draw_w / 2,
        _b.cy - btn_draw_h / 2,
        btn_draw_w,
        btn_draw_h);
}


// ── BUTTON LABELS ─────────────────────────────────────────────────────────────
if (scale > 0.6) {
    var _label_alpha = (scale - 0.6) / 0.4;

    draw_set_font(fnt_Quicksand);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(_label_alpha);
    draw_set_color(c_white);

    for (var i = 0; i < _btn_count; i++) {
        var _b = buttons[i];
        draw_text(_b.cx, _b.cy, _b.label);
    }
}


// ── RESET DRAW STATE ──────────────────────────────────────────────────────────
draw_reset();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
