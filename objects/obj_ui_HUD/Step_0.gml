/// @description Handle Extended Stats Toggle

// Toggle extended stats with Shift+S
if (keyboard_check(vk_shift) && keyboard_check_pressed(ord("S"))) {
    show_extended_stats = !show_extended_stats;
    show_debug_message("Extended stats: " + (show_extended_stats ? "SHOWN" : "HIDDEN"));
}
