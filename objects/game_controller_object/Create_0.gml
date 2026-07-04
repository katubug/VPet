// Singleton guard — game_controller_object is persistent, so if the player navigates back
// to rm_initial after death, a second instance would be created from the placed object.
// Destroy the new one immediately if one already exists.
if (instance_number(game_controller_object) > 1) {
    instance_destroy();
    exit;
}

//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to every 5 minutes (fps times 60 seconds times 5)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Clutter determining alarm
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

// scribble_font_set_default("fnt_Kubasta"); // Temporarily disabled — Scribble removed for font debug