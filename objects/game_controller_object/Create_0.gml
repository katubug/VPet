
alarm[0] = 60;
alarm[2] = 60 * 20;

// Set Alarm 1 to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 20 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 20;