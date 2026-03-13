/// @description Handle animation, layout, and input


// ── MEASURE TEXT ─────────────────────────────────────────────────────────────
// Set the font before measuring so string_width/height give accurate numbers.
// This recalculates every step, which is fine — it's cheap and handles
// messages that change dynamically (e.g. multi-page dialogs in the future).
draw_set_font(fnt_Quicksand);
var _text_w = string_width(message);
var _text_h = string_height(message);


// ── PANEL BASE SIZE ───────────────────────────────────────────────────────────
// These are the UNSCALED target dimensions — what the panel looks like at scale 1.
// The panel expands to fit its content but never goes below panel_min_w/h.
//
// Height breakdown:
//   panel_padding (top)
//   + text height
//   + 8px gap between text and buttons
//   + btn_h
//   + btn_margin_bottom (bottom)
panel_base_w = max(panel_min_w, _text_w + panel_padding * 2);
panel_base_h = max(panel_min_h, _text_h + panel_padding + 8 + btn_h + btn_margin_bottom + panel_padding);


// ── ANIMATION ─────────────────────────────────────────────────────────────────

if (state == "opening") {
    // Advance anim_t by 1/anim_speed each frame, capping at 1.0.
    anim_t += (1 / anim_speed);
    if (anim_t >= 1) {
        anim_t = 1;
        state  = "idle";   // animation done — start accepting input
    }
    // Apply the springy ease-out-back curve.
    // scale will briefly exceed 1.0 at the overshoot peak — that's intentional.
    scale = _ease_out_back(anim_t);
}

if (state == "closing") {
    // Shrink anim_t back toward 0 at the same speed.
    anim_t -= (1 / anim_speed);
    if (anim_t <= 0) {
        // Destroy the instance — CleanUp event will reset global.dialog_open.
        instance_destroy();
        exit;   // stop executing this step after destroy
    }
    // Ease-out-quad gives a smooth shrink without overshoot.
    // To use the springy bounce on close too, replace with: _ease_out_back(anim_t)
    scale = _ease_out_quad(anim_t);
}


// ── LAYOUT UPDATE ─────────────────────────────────────────────────────────────
// Multiply base (unscaled) dimensions by scale to get actual GUI-space positions.
// All positions scale outward from (cx, cy), so the animation expands from center.

panel_draw_w = panel_base_w * scale;
panel_draw_h = panel_base_h * scale;

// Button row Y: near the bottom of the panel.
// btn_margin_bottom and btn_h are in unscaled space, then multiplied by scale.
var _btn_row_y = cy + (panel_base_h / 2 - btn_margin_bottom - btn_h / 2) * scale;

// The two buttons are centered horizontally around cx, separated by btn_gap.
// Each button center is (btn_gap/2 + btn_w/2) away from center — one left, one right.
btn_confirm_cx = cx - (btn_gap / 2 + btn_w / 2) * scale;
btn_confirm_cy = _btn_row_y;
btn_cancel_cx  = cx + (btn_gap / 2 + btn_w / 2) * scale;
btn_cancel_cy  = _btn_row_y;

// Drawn button size
btn_draw_w = btn_w * scale;
btn_draw_h = btn_h * scale;


// ── INPUT (only when fully open) ──────────────────────────────────────────────
// Input is disabled during open/close animation to prevent accidental clicks.

if (state == "idle") {

    // ── MOUSE HOVER ──────────────────────────────────────────────────────────
    // Convert raw mouse position into GUI space (important if the game has a
    // different resolution than the display, e.g. 480x270 rendered at 1080p).
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Check if the mouse cursor is inside each button's drawn rectangle.
    hover_confirm = point_in_rectangle(_mx, _my,
        btn_confirm_cx - btn_draw_w / 2, btn_confirm_cy - btn_draw_h / 2,
        btn_confirm_cx + btn_draw_w / 2, btn_confirm_cy + btn_draw_h / 2);

    hover_cancel = point_in_rectangle(_mx, _my,
        btn_cancel_cx - btn_draw_w / 2, btn_cancel_cy - btn_draw_h / 2,
        btn_cancel_cx + btn_draw_w / 2, btn_cancel_cy + btn_draw_h / 2);

    // Keep keyboard focus synced with mouse hover.
    // This means if the player switches from mouse to keyboard, focus starts
    // on whichever button they were hovering, not always the default.
    if (hover_confirm) focused_btn = 0;
    if (hover_cancel)  focused_btn = 1;

    // ── MOUSE CLICK ──────────────────────────────────────────────────────────
    if (mouse_check_button_pressed(mb_left)) {
        if (hover_confirm) _do_confirm();
        if (hover_cancel)  _do_cancel();
    }

    // ── KEYBOARD / GAMEPAD ───────────────────────────────────────────────────
    // Left/right verbs (arrow keys, A/D, or D-pad) move keyboard focus.
    // Pressing either direction toggles between the two buttons.
    if (input_check_pressed("left") || input_check_pressed("right")) {
        focused_btn = (focused_btn == 0) ? 1 : 0;
    }

    // The "accept" verb (Enter / gamepad South button) fires the focused button.
    if (input_check_pressed("accept")) {
        if (focused_btn == 0) {
            _do_confirm();
        } else {
            _do_cancel();
        }
    }

    // The "cancel" verb (Backspace / gamepad East button) always cancels,
    // regardless of which button is focused. This matches player expectations:
    // pressing "back" should always dismiss, never accidentally confirm.
    if (input_check_pressed("cancel")) {
        _do_cancel();
    }

}
