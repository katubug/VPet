// Set the idle egg sprite — no animation yet, just the static base egg
sprite_index = spr_egg_base;

// Disable automatic animation playback; we'll control frames manually for the rock anim
image_speed = 0;

// Hatch countdown in frames (45 seconds * frames per second)
// To test faster, swap 45 for a smaller number (e.g. 10 for 10 seconds)
hatch_timer = 45 * game_get_speed(gamespeed_fps);

// Time between idle rocks in frames — randomised so it feels organic (3–5 seconds)
rock_cooldown = irandom_range(3 * game_get_speed(gamespeed_fps), 5 * game_get_speed(gamespeed_fps));

// Whether the rock animation is currently playing
is_rocking = false;

// Crack state: 0 = normal egg, 1 = first crack, 2 = second crack, 3 = hatching
crack_phase = 0;

// Sine-wave timer for the gentle squash/stretch bounce effect
// Increment each step to drive the sin() call
bounce_t = 0;

// Post-hatch countdown before the name prompt appears (set during hatch sequence)
post_hatch_timer = 0;
