show_debug_message("yapping");
pet_talking = true;

var talking_stop = function(msg) 
{
    show_debug_message(msg)
    pet_talking = false;
}

var talking_timer = time_source_create(time_source_game, 5, time_source_units_seconds, talking_stop, ["Unyapping"], 1, time_source_expire_after);
time_source_start(talking_timer);

//repeat in 1-5 minutes
alarm[2] = game_get_speed(gamespeed_fps) * 60 * irandom_range(1,5);