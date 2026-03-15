/// @description Initialize the shop purchase popup

// ── SCREEN CENTER ─────────────────────────────────────────────────────────────
// Cache GUI dimensions so I don't call display_get_gui_* every frame.
// Change cx/cy here if I ever want the popup to appear off-center.
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();
cx    = gui_w / 2;   // horizontal center
cy    = gui_h / 2;   // vertical center


// ── ITEM DATA (assigned by the spawner immediately after instance_create_depth) ─
// The spawner sets item_id and shop_item; item_data is loaded on the first Step
// once those values are populated.
item_id   = "";        // string ID of the item being purchased (e.g. "apple")
shop_item = undefined; // the shop_items[] struct entry — holds .stock
item_data = undefined; // full item record from inventory_get_item_data()


// ── QUANTITY ──────────────────────────────────────────────────────────────────
// How many of this item the player wants to buy.
// Capped to get_max_qty() whenever the +/- buttons are pressed.
quantity = 1;


// ── PANEL DIMENSIONS ─────────────────────────────────────────────────────────
// Adjust popup_w / popup_h to resize the whole panel.
// pad is the inset margin between the panel edge and its content.
popup_w = 700;  // total panel width  in GUI pixels
popup_h = 540;  // total panel height in GUI pixels
pad     = 30;   // inner padding on all sides


// ── SMALL +/- BUTTON SIZE ────────────────────────────────────────────────────
// The source sprites (spr_btn_left_one etc.) are 20×20.
// They're drawn at 3× scale to hit 60px — if the sprites are ever resized,
// update the draw call in Draw_64.gml (the 3.0 multiplier on `scale`).
sbtn_w   = 60;  // displayed width  of each +/- button (3× the 20px sprite)
sbtn_h   = 60;  // displayed height of each +/- button
sbtn_gap = 12;  // horizontal gap between buttons

// Width of the quantity display box that sits between the - and + groups.
qty_display_w = 80;


// ── ACTION BUTTON SIZE ────────────────────────────────────────────────────────
// Cancel and Confirm sit in the bottom row.
abtn_w   = 150; // width  of Cancel / Confirm
abtn_h   = 50;  // height of Cancel / Confirm
abtn_gap = 16;  // horizontal gap between Cancel and Confirm


// ── LAYOUT RECTS (computed every Step, read by Draw) ─────────────────────────
// Each rect is a struct { x1, y1, x2, y2 } in GUI screen space.
// They're recalculated in Step so I only need to define them once here.
rect_m10  = { x1:0, y1:0, x2:0, y2:0 }; // [-10] button
rect_m1   = { x1:0, y1:0, x2:0, y2:0 }; // [-1]  button
rect_disp = { x1:0, y1:0, x2:0, y2:0 }; // quantity display box (not a button)
rect_p1   = { x1:0, y1:0, x2:0, y2:0 }; // [+1]  button
rect_p10  = { x1:0, y1:0, x2:0, y2:0 }; // [+10] button
rect_can  = { x1:0, y1:0, x2:0, y2:0 }; // Cancel  button
rect_con  = { x1:0, y1:0, x2:0, y2:0 }; // Confirm button


// ── HOVER FLAGS ───────────────────────────────────────────────────────────────
// True when the mouse is inside that button's rect. Set every Step.
hov_m10 = false;
hov_m1  = false;
hov_p1  = false;
hov_p10 = false;
hov_can = false;
hov_con = false;


// ── COLORS ────────────────────────────────────────────────────────────────────
// Swap any of these out to re-theme the popup without touching layout code.
col_bg        = make_color_rgb(25, 25, 35);    // dark background panel
col_border    = c_white;                        // panel outline
col_disp      = make_color_rgb(40, 40, 60);    // qty display box background
col_confirm   = make_color_rgb(35, 110, 55);   // Confirm (normal)
col_confirm_h = make_color_rgb(55, 170, 85);   // Confirm (hovered)
col_cancel    = make_color_rgb(110, 35, 35);   // Cancel (normal)
col_cancel_h  = make_color_rgb(170, 55, 55);   // Cancel (hovered)


// ── POP-IN ANIMATION ─────────────────────────────────────────────────────────
// Same spring-ease style as obj_dialog_modal for consistency.
// anim_speed: lower = faster pop-in. At 60fps, 10 ≈ 0.17s.
anim_t     = 0;         // animation progress 0→1 (0 = hidden, 1 = full size)
anim_speed = 10;        // frames until fully open
state      = "opening"; // "opening" | "idle" | "closing"
scale      = 0;         // current draw scale, derived from anim_t each Step


// ── INPUT BLOCKING ────────────────────────────────────────────────────────────
// Tells any code that checks global.dialog_open to ignore player input.
// Cleared in CleanUp when this instance is destroyed.
global.dialog_open = true;
depth = -9998; // draw above almost everything (-9999 is obj_dialog_modal)


// ── EASING CURVES ────────────────────────────────────────────────────────────

// _ease_out_back: springy overshoot — gives the panel a satisfying "pop".
// Increase the 1.70158 constant for a bigger bounce.
_ease_out_back = function(t) {
    var c1 = 1.70158;
    var c3 = c1 + 1;
    return 1 + c3 * power(t - 1, 3) + c1 * power(t - 1, 2);
};

// _ease_out_quad: smooth deceleration for the closing animation.
_ease_out_quad = function(t) {
    return 1 - (1 - t) * (1 - t);
};


// ── MAX PURCHASABLE QUANTITY ──────────────────────────────────────────────────
// Returns how many of this item the player can afford right now,
// also capped by available stock. Always returns at least 1.
// I call this whenever the quantity is incremented so it stays valid.
get_max_qty = function() {
    if (item_data == undefined || shop_item == undefined) return 1;
    var price    = item_data.buy_price;
    var by_corns = (price > 0) ? floor(global.game.corns / price) : 9999;
    var by_stock = (shop_item.stock < 0) ? 9999 : shop_item.stock; // -1 = unlimited
    return max(1, min(by_corns, by_stock));
};
