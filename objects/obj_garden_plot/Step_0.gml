// Check if the mouse/cursor is hovering over this plot (80x80 bounds)
_hover = point_in_rectangle(mouse_x, mouse_y, x - 40, y - 40, x + 40, y + 40);

// Only handle input if no dialog is blocking input
if (!global.dialog_open && _hover && mouse_check_button_pressed(mb_left)) {
    var _stage = garden_get_stage(plot_index);

    if (global.garden_watering_mode) {
        // --- WATERING MODE: click waters the plot (or shows cooldown) ---
        if (_stage >= 1) {
            if (garden_can_water(plot_index)) {
                garden_water_plot(plot_index);
                var _p = instance_create_depth(x, y - 60, -9999, obj_popup_message);
                _p.message = "Watered! 2x growth for 1 hour.";
            } else {
                // Plot is on cooldown — show remaining time and dismiss automatically
                var _secs = garden_water_cooldown_remaining(plot_index);
                var _mins = floor(_secs / 60);
                var _sec2 = _secs mod 60;
                var _p = instance_create_depth(x, y - 60, -9999, obj_popup_message);
                _p.message = "Not ready! " + string(_mins) + "m " + string(_sec2) + "s left.";
            }
        }
        // Clicking an empty plot in watering mode does nothing
    } else {
        // --- NORMAL MODE: click harvests a mature plot only ---
        if (_stage == 3) {
            var _r   = garden_harvest(plot_index);
            var _msg = "Harvested " + string(_r.qty) + "x " + _r.fruit + "!";
            if (_r.corns > 0)  _msg += " +" + string(_r.corns) + " corns!";
            if (_r.bonus_seed) _msg += " +1 bonus seed!";
            var _p = instance_create_depth(x, y - 60, -9999, obj_popup_message);
            _p.message = _msg;
        }
        // Stages 0-2 in normal mode: no action (drag to plant, toggle watering can to water)
    }
}
