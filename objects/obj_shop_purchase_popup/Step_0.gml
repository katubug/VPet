/// @description Handle popup input, layout, and animation

// ── LAZY-LOAD ITEM DATA ───────────────────────────────────────────────────────
// item_id and shop_item are assigned by the spawner AFTER Create runs,
// so I wait until the first Step to load item_data from the inventory system.
if (item_data == undefined && item_id != "") {
    item_data = inventory_get_item_data(item_id);
    quantity  = 1; // always start at 1 when the popup first opens
}


// ── ANIMATION ─────────────────────────────────────────────────────────────────
// Advance the animation timer and derive the current draw scale.
// Input is blocked during opening/closing so the player can't click mid-pop.

if (state == "opening") {
    anim_t = min(anim_t + 1 / anim_speed, 1); // count up to 1
    scale  = _ease_out_back(anim_t);           // springy overshoot curve
    if (anim_t >= 1) { state = "idle"; scale = 1; } // snap to 1 when done
    exit; // skip all input while the panel is animating in
}

if (state == "closing") {
    anim_t = max(anim_t - 1 / anim_speed, 0); // count down to 0
    scale  = _ease_out_quad(anim_t);           // smooth ease-out curve
    if (anim_t <= 0) { instance_destroy(); exit; } // destroy when invisible
    exit; // skip all input while closing
}


// ── LAYOUT (all positions are at scale = 1, in GUI screen space) ─────────────
// The button rects here are only used for input — Draw computes its own
// scaled positions from the same local offsets below.
//
// Local coordinate system: (0,0) = panel top-left, X right, Y down.
// To screen: screen_x = cx + (local_x - popup_w/2)
//            screen_y = cy + (local_y - popup_h/2)
//
// popup_w=700 (center=350), popup_h=540 (center=270)
// Adjust the local offsets here to reposition individual elements.

var px = cx - popup_w * 0.5; // panel left edge in screen space (cx - 350)
var py = cy - popup_h * 0.5; // panel top  edge in screen space (cy - 270)

// ── QUANTITY ROW ──────────────────────────────────────────────────────────────
// Sits above the action row.  Bottom-up calculation:
//   act_y2 = popup_h - pad       = 540-30 = 510
//   act_y1 = act_y2  - abtn_h   = 510-50 = 460
//   qty_y2 = act_y1  - pad      = 460-20 = 440  (20px breathing room)
//   qty_y1 = qty_y2  - sbtn_h   = 440-60 = 380
var qty_y1 = py + 380; // top    of quantity row
var qty_y2 = py + 440; // bottom of quantity row

// The five elements are centered horizontally in popup_w=700 (center=350).
// Total row width = sbtn_w*4 + sbtn_gap*3 + qty_display_w
//                = 60*4 + 12*3 + 80 = 240+36+80 = 356... wait
// Actually: 60+12+60+12+80+12+60+12+60 = 368
// Starts at center - 368/2 = 350 - 184 = 166
var qx = px + 166; // left edge of the first qty button in screen space

rect_m10  = { x1: qx,       y1: qty_y1, x2: qx + 60,  y2: qty_y2 }; // [-10] local 166–226
rect_m1   = { x1: qx + 72,  y1: qty_y1, x2: qx + 132, y2: qty_y2 }; // [-1]  local 238–298 (60+12=72)
rect_disp = { x1: qx + 144, y1: qty_y1, x2: qx + 224, y2: qty_y2 }; // disp  local 310–390 (132+12=144, +80)
rect_p1   = { x1: qx + 236, y1: qty_y1, x2: qx + 296, y2: qty_y2 }; // [+1]  local 402–462 (224+12=236)
rect_p10  = { x1: qx + 308, y1: qty_y1, x2: qx + 368, y2: qty_y2 }; // [+10] local 474–534 (296+12=308)


// ── ACTION ROW ────────────────────────────────────────────────────────────────
// Cancel and Confirm sit at the very bottom of the panel.
//   act_y1 = popup_h - pad - abtn_h = 540-30-50 = 460  (local)
//   act_y2 = popup_h - pad          = 540-30     = 510  (local)
var ay1 = py + 460; // top    of action buttons
var ay2 = py + 510; // bottom of action buttons

// Centered: total = abtn_w*2 + abtn_gap = 150+16+150 = 316, starts at 350-158 = 192
rect_can = { x1: px + 192, y1: ay1, x2: px + 342, y2: ay2 }; // Cancel  (192 to 342)
rect_con = { x1: px + 358, y1: ay1, x2: px + 508, y2: ay2 }; // Confirm (358 to 508)


// ── MOUSE INPUT ───────────────────────────────────────────────────────────────
var mx = device_mouse_x_to_gui(0); // mouse X in GUI space
var my = device_mouse_y_to_gui(0); // mouse Y in GUI space

// Update hover flags each frame for draw highlighting.
// Inlined directly — GML lambdas can't capture outer local vars like mx/my.
hov_m10 = (mx >= rect_m10.x1 && mx <= rect_m10.x2 && my >= rect_m10.y1 && my <= rect_m10.y2);
hov_m1  = (mx >= rect_m1.x1  && mx <= rect_m1.x2  && my >= rect_m1.y1  && my <= rect_m1.y2);
hov_p1  = (mx >= rect_p1.x1  && mx <= rect_p1.x2  && my >= rect_p1.y1  && my <= rect_p1.y2);
hov_p10 = (mx >= rect_p10.x1 && mx <= rect_p10.x2 && my >= rect_p10.y1 && my <= rect_p10.y2);
hov_can = (mx >= rect_can.x1 && mx <= rect_can.x2 && my >= rect_can.y1 && my <= rect_can.y2);
hov_con = (mx >= rect_con.x1 && mx <= rect_con.x2 && my >= rect_con.y1 && my <= rect_con.y2);


// ── CLICK HANDLING ────────────────────────────────────────────────────────────
if (mouse_check_button_pressed(mb_left)) {

    var max_qty = get_max_qty(); // how many the player can actually afford/buy

    // Decrement buttons — floor at 1 so the player can't go below 1
    if (hov_m10) quantity = max(1, quantity - 10);
    if (hov_m1)  quantity = max(1, quantity - 1);

    // Increment buttons — ceiling at max_qty so the player can't over-commit
    if (hov_p1)  quantity = min(max_qty, quantity + 1);
    if (hov_p10) quantity = min(max_qty, quantity + 10);

    // Cancel — close without buying anything
    if (hov_can) {
        state  = "closing";
        anim_t = 1; // start closing from full size
    }

    // Confirm — purchase `quantity` of the item via obj_shop_ui's purchase_item()
    if (hov_con && item_data != undefined) {
        var shop = instance_find(obj_shop_ui, 0); // grab the shop UI instance
        if (shop != noone) {
            // Buy one at a time so each call does its own stock/coin check.
            // If purchase_item() returns false mid-loop, stop early.
            for (var i = 0; i < quantity; i++) {
                if (!shop.purchase_item(item_id)) break;
            }
        }
        state  = "closing";
        anim_t = 1; // start closing after purchase
    }
}


// ── KEYBOARD: QUANTITY ADJUSTMENT ────────────────────────────────────────────
// Left/Right arrow = ±1, Up/Down arrow = ±10.
// Swap these input verbs to match whatever the input plugin uses.
if (state == "idle") {
    var max_qty = get_max_qty();
    if (input_check_pressed("left"))  quantity = max(1, quantity - 1);
    if (input_check_pressed("right")) quantity = min(max_qty, quantity + 1);
    if (input_check_pressed("down"))  quantity = max(1, quantity - 10);
    if (input_check_pressed("up"))    quantity = min(max_qty, quantity + 10);

    // Enter / Accept = confirm purchase
    if (input_check_pressed("accept") && item_data != undefined) {
        var shop = instance_find(obj_shop_ui, 0);
        if (shop != noone) {
            for (var i = 0; i < quantity; i++) {
                if (!shop.purchase_item(item_id)) break;
            }
        }
        state  = "closing";
        anim_t = 1;
    }

    // Escape / Cancel = close without buying
    if (input_check_pressed("cancel") || keyboard_check_pressed(vk_escape)) {
        state  = "closing";
        anim_t = 1;
    }
}
