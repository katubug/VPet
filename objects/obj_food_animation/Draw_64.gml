/// @description Draw the food sprite in GUI layer (above everything)

// Draw in GUI coordinates (always on top)
var gui_x = display_get_gui_width() / 2;
var gui_y = 700;

// Explicitly draw the sprite
draw_sprite(sprite_index, image_index, gui_x, gui_y);

//// DEBUG: Show position and sprite info
//draw_set_color(c_yellow);
//draw_circle(gui_x, gui_y, 50, true);
//draw_set_color(c_white);
//draw_text(gui_x - 50, gui_y - 80, "FOOD HERE");
//draw_text(gui_x - 50, gui_y - 60, "Frame: " + string(image_index) + "/" + string(total_frames));

// Optional: Additional debug with F1
if (keyboard_check(vk_f1)) {
    draw_set_color(c_lime);
    draw_text(10, 10, "Frame: " + string(current_frame) + "/" + string(total_frames));
    draw_text(10, 30, "Timer: " + string(frame_timer) + "/" + string(frame_duration));
    draw_text(10, 50, "Sprite: " + sprite_get_name(sprite_index));
}
