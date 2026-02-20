/// @description Draw the food sprite

// The sprite is drawn automatically because we set sprite_index
// But we can draw debug info

// Optional: Draw debug info
if (keyboard_check(vk_f1)) {
    draw_set_color(c_white);
    draw_text(10, 10, "Frame: " + string(current_frame) + "/" + string(total_frames));
    draw_text(10, 30, "Timer: " + string(frame_timer) + "/" + string(frame_duration));
    draw_text(10, 50, "Sprite: " + sprite_get_name(sprite_index));
    draw_text(10, 70, "Image Index: " + string(image_index));
}
