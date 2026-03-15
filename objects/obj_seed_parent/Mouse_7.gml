// Mouse released — stop dragging and check if dropped on a garden plot
dragged = 0;

// Find the specific plot instance at the drop position (not a global reference)
var _target = instance_position(x, y, obj_garden_plot);
if (_target != noone) {
    // Read this plot's data from the array using its own index
    var _plot = global.game.garden_plots[_target.plot_index];
    if (_plot.seed_type == "none") {
        // Plant the seed — garden_plant_seed removes it from inventory internally
        garden_plant_seed(_target.plot_index, seed_type);
        instance_destroy(); // remove this dragged seed object
    }
}
