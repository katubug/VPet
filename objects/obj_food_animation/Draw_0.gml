/// @description Draw the food sprite

// Explicitly draw the sprite
draw_sprite(sprite_index, image_index, x, y);

// DEBUG: Always show position and sprite info
//draw_set_color(c_yellow);
//draw_circle(x, y, 50, true); // Draw circle at sprite position
//draw_set_color(c_white);
//draw_text(x - 50, y - 80, "FOOD HERE");
//draw_text(x - 50, y - 60, "X: " + string(x) + " Y: " + string(y));
//draw_text(x - 50, y - 40, "Sprite: " + sprite_get_name(sprite_index));
//draw_text(x - 50, y - 20, "Frame: " + string(image_index));

// Optional: Additional debug with F1
if (keyboard_check(vk_f1)) {
    draw_set_color(c_lime);
    draw_text(10, 10, "Frame: " + string(current_frame) + "/" + string(total_frames));
    draw_text(10, 30, "Timer: " + string(frame_timer) + "/" + string(frame_duration));
    draw_text(10, 50, "Sprite: " + sprite_get_name(sprite_index));
    draw_text(10, 70, "Image Index: " + string(image_index));
    draw_text(10, 90, "Sprite Width: " + string(sprite_get_width(sprite_index)));
    draw_text(10, 110, "Sprite Height: " + string(sprite_get_height(sprite_index)));
}
