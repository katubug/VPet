function date_time() 
{
    var _year = global.game.year;
    var _month = global.game.month;
    var _day = global.game.day;
    var _hour = global.game.hour;
    var _minute = global.game.minute;
    var _second = global.game.second;
    var _total_time = global.game.total_time;
    
    var time_elapsed = date_second_span(date_create_datetime(_year, _month, _day, _hour, _minute, _second), date_current_datetime())
    var _minutes_elapsed = time_elapsed/60;
    global.game.hunger -= _minutes_elapsed;
    show_debug_message($"time elapsed since logoff was {_minutes_elapsed} minutes")
    
    var new_total_time = _total_time + time_elapsed;
    global.game.total_time = new_total_time;
    
}