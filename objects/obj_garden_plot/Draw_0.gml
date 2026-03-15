var _stage = garden_get_stage(plot_index);

// --- Layer 1: Plot soil sprite ---
// Switches to the watered sprite for exactly 1 hour after watering (while boost is active)
// asset_get_index returns -1 if the sprite hasn't been created in the IDE yet — skip drawing safely
var _plot_spr = garden_boost_active(plot_index)
    ? asset_get_index("spr_garden_plot_watered")
    : asset_get_index("spr_garden_plot");
if (_plot_spr >= 0) draw_sprite_ext(_plot_spr, 0, x, y, 1, 1, 0, c_white, 1);

// --- Layer 2: Plant sprite drawn on top of the soil ---
// Sprout (stage 1) is shared across all plants — use spr_garden_sprout for a generic seedling look
// Stages 2 and 3 use per-seed sprites from the item database
// Set sprite origins to center-bottom in the IDE so plants appear to grow up from the soil
if (_stage >= 1) {
    var _seed_data = inventory_get_item_data(global.game.garden_plots[plot_index].seed_type);
    var _plant_spr = asset_get_index("spr_garden_sprout"); // shared sprout for stage 1
    if (_stage == 2) _plant_spr = _seed_data.sprite_immature;
    if (_stage == 3) _plant_spr = _seed_data.sprite_mature;
    // Skip drawing if the sprite hasn't been created in the IDE yet (-1 = not found)
    if (_plant_spr >= 0) draw_sprite_ext(_plant_spr, 0, x, y, 1, 1, 0, c_white, 1);
}

// --- Layer 3: Hover highlight overlay ---
var _hover_spr = asset_get_index("spr_garden_plot_hover");
if (_hover && _hover_spr >= 0) draw_sprite(_hover_spr, 0, x, y);

// --- Layer 4: Growth progress bar below the plot ---
// Adjust the y offsets (+34 to +39) and width (76px) to match your sprite size
if (_stage >= 1) {
    var _grow_time = inventory_get_item_data(global.game.garden_plots[plot_index].seed_type).grow_time;
    var _pct = garden_get_effective_growth(plot_index) / _grow_time;

    draw_set_color(c_dkgray);
    draw_rectangle(x - 38, y + 34, x + 38, y + 39, false);

    draw_set_color(c_lime);
    draw_rectangle(x - 38, y + 34, x - 38 + (76 * _pct), y + 39, false);

    draw_set_color(c_white); // reset color so nothing else inherits it
}
