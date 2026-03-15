// Position of the panel — adjust to fit your room layout
panel_x  = 60;
panel_y  = 820;

// Width of each seed slot in pixels (also used as height — square slots)
slot_w   = 80;

// Gap between slots in pixels
slot_gap = 10;

// Auto-populate from the item database — scan for every item with category "seed"
// To add a new plant: just add its seed entry to scr_inventory_system; nothing to change here
known_seeds = [];
var _db_keys = variable_struct_get_names(global.item_database);
for (var _k = 0; _k < array_length(_db_keys); _k++) {
    var _item = global.item_database[$ _db_keys[_k]];
    if (_item.category == "seed") array_push(known_seeds, _item.id);
}

// Reference to the currently-live draggable seed instance (noone = nothing being dragged)
active_drag = noone;

// Watering can button — positioned to the right of the seed slots
watering_btn_x = panel_x + array_length(known_seeds) * (slot_w + slot_gap) + slot_gap;
watering_btn_y = panel_y;
watering_btn_size = slot_w;

// DEBUG: insta-grow button — remove this block when done testing
debug_grow_btn_x = watering_btn_x + watering_btn_size + slot_gap;
debug_grow_btn_y = panel_y;
debug_grow_btn_size = slot_w;
