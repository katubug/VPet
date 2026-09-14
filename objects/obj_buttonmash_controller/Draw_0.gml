draw_text(x + 5, y + 5, string("Clicks: ") + string(click_count)); // 20→5

draw_text(x + 5, y + 10, string("Time Remaining: ") + string(time_left)) // 20→5, 40→10

draw_sprite(bar_border, 0, x + 0, y + 0);

draw_sprite_ext(bar_stretch, 0, x + 1, y + 1, 1 + (25 * (click_count / max_clicks)), 1, 0, $FFFFFF & $ffffff, 1); // bar scale 100→25, offset 2→1

if (outcome == "won") {
    draw_text(x + 0, y + 15, string("You won!")); // 60→15
}

if (outcome == "lost") {
    draw_text(x + 0, y + 15, string("You lost!")); // 60→15
}
