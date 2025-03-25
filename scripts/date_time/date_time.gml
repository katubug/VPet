
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
    global.game.hunger -= _minutes_elapsed;
    show_debug_message($"total banked time was {global.game.banked_time}.")
    show_debug_message($"time elapsed since logoff was {_minutes_elapsed} minutes aka {time_elapsed} seconds.")
    
    //create a temporary variable which adds the total banked time plus the time elapsed, and banks it all.
    //this is all calculated in seconds
    var new_total_time = _banked_time + time_elapsed;
    //bank previous banked time plus time elapsed
    global.game.banked_time = new_total_time;
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