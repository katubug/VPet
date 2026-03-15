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
// Local Y = 360: qty_y1(380) - 20 breathing room = 360.
// Change this value if the layout above or below shifts.
draw_set_color(make_color_rgb(70, 70, 90));
draw_line(_sx(pad), _sy(360), _sx(popup_w - pad), _sy(360));


// ── ITEM SPRITE ───────────────────────────────────────────────────────────────
// Fills the left side of the content area, 300×300 local px from (pad, pad).
// spr_sc scales the sprite to fill 80% of that box, then scales again with
// the panel's pop-in animation.
var sprite_area_size = 300; // local px — change this if I resize the icon area

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
// Text is drawn at 2× scale via draw_text_transformed / draw_text_ext_transformed.
// info_x: local X where the text column starts (pad + sprite + gap = 30+300+20 = 350).
// line_h: vertical gap between lines at 2× scale (~22 font px × 2 = 44 screen px local).
// info_w: available column width in local px; halved when passed to draw_text_ext_transformed
//         because the font measures in unscaled px but renders at 2×.
var txt_scale = 2;    // render text at this multiple of the base font size
var info_x    = 350;  // local X of the text column (pad=30 + sprite=300 + gap=20)
var line_h    = 44;   // local-px line spacing at 2× text scale
var info_w    = popup_w - pad - info_x; // available column width in local px (= 320)

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
    // Pass info_w/txt_scale so the wrap boundary is in unscaled font px,
    // which draw_text_ext_transformed then renders at txt_scale on screen.
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
// Five elements centered horizontally in popup_w=700.
// Local Y: qty_y1=380, qty_y2=440  (kept in sync with Step_0.gml)
// Local X: qx=166 — total row = 60*4+12*3+80 = 368, centered at 350.
//
// The source sprites are 20×20; drawing them at 3×scale renders them at 60px.

var qy1 = 380; // local Y top    of quantity row
var qy2 = 440; // local Y bottom of quantity row
var qx  = 166; // local X of leftmost qty button
var btn_sc = 3.0 * scale; // 20px sprite × 3 = 60px display, × anim scale for pop-in

// Draw the four sprite buttons — X offsets match rect_* in Step_0.gml.
// Tints orange on hover. Inlined to avoid GML lambda capture issues.
draw_sprite_ext(spr_btn_left_ten,  0, _sx(qx + 30),       _sy(qy1 + 30), btn_sc, btn_sc, 0, hov_m10 ? c_orange : c_white, 1); // [-10] center at local (196, 410)
draw_sprite_ext(spr_btn_left_one,  0, _sx(qx + 102),      _sy(qy1 + 30), btn_sc, btn_sc, 0, hov_m1  ? c_orange : c_white, 1); // [-1]  center at local (268, 410) (72+30=102)
draw_sprite_ext(spr_btn_right_one, 0, _sx(qx + 266),      _sy(qy1 + 30), btn_sc, btn_sc, 0, hov_p1  ? c_orange : c_white, 1); // [+1]  center at local (432, 410) (236+30=266)
draw_sprite_ext(spr_btn_right_ten, 0, _sx(qx + 338),      _sy(qy1 + 30), btn_sc, btn_sc, 0, hov_p10 ? c_orange : c_white, 1); // [+10] center at local (504, 410) (308+30=338)

// Quantity display box — sits between the - and + groups.
// Local X: qx+144=310 to qx+224=390  (matched from Step_0.gml rect_disp)
draw_set_color(col_disp);
draw_rectangle(_sx(qx + 144), _sy(qy1), _sx(qx + 224), _sy(qy2), false);
draw_set_color(col_border);
draw_rectangle(_sx(qx + 144), _sy(qy1), _sx(qx + 224), _sy(qy2), true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed(
    (_sx(qx + 144) + _sx(qx + 224)) * 0.5,
    (_sy(qy1) + _sy(qy2)) * 0.5,
    string(quantity), // current quantity the player has selected
    txt_scale, txt_scale, 0
);


// ── ACTION BUTTONS (Cancel / Confirm) ────────────────────────────────────────
// Local Y: act_y1=460, act_y2=510  (matched from Step_0.gml)
// Local X: cancel 192–342, confirm 358–508  (centered in 700px panel)

// Cancel button
draw_set_color(hov_can ? col_cancel_h : col_cancel);
draw_rectangle(_sx(192), _sy(460), _sx(342), _sy(510), false);
draw_set_color(col_border);
draw_rectangle(_sx(192), _sy(460), _sx(342), _sy(510), true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text_transformed((_sx(192) + _sx(342)) * 0.5, (_sy(460) + _sy(510)) * 0.5, "Cancel", txt_scale, txt_scale, 0);

// Confirm button — dims when the player can't afford even 1 unit
var can_buy   = (item_data != undefined && global.game.corns >= item_data.buy_price);
var con_alpha = can_buy ? 1.0 : 0.45;
draw_set_alpha(con_alpha);
draw_set_color(hov_con ? col_confirm_h : col_confirm);
draw_rectangle(_sx(358), _sy(460), _sx(508), _sy(510), false);
draw_set_color(col_border);
draw_rectangle(_sx(358), _sy(460), _sx(508), _sy(510), true);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(can_buy ? c_white : c_ltgray);
draw_set_alpha(con_alpha);
draw_text_transformed((_sx(358) + _sx(508)) * 0.5, (_sy(460) + _sy(510)) * 0.5, "Buy x" + string(quantity), txt_scale, txt_scale, 0);
draw_set_alpha(1);


// ── RESET DRAW STATE ─────────────────────────────────────────────────────────
// Always reset these so other Draw events aren't affected by leftover settings.
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
