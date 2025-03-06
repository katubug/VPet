draw_text(x + 20, y + 20, string("Clicks: ") + string(click_count));

draw_text(x+20, y+40,string("Time Remaining: ")+string(time_left))

draw_sprite(bar_border, 0, x + 0, y + 0);

draw_sprite_ext(bar_stretch, 0, x + 2, y + 2, 1+(100*(click_count/max_clicks)), 1, 0, $FFFFFF & $ffffff, 1);

if (outcome == "won") {
    draw_text(x+0, y+60, string("You won!"));
}

if (outcome == "lost") {
    draw_text(x+0, y+60, string("You lost!"));
}