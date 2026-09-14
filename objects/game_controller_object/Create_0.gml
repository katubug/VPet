// Singleton guard — game_controller_object is persistent, so if the player navigates back
// to rm_initial after death, a second instance would be created from the placed object.
// Destroy the new one immediately if one already exists.
if (instance_number(game_controller_object) > 1) {
    instance_destroy();
    exit;
}

// -- Resolution setup --
// Set the GUI layer to match native pixel-art resolution (180×320)
display_set_gui_size(180, 320);
// Force nearest-neighbor filtering so pixels stay crisp when upscaled
gpu_set_texfilter(false);
// On desktop, open the window at 4× native (720×1280) so it's not tiny
if (os_type == os_windows || os_type == os_macosx || os_type == os_linux) {
    var _dw = display_get_width();  // monitor width in pixels
    var _dh = display_get_height(); // monitor height in pixels
    window_set_size(720, 1280);     // 4× the 180×320 base resolution
    window_set_position((_dw - 720) / 2, (_dh - 1280) / 2); // center on screen
}

//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to every 5 minutes (fps times 60 seconds times 5)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Clutter determining alarm
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

// scribble_font_set_default("fnt_Kubasta"); // Temporarily disabled — Scribble removed for font debug