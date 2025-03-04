time_left = time_source_get_time_remaining(button_mash_timer);

draw_text(0, 0, string("Time Left: ") + string(time_left));

var click_increment;
with(all) click_increment = mouse_check_button_pressed(mb_left);
if (click_increment)
{
	if(click_count <= max_clicks)
{
	click_count += 1;
}
}