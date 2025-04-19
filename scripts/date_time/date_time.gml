function calculate_stats_after_offline(original_hunger, original_health, minutes_offline) {
    var hunger_decay_interval = 30; // minutes per 1 hunger lost
    var health_decay_interval = 60; // minutes per 1 health lost after hunger is 0

    // Step 1: Calculate how much hunger would have been lost
    var hunger_lost = floor(minutes_offline / hunger_decay_interval);
    var new_hunger = max(original_hunger - hunger_lost, 0);

    // Step 2: If hunger is gone, start calculating health loss
    var new_health = original_health;

    if (new_hunger == 0) {
        // Figure out how long the pet has been starving
        var time_until_starving = original_hunger * hunger_decay_interval;
        var time_starving = max(minutes_offline - time_until_starving, 0);

        // Step 3: Calculate health lost while starving
        var health_lost = floor(time_starving / health_decay_interval);
        new_health = max(original_health - health_lost, 0);
    }
    global.game.hunger = new_hunger;
    global.game.health = new_health;
    
    //Happiness calculations
    if (global.game.clutter_exists == true) {
        global.game.happiness -= (minutes_offline/40);
        if (global.game.happiness <=0) global.game.happiness = 0;
    } else 
    global.game.happiness -= (minutes_offline/60)
    if (global.game.happiness <=0) global.game.happiness = 0;

}

function date_time() 
{
    //We want to grab the previously stored time and date for comparison reasons
    var _year = global.game.year;
    var _month = global.game.month;
    var _day = global.game.day;
    var _hour = global.game.hour;
    var _minute = global.game.minute;
    var _second = global.game.second;
    var _banked_time = global.game.banked_time;
    
    //The date_second_span calculates between our saved date and the current time and date.
    //It's saved in seconds
    var time_elapsed = date_second_span(date_create_datetime(_year, _month, _day, _hour, _minute, _second), date_current_datetime())
    
    //because we are calculating hunger and other need degradation as minutes, we convert the seconds
    //elapsed into minutes by dividing by 60.
    var _minutes_elapsed = time_elapsed/60;
    
    calculate_stats_after_offline(global.game.hunger, global.game.health, _minutes_elapsed)

    show_debug_message($"total banked time was {global.game.banked_time}.")
    show_debug_message($"time elapsed since logoff was {_minutes_elapsed} minutes aka {time_elapsed} seconds.")
    
    //create a temporary variable which adds the total banked time plus the time elapsed, and banks it all.
    //this is all calculated in seconds
    var new_total_time = _banked_time + time_elapsed;
    //bank previous banked time plus time elapsed
    global.game.banked_time = new_total_time;
    //Also make sure the previous total time is correct for this play session
    global.game.previous_total_time = global.game.banked_time;
    //now i need to make sure that the banked time stays banked, and the current time 
    //is a combination of the banked time and the session time
    //since the current running time should only really exist temporarily during play sessions,
    //i set it to 0 at load so that it can be calculated dynamically by banked time + session time.
    //we don't bank current total because it only exists to store the value of banked + session anyway
    global.game.running_time = 0;
    
}

function save_date()
{
    global.game.year = current_year;
    global.game.month = current_month;
    global.game.day = current_day;
    global.game.hour = current_hour;
    global.game.minute = current_minute;
    global.game.second = current_second;

}

function time_reset()
{
    global.game.year = current_year;
    global.game.month = current_month;
    global.game.day = current_day;
    global.game.hour = current_hour;
    global.game.minute = current_minute;
    global.game.second = current_second;
    //because current time is in milliseconds; we divide it by 1000 to change it to seconds
    global.game.session_time = 0;
    global.game.previous_total_time = 0;
    global.game.running_time = 0;
    global.game.banked_time = 0;
    global.game.last_saved_time = 0;
    var _dataToSave = {
        game: global.game,
		pet: global.pet,
		inventory: global.inventory,
		pantry: global.pantry,
        };
    json_save_classful("save_data.txt", _dataToSave);
}