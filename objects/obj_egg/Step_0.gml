// ── SQUASH & STRETCH ─────────────────────────────────────────────────────────
// Only run the bounce effect during normal idle (no cracks, not yet hatching)
if (crack_phase == 0) {
    // Advance the sine-wave timer each frame
    // Adjust 0.03 to change the pulse speed (higher = faster breathing)
    bounce_t += 0.03;

    // Vertical scale oscillates ±4% — gentle, organic "alive" feeling
    // Increase 0.04 to make it more dramatic
    image_yscale = 1.0 + sin(bounce_t) * 0.04;

    // Horizontal compensates — wide when squashed, narrow when stretched
    image_xscale = 1.0 / image_yscale;
}


// ── IDLE ROCK TRIGGER ────────────────────────────────────────────────────────
// Only rock during normal idle — stop once cracking begins
if (!is_rocking && crack_phase == 0) {

    rock_cooldown--;

    if (rock_cooldown <= 0) {
        is_rocking = true;
        rock_t     = 0; // Reset the rotation timer so the swing always starts from neutral
    }
}


// ── CODE-BASED ROCK ANIMATION ─────────────────────────────────────────────────
// Drives a full left-right swing using image_angle — no sprite swap needed
if (is_rocking) {
    // Advance the rotation timer each frame
    // Adjust 3 to change rock speed: higher = faster swing (3 ≈ 2 seconds for a full rock)
    rock_t += 3;

    // Sine wave maps 0°–360° onto a smooth left-right tilt
    // Adjust 15 to change how far the egg tilts (in degrees)
    image_angle = dsin(rock_t) * 15;

    // One full sine cycle (360°) = one complete back-and-forth rock
    if (rock_t >= 360) {
        image_angle = 0;     // Snap back to perfectly upright
        is_rocking  = false;

        // Randomise the next rock delay (3–5 seconds)
        rock_cooldown = irandom_range(
            3 * game_get_speed(gamespeed_fps),
            5 * game_get_speed(gamespeed_fps)
        );
    }
}


// ── HATCH COUNTDOWN & CRACK PROGRESSION ──────────────────────────────────────
// Count down only while still in the pre-hatch phases
if (crack_phase < 3) {
    hatch_timer--;

    // 10 seconds before hatch: first crack appears
    // Crack window spans 10 seconds total — adjust multiplier to change timing
    if (hatch_timer <= 10 * game_get_speed(gamespeed_fps) && crack_phase == 0) {
        crack_phase  = 1;
        sprite_index = spr_egg_crack_1;
        image_speed  = 0;
        is_rocking   = false; // Abort any in-progress rock

        // Reset rotation and scale so crack sprites display cleanly
        image_angle  = 0;
        image_xscale = 1;
        image_yscale = 1;
    }

    // 5 seconds before hatch: second crack appears
    // Adjust multiplier to change when crack_2 shows up
    if (hatch_timer <= 5 * game_get_speed(gamespeed_fps) && crack_phase == 1) {
        crack_phase  = 2;
        sprite_index = spr_egg_crack_2;
    }

    // Timer hits zero — trigger the hatch
    if (hatch_timer <= 0 && crack_phase == 2) {
        crack_phase = 3;
    }
}


// ── HATCHING WIGGLE ───────────────────────────────────────────────────────────
// Rapid sine-wave jitter applied while cracks are showing
// Adjust the speed (12) and amplitudes to taste
if (crack_phase == 1) {
    wiggle_t    += 12; // Degrees per frame — higher = faster shake
    image_angle  = dsin(wiggle_t) * 6; // ±6 degree tilt for first crack
}
if (crack_phase == 2) {
    wiggle_t    += 12;
    image_angle  = dsin(wiggle_t) * 12; // ±12 degrees — more frantic as hatch nears
}


// ── HATCH SEQUENCE (fires once when crack_phase reaches 3) ───────────────────
if (crack_phase == 3) {

    // Randomly assign the pet's gender — stored in the save file
    // Change the values in choose() if you want different gender options
    global.game.gender = choose("boy", "girl");

    // Fire the burst particle effect at the egg's position
    // Uses the same particle system as regular evolution (particle_evolution_1)
    var _partsys = part_system_create(particle_evolution_1);
    part_system_position(_partsys, x, y);

    // Advance the game past the egg phase so everything else (Cloud_Menu etc.) works
    global.game.evolution_phase = "baby";

    // Persist the phase and gender to disk immediately — time_reset() had saved "egg",
    // so if the game closes before naming, the next load would incorrectly show an egg.
    pre_save();

    // Spawn whichever starter pet was randomly chosen at game init
    var _pet_name  = $"obj_pet_{global.game.current_pet_type}";
    var _pet_index = asset_get_index(_pet_name);
    instance_create_layer(x, y, "Instances", _pet_index);

    // Hide the egg shell — it stays alive as a 2-second timer before the name prompt
    visible = false;

    // 2-second delay before showing the name prompt (2 * fps)
    // Adjust the multiplier to change how long after hatching the prompt appears
    post_hatch_timer = 2 * game_get_speed(gamespeed_fps);

    // Move to the post-hatch waiting phase
    crack_phase = 4;
}


// ── POST-HATCH DELAY ─────────────────────────────────────────────────────────
// Wait 2 seconds after the hatch burst before showing the name prompt
if (crack_phase == 4) {
    post_hatch_timer--;

    if (post_hatch_timer <= 0) {
        // Spawn the pet naming screen
        instance_create_layer(x, y, "Instances", obj_pet_name_entry);

        // The egg object has done its job — remove it
        instance_destroy(self);
    }
}
