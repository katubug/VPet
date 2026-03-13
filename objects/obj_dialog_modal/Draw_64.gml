/// @description Draw the dialog — overlay, panel, text, and buttons


// ── SCREEN OVERLAY ────────────────────────────────────────────────────────────
// A semi-transparent black layer over the entire screen.
// This visually dims everything behind the dialog, reinforcing that the
// background is inactive. It fades in along with the dialog.
//
// To adjust darkness: change the 0.55 multiplier.
//   0.0 = fully transparent (no dim)   1.0 = fully opaque (pitch black)
draw_set_color(c_black);
draw_set_alpha(0.55 * scale);
draw_rectangle(0, 0, gui_w, gui_h, false);


// ── PANEL ─────────────────────────────────────────────────────────────────────
// draw_sprite_stretched automatically respects the nine-slice configuration
// set on spr_ui_box in the sprite editor — corners stay crisp, middle stretches.
// c_white = no color tint (sprite draws at its original colors).
draw_set_alpha(1);
draw_set_color(c_white);
draw_sprite_stretched(spr_ui_box, 0,
    cx - panel_draw_w / 2,
    cy - panel_draw_h / 2,
    panel_draw_w,
    panel_draw_h);


// ── MESSAGE TEXT ──────────────────────────────────────────────────────────────
// Only draw text once the panel is large enough to look right.
// Between scale 0.6 and 1.0 the text fades in from transparent to opaque.
// This avoids the ugly look of compressed text inside a tiny opening box.
//
// To make text appear sooner, lower the 0.6 threshold.
// To make it appear later, raise it (max 1.0 = text only appears when fully open).
if (scale > 0.6) {
    var _text_alpha = (scale - 0.6) / 0.4;   // 0 at scale=0.6, 1 at scale=1.0

    draw_set_font(fnt_Quicksand);
    draw_set_alpha(_text_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    // Text is positioned slightly above center to leave room for the buttons below.
    // The -0.25 * panel_base_h offset pushes it into the upper portion of the panel.
    // Adjust the 0.25 multiplier if the text feels too high or too low.
    var _text_y = cy - (panel_base_h * 0.25) * scale;
    draw_text(cx, _text_y, message);
}


// ── BUTTONS ───────────────────────────────────────────────────────────────────
// The focused (or hovered) button gets a warm yellow tint to show selection.
// Unfocused buttons are drawn with c_white (no tint = normal sprite colors).
//
// To use a different highlight color, change make_color_rgb(255, 230, 100)
// to any color you like, e.g. make_color_rgb(150, 220, 255) for a blue tint.
var _confirm_tint = (focused_btn == 0) ? make_color_rgb(255, 230, 100) : c_white;
var _cancel_tint  = (focused_btn == 1) ? make_color_rgb(255, 230, 100) : c_white;

// Buttons fade in with the panel using the current scale as alpha.
// GameMaker clamps alpha to [0, 1] so the brief overshoot above 1.0 is safe.
draw_set_alpha(scale);

// Confirm button (left)
draw_set_color(_confirm_tint);
draw_sprite_stretched(spr_ui_button, 0,
    btn_confirm_cx - btn_draw_w / 2,
    btn_confirm_cy - btn_draw_h / 2,
    btn_draw_w,
    btn_draw_h);

// Cancel button (right)
draw_set_color(_cancel_tint);
draw_sprite_stretched(spr_ui_button, 0,
    btn_cancel_cx - btn_draw_w / 2,
    btn_cancel_cy - btn_draw_h / 2,
    btn_draw_w,
    btn_draw_h);


// ── BUTTON LABELS ─────────────────────────────────────────────────────────────
// Same fade-in threshold as the message text.
if (scale > 0.6) {
    var _label_alpha = (scale - 0.6) / 0.4;

    draw_set_font(fnt_Quicksand);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_alpha(_label_alpha);
    draw_set_color(c_white);

    draw_text(btn_confirm_cx, btn_confirm_cy, btn_label_confirm);
    draw_text(btn_cancel_cx,  btn_cancel_cy,  btn_label_cancel);
}


// ── RESET DRAW STATE ──────────────────────────────────────────────────────────
// Always clean up after custom drawing. Other objects that draw after this one
// will inherit stale settings if you don't reset them.
draw_reset();
draw_set_halign(fa_left);
draw_set_valign(fa_top);
