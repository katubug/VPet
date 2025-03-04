draw_text(x+0, y+0,string("Time Remaining: ")+string(time_left))

var click_increment;
with(all) click_increment = mouse_check_button_pressed(mb_left);
if (click_increment)
{
	if(click_count <= max_clicks)
{
	click_count += 1;
}
}