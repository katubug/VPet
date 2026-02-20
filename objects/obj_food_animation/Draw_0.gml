/// @description Draw the food sprite

// Draw the food sprite at current animation frame
draw_sprite(food_sprite, image_index, x, y);

// Optional: Draw debug info
if (keyboard_check(vk_f1)) {
    draw_set_color(c_white);
    draw_text(10, 10, "Frame: " + string(current_frame) + "/" + string(total_frames));
    draw_text(10, 30, "Timer: " + string(frame_timer) + "/" + string(frame_duration));
}
