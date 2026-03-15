/// @description Garden system — timestamps, growth, watering, planting, harvesting

/// @function garden_epoch_now()
// Returns seconds elapsed since Jan 1 2020 — used for all garden timestamps
// Change the base date here if you want a different epoch
function garden_epoch_now() {
    return date_second_span(date_create_datetime(2020,1,1,0,0,0), date_current_datetime());
}

/// @function garden_get_effective_growth(plot_index)
// Returns effective seconds of growth for the given plot
// Accounts for real time plus any 2x watering boost windows
function garden_get_effective_growth(_i) {
    var _plot = global.game.garden_plots[_i];

    // Empty or never planted — nothing to calculate
    if (_plot.seed_type == "none" || _plot.plant_time == -1) return 0;

    var _now   = garden_epoch_now();
    var _raw   = _now - _plot.plant_time;   // real seconds elapsed since planting
    var _bonus = _plot.bonus_seconds;        // bonus from previously expired watering windows

    // If a watering is active (within the 1-hour 2x window), add the current boost
    if (_plot.water_time != -1) {
        var _water_elapsed = _now - _plot.water_time;
        if (_water_elapsed < 3600) {
            // Each real second inside the window earns an extra 1 second (total 2x)
            _bonus += min(3600 - _water_elapsed, _raw);
        }
    }

    var _grow_time = inventory_get_item_data(_plot.seed_type).grow_time;
    return min(_raw + _bonus, _grow_time); // cap so we never exceed full growth
}

/// @function garden_get_stage(plot_index)
// Returns growth stage: 0=empty, 1=sprout, 2=immature, 3=mature
// Adjust the percentage thresholds here to change how fast stages appear
function garden_get_stage(_i) {
    var _plot = global.game.garden_plots[_i];

    // No seed planted — empty plot
    if (_plot.seed_type == "none") return 0;

    var _grow_time = inventory_get_item_data(_plot.seed_type).grow_time;
    var _pct = garden_get_effective_growth(_i) / _grow_time;

    if (_pct >= 1.00) return 3; // mature — ready to harvest
    if (_pct >= 0.67) return 2; // immature — growing but not ready
    return 1;                    // sprout — just planted, any progress counts
}

/// @function garden_boost_active(plot_index)
// Returns true while the 1-hour 2x growth boost window is still open
// Used by the Draw event to switch between dry and watered plot sprites
function garden_boost_active(_i) {
    var _plot = global.game.garden_plots[_i];
    if (_plot.water_time == -1) return false;  // never watered
    return (garden_epoch_now() - _plot.water_time) < 3600;
}

/// @function garden_can_water(plot_index)
// Returns true if the 2-hour watering cooldown has expired (or never watered)
// Change 7200 to adjust cooldown length in seconds
function garden_can_water(_i) {
    var _plot = global.game.garden_plots[_i];
    if (_plot.water_time == -1) return true; // never been watered, always OK
    return (garden_epoch_now() - _plot.water_time) >= 7200;
}

/// @function garden_water_cooldown_remaining(plot_index)
// Returns seconds left until the plot can be watered again
function garden_water_cooldown_remaining(_i) {
    var _plot = global.game.garden_plots[_i];
    return max(0, 7200 - (garden_epoch_now() - _plot.water_time));
}

/// @function garden_water_plot(plot_index)
// Waters the plot, starting a fresh 1-hour 2x growth window
// Credits any remaining active boost from the previous watering before resetting
function garden_water_plot(_i) {
    var _plot = global.game.garden_plots[_i];

    // Bank the unused portion of the previous watering boost before overwriting water_time
    if (_plot.water_time != -1) {
        var _prior_elapsed = garden_epoch_now() - _plot.water_time;
        _plot.bonus_seconds += max(0, 3600 - _prior_elapsed);
    }

    // Stamp the new watering time
    _plot.water_time = garden_epoch_now();

    // Write the modified struct back (GML arrays need explicit reassignment)
    global.game.garden_plots[_i] = _plot;
}

/// @function garden_plant_seed(plot_index, seed_type)
// Plants a seed in the given plot and removes it from inventory
// Call only after confirming plot is empty and player has the seed
function garden_plant_seed(_i, _seed_type) {
    global.game.garden_plots[_i] = {
        seed_type:     _seed_type,
        plant_time:    garden_epoch_now(),
        water_time:    -1,
        bonus_seconds: 0,
    };
    inventory_remove(_seed_type, 1); // consume seed from inventory
}

/// @function garden_harvest(plot_index)
// Harvests a mature plot, rewards the player, and resets the plot to empty
// Returns a result struct so the caller can display a popup
function garden_harvest(_i) {
    var _plot  = global.game.garden_plots[_i];
    var _seed  = inventory_get_item_data(_plot.seed_type);
    var _fruit = _seed.harvest_item;                     // what item this seed produces

    var _qty      = irandom_range(2, 4);                 // give 2–4 fruit per harvest
    var _corns    = (random(1) < 0.10) ? irandom_range(1, 5) : 0; // 10% corn bonus
    var _bonus_s  = (random(1) < 0.05);                  // 5% chance of a free bonus seed

    inventory_add(_fruit, _qty);
    global.game.corns += _corns;
    if (_bonus_s) inventory_add(_plot.seed_type, 1); // return one seed to inventory

    // Reset the plot so a new seed can be planted
    global.game.garden_plots[_i] = {
        seed_type: "none", plant_time: -1,
        water_time: -1, bonus_seconds: 0,
    };

    // Return details for the popup message
    return { fruit: _fruit, qty: _qty, corns: _corns, bonus_seed: _bonus_s };
}
