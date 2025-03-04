draw_text(x + 20, y + 20, string("Clicks: ") + string(click_count));

draw_sprite(bar_border, 0, x + 0, y + 0);

draw_sprite_ext(bar_stretch, 0, x + 2, y + 2, 1+(100*(click_count/max_clicks)), 1, 0, $FFFFFF & $ffffff, 1);