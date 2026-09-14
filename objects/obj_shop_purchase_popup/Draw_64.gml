/// @description Draw the purchase popup

// ── SCALE HELPER ─────────────────────────────────────────────────────────────
// All positions are defined in panel-local space (0,0 = panel top-left).
// _sx / _sy convert a local coordinate to screen GUI space, scaling from center.
// This makes the pop-in animation work: the panel grows from the screen center.
//
// NOTE: I use the instance variable `scale` directly here (not a local var)
// because GML anonymous functions can't capture outer local vars — only
// instance variables and globals are accessible inside lambdas.

// Convert local X (from panel left edge) to screen GUI X
var _sx = function(lx) { return cx + (lx - popup_w * 0.5) * scale; };

// Convert local Y (from panel top edge) to screen GUI Y
var _sy = function(ly) { return cy + (ly - popup_h * 0.5) * scale; };


// ── DIM OVERLAY ──────────────────────────────────────────────────────────────
// Semi-transparent black behind the panel to focus attention on it.
// Reduce the alpha (0.6) to make the shop grid visible underneath.
draw_set_alpha(0.6 * scale); // fade in with the animation
draw_set_color(c_black);
draw_rectangle(0, 0, gui_w, gui_h, false);
draw_set_alpha(1);


// ── PANEL BACKGROUND ─────────────────────────────────────────────────────────
// Dark box that holds all popup content.
draw_set_alpha(0.97);
draw_set_color(col_bg);
draw_rectangle(_sx(0), _sy(0), _sx(popup_w), _sy(popup_h), false);
draw_set_alpha(1);

// Panel border — two nested outlines for a slightly chunky look
draw_set_color(col_border);
draw_rectangle(_sx(0),   _sy(0),   _sx(popup_w),   _sy(popup_h),   true);
draw_rectangle(_sx(1),   _sy(1),   _sx(popup_w-1), _sy(popup_h-1), true);


// ── DIVIDER LINE ─────────────────────────────────────────────────────────────
// Sits between the content area (sprite + info) and the quantity row.
// Local Y = 90: qty_y1(95) - 5 breathing room = 90.
draw_set_color(make_color_rgb(70, 70, 90));
draw_line(_sx(pad), _sy(90), _sx(popup_w - pad), _sy(90)); // 360 ÷ 4 = 90


// ── ITEM SPRITE ───────────────────────────────────────────────────────────────
// Fills the left side of the content area, 75×75 local px from (pad, pad).
// spr_sc scales the sprite to fill 80% of that box, then scales again with
// the panel's pop-in animation.
var sprite_area_size = 75; // local px (300 ÷ 4 = 75)

if (item_data != undefined && sprite_exists(item_data.sprite)) {
    var spr     = item_data.sprite;
    var max_dim = max(sprite_get_width(spr), sprite_get_height(spr));
    var spr_sc  = (sprite_area_size * 0.8 / max_dim) * scale; // 80% fill × anim scale
    var spr_cx  = _sx(pad + sprite_area_size * 0.5); // center X of the icon box
    var spr_cy  = _sy(pad + sprite_area_size * 0.5); // center Y of the icon box

    // Faint backing box so the sprite pops against the dark panel
    draw_set_alpha(0.12);
    draw_set_color(c_white);
    draw_rectangle(_sx(pad), _sy(pad), _sx(pad + sprite_area_size), _sy(pad + sprite_area_size), false);
    draw_set_alpha(1);

    draw_sprite_ext(spr, 0, spr_cx, spr_cy, spr_sc, spr_sc, 0, c_white, 1);
}


// ── ITEM INFO ─────────────────────────────────────────────────────────────────
// Name, price, total, stock, and description sit to the right of the sprite.
// info_x: local X where the text column starts (pad + sprite + gap = 8+75+5 = 88).
// line_h: vertical gap between lines at txt_scale.
// info_w: available column width in local px.
var txt_scale = 1.5;  // render text at this multiple of the base font size
var info_x    = 88;   // local X of the text column (350 ÷ 4 ≈ 88)
var line_h    = 8;    // local-px line spacing (33 ÷ 4 ≈ 8)
var info_w    = popup_w - pad - info_x; // available column width in local px

draw_set_font(fnt_Quicksand);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (item_data != undefined) {

    // Item name
    draw_set_color(c_white);
    draw_text_transformed(_sx(info_x), _sy(pad), item_data.name, txt_scale, txt_scale, 0);

    // Price per unit — green if affordable, red if not
    var can_afford = (global.game.corns >= item_data.buy_price);
    draw_set_color(can_afford ? c_lime : c_red);
    draw_text_transformed(_sx(info_x), _sy(pad + line_h), "Price: " + string(item_data.buy_price) + "c", txt_scale, txt_scale, 0);

    // Total cost for the selected quantity
    var total_cost = item_data.buy_price * quantity;
    draw_set_color((global.game.corns >= total_cost) ? c_lime : c_red);
    draw_text_transformed(_sx(info_x), _sy(pad + line_h * 2), "Total: " + string(total_cost) + "c", txt_scale, txt_scale, 0);

    // Stock remaining
    var stock_str = (shop_item != undefined)
        ? ((shop_item.stock < 0) ? "Stock: Unlimited" : "Stock: " + string(shop_item.stock))
        : "Stock: ?";
    draw_set_color(c_ltgray);
    draw_text_transformed(_sx(info_x), _sy(pad + line_h * 3), stock_str, txt_scale, txt_scale, 0);

    // Description — wraps to fit the column.
    draw_set_color(c_white);
    draw_set_alpha(0.85);
    draw_text_ext_transformed(
        _sx(info_x), _sy(pad + line_h * 4),
        item_data.description,
        line_h / txt_scale,   // separator in unscaled font px
        info_w / txt_scale,   // wrap width  in unscaled font px
        txt_scale, txt_scale, 0
    );
    draw_set_alpha(1);

} else {
    // Fallback while item_data hasn't loaded yet (shouldn't appear for more than 1 frame)
    draw_set_color(c_ltgray);
    draw_text_transformed(_sx(info_x), _sy(pad), "Loading...", txt_scale, txt_scale, 0);
}


// ── QUANTITY ROW ─────────────────────────────────────────────────────────────
// Five elements centered horizontally in popup_w=175.
// Local Y: qy1=95, qy2=110  (kept in sync with Step_0.gml)
// Local X: qx=43 — total row = 15*4+3*3+20 = 89, centered at 87.5.
//
// The source sprites are 20×20; the btn_sc below renders them to the right size.

var qy1 = 95;  // local Y top    of quantity row (380 ÷ 4)
var qy2 = 110; // local Y bottom of quantity row (440 ÷ 4)
var qx  = 43;  // local X of leftmost qty button (166 ÷ 4 ≈ 43)
var btn_sc = (sbtn_w / 20.0) * scale; // scale 20px sprite to sbtn_w display, × anim scale

// Draw the four sprite buttons — X offsets match rect_* in Step_0.gml.
// Tints orange on hover.
draw_sprite_ext(spr_btn_left_ten,  0, _sx(qx + 7),  _sy(qy1 + 7), btn_sc, btn_sc, 0, hov_m10 ? c_orange : c_white, 1); // [-10] center
draw_sprite_ext(spr_btn_left_one,  0, _sx(qx + 25), _sy(qy1 + 7), btn_sc, btn_sc, 0, hov_m1  ? c_orange : c_white, 1); // [-1]  center
draw_sprite_ext(spr_btn_right_one, 0, _sx(qx + 66), _sy(qy1 + 7), btn_sc, btn_sc, 0, hov_p1  ? c_orange : c_white, 1); // [+1]  center
draw_sprite_ext(spr_btn_right_ten, 0, _sx(qx + 84), _sy(qy1 + 7), btn_sc, btn_sc, 0, hov_p10 ? c_orange : c_white, 1); // [+10] center

// Quantity display box — sits between the - and + groups.
draw_set_color(col_disp);
draw_rectangle(_sx(qx + 36), _sy(qy1), _sx(qx + 56), _sy(qy2), false);
draw_set_color(col_border);
draw_rectangle(_sx(qx + 36), _sy(qy1), _sx(qx + 56), _sy(qy2), true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed(
    (_sx(qx + 36) + _sx(qx + 56)) * 0.5,
    (_sy(qy1) + _sy(qy2)) * 0.5,
    string(quantity), // current quantity the player has selected
    txt_scale, txt_scale, 0
);


// ── ACTION BUTTONS (Cancel / Confirm) ────────────────────────────────────────
// Local Y: act_y1=115, act_y2=127  (matched from Step_0.gml)
// Local X: cancel 48–85, confirm 89–126  (centered in 175px panel)

// Cancel button
draw_set_color(hov_can ? col_cancel_h : col_cancel);
draw_rectangle(_sx(48), _sy(115), _sx(85), _sy(127), false);
draw_set_color(col_border);
draw_rectangle(_sx(48), _sy(115), _sx(85), _sy(127), true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed((_sx(48) + _sx(85)) * 0.5, (_sy(115) + _sy(127)) * 0.5, "Cancel", txt_scale, txt_scale, 0);

// Confirm button — dims when the player can't afford even 1 unit
var can_buy   = (item_data != undefined && global.game.corns >= item_data.buy_price);
var con_alpha = can_buy ? 1.0 : 0.45;
draw_set_alpha(con_alpha);
draw_set_color(hov_con ? col_confirm_h : col_confirm);
draw_rectangle(_sx(89), _sy(115), _sx(126), _sy(127), false);
draw_set_color(col_border);
draw_rectangle(_sx(89), _sy(115), _sx(126), _sy(127), true);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(can_buy ? c_white : c_ltgray);
draw_set_alpha(con_alpha);
draw_text_transformed((_sx(89) + _sx(126)) * 0.5, (_sy(115) + _sy(127)) * 0.5, "Buy x" + string(quantity), txt_scale, txt_scale, 0);
draw_set_alpha(1);


// ── RESET DRAW STATE ─────────────────────────────────────────────────────────
// Always reset these so other Draw events aren't affected by leftover settings.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
