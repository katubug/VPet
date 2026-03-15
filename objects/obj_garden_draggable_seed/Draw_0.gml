// Draw the seed semi-transparent so the player can see what's underneath
// Replace spr_seed_draggable with a dedicated ghost/drag sprite in the IDE
var _drag_spr = asset_get_index("spr_seed_draggable");
if (_drag_spr >= 0) draw_sprite_ext(_drag_spr, 0, x, y, 1, 1, 0, c_white, 0.7);
