// Draw the panel background sprite — skipped safely until the sprite is created in the IDE
var _panel_bg = asset_get_index("spr_garden_seed_panel");
if (_panel_bg >= 0) draw_sprite(_panel_bg, 0, panel_x, panel_y);

// Draw each seed slot
for (var _s = 0; _s < array_length(known_seeds); _s++) {
    var _type = known_seeds[_s];
    var _qty  = inventory_get_quantity(_type);

    // Top-left corner of this slot
    var _sx = panel_x + _s * (slot_w + slot_gap);
    var _sy = panel_y;

    // Dim out-of-stock slots so the player knows they can't drag from them
    var _alpha = (_qty > 0) ? 1.0 : 0.4;

    // Draw seed icon centred in the slot
    // Swap spr_food_basic for a dedicated seed sprite once you have one
    draw_sprite_ext(spr_food_basic, 0, _sx + slot_w / 2, _sy + slot_w / 2, 1, 1, 0, c_white, _alpha);

    // Quantity label in the bottom-left of the slot using Scribble
    // The "x" prefix makes it read like "x3" — adjust the offset if needed
    draw_text_scribble(_sx + 4, _sy + slot_w - 16, "x" + string(_qty));
}

// DEBUG: insta-grow button — remove this block when done testing
draw_set_color(c_red);
draw_rectangle(debug_grow_btn_x, debug_grow_btn_y,
    debug_grow_btn_x + debug_grow_btn_size, debug_grow_btn_y + debug_grow_btn_size, false);
draw_set_color(c_white);
draw_rectangle(debug_grow_btn_x, debug_grow_btn_y,
    debug_grow_btn_x + debug_grow_btn_size, debug_grow_btn_y + debug_grow_btn_size, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_scribble(
    debug_grow_btn_x + debug_grow_btn_size / 2,
    debug_grow_btn_y + debug_grow_btn_size / 2,
    "GROW");
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw the watering can button
// Highlighted (cyan) when watering mode is active, dark otherwise
// Replace with draw_sprite once you have spr_garden_watering_can in the IDE
var _water_spr = asset_get_index("spr_garden_watering_can");
if (_water_spr >= 0) {
    // Use the sprite if it exists, tint it cyan when active
    var _tint = global.garden_watering_mode ? c_aqua : c_white;
    draw_sprite_ext(_water_spr, 0,
        watering_btn_x + watering_btn_size / 2,
        watering_btn_y + watering_btn_size / 2,
        1, 1, 0, _tint, 1);
} else {
    // Fallback: draw a colored rectangle so the button is still visible and usable
    draw_set_color(global.garden_watering_mode ? c_aqua : c_dkgray);
    draw_rectangle(watering_btn_x, watering_btn_y,
        watering_btn_x + watering_btn_size, watering_btn_y + watering_btn_size, false);
    draw_set_color(c_white);
    draw_rectangle(watering_btn_x, watering_btn_y,
        watering_btn_x + watering_btn_size, watering_btn_y + watering_btn_size, true);
    // Label so the player knows what it is before the sprite exists
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_scribble(
        watering_btn_x + watering_btn_size / 2,
        watering_btn_y + watering_btn_size / 2,
        "Water");
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
