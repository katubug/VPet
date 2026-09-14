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
// On desktop, open the window as large as the monitor allows while keeping 9:16 ratio
if (os_type == os_windows || os_type == os_macosx || os_type == os_linux) {
    var _dw = display_get_width();  // monitor width in pixels
    var _dh = display_get_height(); // monitor height in pixels
    // Find the largest integer multiplier of 180×320 that fits the screen
    // Leave 80px vertical headroom for the title bar + taskbar
    var _max_scale = min(_dw div 180, (_dh - 80) div 320);
    _max_scale = max(_max_scale, 1); // never go below 1×
    var _win_w = 180 * _max_scale;
    var _win_h = 320 * _max_scale;
    window_set_size(_win_w, _win_h);
    window_set_position((_dw - _win_w) / 2, (_dh - _win_h) / 2);
}

// -- Content area bounds --
// The nav menu sits above and below the content area.
// Top bar: 8px from screen top, icons are 24px tall → bar bottom at 32.
// Content starts 8px below the top bar.
// Bottom bar: placed 8px below the content area (set in Cloud_Menu Create).
// Tweak nav_icon_size / nav_pad to resize the reserved zones.
var _gui_h        = display_get_gui_height();
var _nav_top_y    = 8;   // must match Cloud_Menu menu_y_top
var _nav_icon_size = 24;  // must match Cloud_Menu icon_size
var _nav_pad      = 8;   // breathing room between nav and content
global.display_area_top    = _nav_top_y + _nav_icon_size + _nav_pad; // 8 + 24 + 8 = 40
global.display_area_bottom = _gui_h - _nav_top_y - _nav_icon_size - _nav_pad; // 320 - 40 = 280

//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to every 5 minutes (fps times 60 seconds times 5)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Clutter determining alarm
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

// scribble_font_set_default("fnt_Kubasta"); // Temporarily disabled — Scribble removed for font debug