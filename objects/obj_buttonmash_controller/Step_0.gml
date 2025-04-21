time_left = time_source_get_time_remaining(button_mash_timer);

var click_increment = mouse_check_button_pressed(mb_left);
if (click_increment)
{
	if(click_count <= max_clicks && game_on = true && time_left !=0)
{
	click_count ++;
}
}