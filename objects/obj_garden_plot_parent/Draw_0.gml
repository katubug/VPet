var _stage = garden_get_stage(plot_index);

// --- Layer 1: Plot soil sprite ---
// Frame 0 = dry, frame 1 = watered — switches to watered for 1 hour after watering
image_index = garden_boost_active(plot_index) ? 1 : 0;
draw_self(); // draws the child's assigned sprite at (x, y) using its built-in origin

// --- Layer 2: Plant sprite drawn on top of the soil ---
// Sprout (stage 1) is shared across all plants — use spr_garden_sprout for a generic seedling look
// Stages 2 and 3 use per-seed sprites from the item database
// Plants draw at the tile's center so they appear to grow from the middle
if (_stage >= 1) {
    var _seed_data = inventory_get_item_data(global.game.garden_plots[plot_index].seed_type);
    var _plant_spr = asset_get_index("spr_garden_sprout"); // shared sprout for stage 1
    if (_stage == 2) _plant_spr = _seed_data.sprite_immature;
    if (_stage == 3) _plant_spr = _seed_data.sprite_mature;
    // Skip drawing if the sprite hasn't been created in the IDE yet (-1 = not found)
    if (_plant_spr >= 0) draw_sprite_ext(_plant_spr, 0, x + _half_w, y - _half_h, 1, 1, 0, c_white, 1);
}

// --- Layer 3: Hover highlight overlay ---
// spr_garden_plot_hover has center origin, so draw at the tile's visual center
var _hover_spr = asset_get_index("spr_garden_plot_hover");
if (_hover && _hover_spr >= 0) draw_sprite(_hover_spr, 0, x + _half_w, y - _half_h);

// --- Layer 4: Growth progress bar below the tile ---
// _bar_pad adds inset margin on each side — increase to move bar away from tile edges
var _bar_pad = 4; // 4px inset from each edge
var _bar_x1  = x + _bar_pad;                    // left edge of the bar
var _bar_x2  = x + sprite_width - _bar_pad;      // right edge of the bar
var _bar_w   = _bar_x2 - _bar_x1;                // usable fill width in pixels

if (_stage >= 1) {
    var _grow_time = inventory_get_item_data(global.game.garden_plots[plot_index].seed_type).grow_time;
    var _pct = garden_get_effective_growth(plot_index) / _grow_time;

    // Bar sits just below the tile bottom edge (origin is bottom-left, so y = bottom)
    draw_set_color(c_dkgray);
    draw_rectangle(_bar_x1, y + 2, _bar_x2, y + 5, false);

    draw_set_color(c_lime);
    draw_rectangle(_bar_x1, y + 2, _bar_x1 + (_bar_w * _pct), y + 5, false);

    draw_set_color(c_white); // reset color so nothing else inherits it

    // Temporary debug: shows % over each plot bar
    draw_text(x, y + 7, string_format(_pct * 100, 3, 1) + "%");
}
