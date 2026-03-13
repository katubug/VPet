/// @description Initialize the dialog modal

// ─────────────────────────────────────────────────────────────────────────────
// HOW TO SPAWN THIS DIALOG
// ─────────────────────────────────────────────────────────────────────────────
// Call this from anywhere (a button click, a Step event, etc.):
//
//   var _dlg = instance_create_layer(0, 0, "UI", obj_dialog_modal);
//   _dlg.message = "Are you sure you want to do this?";
//
//   // Add as many buttons as you need with array_push:
//   array_push(_dlg.buttons, { label: "OK",     callback: function() { room_goto(rm_rps); } });
//   array_push(_dlg.buttons, { label: "Cancel", callback: function() { /* do nothing */ } });
//   array_push(_dlg.buttons, { label: "Later",  callback: function() { /* snooze logic */ } });
//
// Rules:
//   - Buttons appear left to right in the order you push them.
//   - The callback runs when the player clicks/confirms that button.
//   - Callbacks are optional — omit the key or set it to undefined if not needed.
//   - Works best with 1–3 buttons. More than 3 may overflow narrow panels.
// ─────────────────────────────────────────────────────────────────────────────


// ── SCREEN CENTER ────────────────────────────────────────────────────────────
// The dialog always centers on the GUI canvas.
// Stored once here since GUI dimensions don't change during a session.
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
cx    = gui_w / 2;   // horizontal center of the screen
cy    = gui_h / 2;   // vertical center of the screen


// ── PANEL SETTINGS ───────────────────────────────────────────────────────────
// panel_padding: space in pixels between content and the panel edges.
//   Increase this to give everything more breathing room.
// panel_min_w / panel_min_h: the dialog won't shrink below these sizes,
//   even for very short messages.
panel_padding = 24;
panel_min_w   = 220;
panel_min_h   = 130;


// ── BUTTON SETTINGS ──────────────────────────────────────────────────────────
// btn_w / btn_h: size of every button. All buttons share the same size.
//   spr_ui_button is nine-sliced so it stretches cleanly to any dimensions.
// btn_gap: horizontal space between buttons.
// btn_margin_bottom: how far the button row sits from the panel's bottom edge.
btn_w             = 90;
btn_h             = 30;
btn_gap           = 12;
btn_margin_bottom = 14;


// ── BUTTONS ARRAY ─────────────────────────────────────────────────────────────
// This is the list of buttons the dialog will display.
// Populate it with array_push after spawning (see HOW TO SPAWN above).
//
// Each entry is a struct with:
//   label    {string}   — the text drawn on the button
//   callback {function} — called when this button is activated (optional)
//
// Internal fields written by Step each frame (don't set these manually):
//   cx, cy   {number}   — button center position in GUI space (set by Step)
//   hover    {bool}     — true when the mouse is over this button (set by Step)
buttons = [];


// ── KEYBOARD FOCUS ────────────────────────────────────────────────────────────
// Index into the buttons array of whichever button the keyboard/gamepad is on.
// Left/right verbs move it. Mouse hover also updates it so they stay in sync.
// Starts on the first button (index 0).
focused_btn = 0;


// ── MESSAGE ──────────────────────────────────────────────────────────────────
// The message displayed in the dialog. Set this after spawning.
message = "Are you sure?";   // default fallback — always override this


// ── LAYOUT CACHE ─────────────────────────────────────────────────────────────
// Recomputed every Step and shared between Step (input) and Draw GUI.
// You don't need to set these — they update automatically.
panel_base_w = 0;   // unscaled panel width  (derived from text + buttons + padding)
panel_base_h = 0;   // unscaled panel height
panel_draw_w = 0;   // actual drawn width  = panel_base_w * scale
panel_draw_h = 0;   // actual drawn height = panel_base_h * scale
btn_draw_w   = 0;   // drawn button width  = btn_w * scale
btn_draw_h   = 0;   // drawn button height = btn_h * scale


// ── ANIMATION ────────────────────────────────────────────────────────────────
// The dialog pops in using an "ease-out back" curve — a springy overshoot
// that gives it a satisfying, juicy feel.
//
// anim_speed: frames the open/close animation takes.
//   At 60fps:  8 ≈ 0.13s  |  12 ≈ 0.20s  |  18 ≈ 0.30s
//
// state: the dialog's lifecycle.
//   "opening" → animating in
//   "idle"    → fully open, accepting input
//   "closing" → animating out
anim_speed = 12;
anim_t     = 0;          // 0.0 = invisible, 1.0 = full size
scale      = 0;          // draw scale this frame, derived from anim_t
state      = "opening";


// ── INPUT BLOCKING ───────────────────────────────────────────────────────────
// Tells the rest of the game "a dialog is open — ignore input."
// Wrap input in other objects like:
//
//   if (!global.dialog_open) {
//       // your input code here
//   }
//
// Cleared automatically in the CleanUp event when this object is destroyed.
global.dialog_open = true;


// ── DEPTH ────────────────────────────────────────────────────────────────────
// Lower depth = drawn on top. -9999 should beat everything else.
// Lower this further if something still appears above the dialog.
depth = -9999;


// ── LOCAL HELPER FUNCTIONS ───────────────────────────────────────────────────

// _ease_out_back(t)
//   Springy curve that overshoots 1.0 slightly before settling.
//   This is the "pop" feel on open.
//   Increase the 1.70158 constant for a bigger bounce, decrease for less.
_ease_out_back = function(t) {
    var c1 = 1.70158;
    var c3 = c1 + 1;
    return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
};

// _ease_out_quad(t)
//   Gentle deceleration. Used for the close animation.
//   Swap with _ease_out_back() in Step if you want a springy close too.
_ease_out_quad = function(t) {
    return 1 - (1 - t) * (1 - t);
};

// _do_activate(idx)
//   Fires the callback of buttons[idx], then starts the close animation.
//   Called by both mouse clicks and keyboard/gamepad confirm.
_do_activate = function(idx) {
    var _btn = buttons[idx];
    if (struct_exists(_btn, "callback") && is_callable(_btn.callback)) {
        _btn.callback();
    }
    state  = "closing";
    anim_t = 1;
};
