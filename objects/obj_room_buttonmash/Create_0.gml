click_count = 0;
max_clicks = 30;
click_goal = 15;

var times_up = function(msg) 
{
	show_debug_message(string(msg));
}

button_mash_timer = time_source_create(time_source_game, 5, time_source_units_seconds, times_up, ["Time's Up!"], 1, time_source_expire_after);
time_left = time_source_get_time_remaining(button_mash_timer);
