// DEBUG: insta-grow button — matures all planted plots instantly for testing
// Remove this block when done testing
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y,
        debug_grow_btn_x, debug_grow_btn_y,
        debug_grow_btn_x + debug_grow_btn_size, debug_grow_btn_y + debug_grow_btn_size)) {
        for (var _i = 0; _i < 9; _i++) {
            var _plot = global.game.garden_plots[_i];
            if (_plot.seed_type != "none") {
                // Wind back plant_time far enough that growth is 100%
                var _grow_time = inventory_get_item_data(_plot.seed_type).grow_time;
                _plot.plant_time  = garden_epoch_now() - _grow_time;
                _plot.bonus_seconds = 0;
                _plot.water_time  = -1;
                global.game.garden_plots[_i] = _plot;
            }
        }
        show_debug_message("DEBUG: all plots insta-grown to mature");
    }
}

// Toggle watering mode when the watering can button is clicked
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mouse_x, mouse_y,
        watering_btn_x, watering_btn_y,
        watering_btn_x + watering_btn_size, watering_btn_y + watering_btn_size)) {
        global.garden_watering_mode = !global.garden_watering_mode; // flip the toggle
    }
}

// Spawn a draggable seed when the player clicks on a slot with stock
// (only when not clicking the watering button, and not already dragging)
if (mouse_check_button_pressed(mb_left) && active_drag == noone) {
    for (var _s = 0; _s < array_length(known_seeds); _s++) {
        var _type = known_seeds[_s];
        var _qty  = inventory_get_quantity(_type);

        // Skip seeds we don't have any of
        if (_qty <= 0) continue;

        // Calculate the centre of this slot
        var _sx = panel_x + _s * (slot_w + slot_gap) + slot_w / 2;
        var _sy = panel_y + slot_w / 2;

        // Check if the click landed inside this slot's circular hit area
        if (point_in_circle(mouse_x, mouse_y, _sx, _sy, slot_w / 2)) {
            // Create a ghost seed that follows the mouse — do NOT remove from inventory yet
            var _d = instance_create_depth(mouse_x, mouse_y, -9999, obj_garden_draggable_seed);
            _d.seed_type = _type;
            active_drag  = _d;
            break; // only spawn one draggable at a time
        }
    }
}

// Clear the drag reference once the draggable destroys itself on release
if (active_drag != noone && !instance_exists(active_drag)) {
    active_drag = noone;
}
