/// @description Initialize the dialog modal

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO SPAWN THIS DIALOG
// ─────────────────────────────────────────────────────────────────────────────
// Call this from anywhere (a button click, a Step event, etc.):
//
//   var _dlg = instance_create_layer(0, 0, "UI", obj_dialog_modal);
//   _dlg.message    = "Are you sure you want to do this?";
//   _dlg.on_confirm = function() { /* runs when player hits OK     */ };
//   _dlg.on_cancel  = function() { /* runs when player hits Cancel */ };
//
// Both callbacks are optional — omit either one if you don't need it.
// ─────────────────────────────────────────────────────────────────────────────


// ── SCREEN CENTER ────────────────────────────────────────────────────────────
// The dialog always centers on the GUI canvas.
// Stored once here since GUI dimensions don't change during a session.
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
cx    = gui_w / 2;   // horizontal center of the screen
cy    = gui_h / 2;   // vertical center of the screen


// ── PANEL SETTINGS ───────────────────────────────────────────────────────────
// panel_padding: space in pixels between the text and the panel edges.
//   Increase this to give content more breathing room inside the box.
// panel_min_w / panel_min_h: the dialog won't shrink below these sizes,
//   even for very short messages.
panel_padding = 24;
panel_min_w   = 220;
panel_min_h   = 130;


// ── BUTTON SETTINGS ──────────────────────────────────────────────────────────
// btn_w / btn_h: size of each button. spr_ui_button is nine-sliced so it
//   stretches cleanly to any size — no blurry corners.
// btn_gap: horizontal space between the Confirm and Cancel buttons.
// btn_margin_bottom: how far from the panel's bottom edge the buttons sit.
btn_w             = 90;
btn_h             = 30;
btn_gap           = 12;
btn_margin_bottom = 14;


// ── BUTTON LABELS ─────────────────────────────────────────────────────────────
// Change these strings to rename the buttons.
// No other code needs to be updated — everything reads these variables.
btn_label_confirm = "OK";
btn_label_cancel  = "Cancel";


// ── ANIMATION ────────────────────────────────────────────────────────────────
// The dialog pops in using an "ease-out back" curve — a springy overshoot
// that gives it a satisfying, juicy feel.
//
// anim_speed: how many frames the open/close animation takes.
//   At 60fps:  8 ≈ 0.13s  |  12 ≈ 0.20s  |  18 ≈ 0.30s
//   Lower = snappier. Higher = floatier.
//
// state: tracks the dialog's lifecycle.
//   "opening" → animating in  (set automatically at Create)
//   "idle"    → fully open, accepting input
//   "closing" → animating out (triggered by confirm or cancel)
anim_speed = 12;
anim_t     = 0;          // animation progress: 0.0 = invisible, 1.0 = full size
scale      = 0;          // the draw scale this frame, derived from anim_t
state      = "opening";


// ── KEYBOARD FOCUS ────────────────────────────────────────────────────────────
// focused_btn tracks which button the keyboard/gamepad cursor is on.
//   0 = Confirm (left button)
//   1 = Cancel  (right button)
// The player moves between them with the left/right verbs.
// Mouse hover also updates this, so keyboard and mouse stay in sync.
focused_btn = 0;


// ── CALLBACKS ────────────────────────────────────────────────────────────────
// Set these externally right after spawning (see HOW TO SPAWN above).
// They should be anonymous functions: function() { ... }
message    = "Are you sure?";   // default fallback — always override this
on_confirm = undefined;
on_cancel  = undefined;


// ── LAYOUT CACHE ─────────────────────────────────────────────────────────────
// These are recomputed every step from the current scale and stored here
// so both the Step event (input) and Draw GUI event share the same numbers.
// You don't need to set these — they update automatically.
panel_base_w   = 0;   // unscaled panel width  (computed from text + padding)
panel_base_h   = 0;   // unscaled panel height
panel_draw_w   = 0;   // actual drawn width  = panel_base_w * scale
panel_draw_h   = 0;   // actual drawn height = panel_base_h * scale
btn_confirm_cx = 0;   // confirm button center X in GUI space
btn_confirm_cy = 0;   // confirm button center Y in GUI space
btn_cancel_cx  = 0;   // cancel button center X in GUI space
btn_cancel_cy  = 0;   // cancel button center Y in GUI space
btn_draw_w     = 0;   // drawn button width  = btn_w * scale
btn_draw_h     = 0;   // drawn button height = btn_h * scale


// ── HOVER STATE ──────────────────────────────────────────────────────────────
// Set each frame in Step based on mouse position. Read in Draw to tint buttons.
hover_confirm = false;
hover_cancel  = false;


// ── INPUT BLOCKING ───────────────────────────────────────────────────────────
// This global flag tells the rest of the game "a dialog is open — ignore input."
//
// Any object that should freeze while a dialog is open should wrap its input
// code like this:
//
//   if (!global.dialog_open) {
//       // your normal input code here
//   }
//
// The flag is cleared automatically in the CleanUp event when this object
// is destroyed. Make sure global.dialog_open is initialized to false in
// global_values.gml so it exists before any dialog is ever spawned.
global.dialog_open = true;


// ── DEPTH ────────────────────────────────────────────────────────────────────
// Lower depth = drawn on top. -9999 puts this above almost everything.
// If something still appears on top of the dialog, lower this number further.
depth = -9999;


// ── LOCAL HELPER FUNCTIONS ───────────────────────────────────────────────────
// These are instance methods so they have access to all instance variables.

// _ease_out_back(t)
//   A springy easing curve where the value overshoots 1.0 slightly before
//   settling. This is what gives the dialog its "pop" feel on open.
//   t:  0.0 → 1.0 (animation progress)
//   returns: scale value (will briefly exceed 1.0 at the overshoot peak)
//
//   The constant 1.70158 controls overshoot amount.
//   Increase it (e.g. 2.5) for a bigger bounce. Decrease (e.g. 0.8) for less.
_ease_out_back = function(t) {
    var c1 = 1.70158;
    var c3 = c1 + 1;
    return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
};

// _ease_out_quad(t)
//   A gentle deceleration curve. Used for the close animation so the dialog
//   smoothly shrinks away without bouncing.
//   Swap this with _ease_out_back() in Step if you want a springy close too.
_ease_out_quad = function(t) {
    return 1 - (1 - t) * (1 - t);
};

// _do_confirm()
//   Fires the on_confirm callback (if set) then starts the close animation.
_do_confirm = function() {
    if (is_callable(on_confirm)) on_confirm();
    state  = "closing";
    anim_t = 1;   // start closing from fully open
};

// _do_cancel()
//   Fires the on_cancel callback (if set) then starts the close animation.
_do_cancel = function() {
    if (is_callable(on_cancel)) on_cancel();
    state  = "closing";
    anim_t = 1;
};
