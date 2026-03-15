// Follow the mouse/touch position every frame while held
x = mouse_x;
y = mouse_y;

// When the player releases the mouse, try to drop onto a plot
if (mouse_check_button_released(mb_left)) {
    // instance_position checks the plot's own mask at (x,y) — works even without a mask on this object
    var _target = instance_position(x, y, obj_garden_plot);
    if (_target != noone) {
        // Check that the target plot is empty before planting
        var _plot = global.game.garden_plots[_target.plot_index];
        if (_plot.seed_type == "none") {
            // garden_plant_seed removes 1 seed from inventory internally
            garden_plant_seed(_target.plot_index, seed_type);
            instance_destroy();
            exit; // skip the destroy at the bottom
        }
    }

    // Dropped on empty space or an occupied plot — inventory is unchanged
    // (the seed object was created without pre-removing inventory, so nothing is lost)
    instance_destroy();
}
