target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;
pet_talking = false;
eating = false;
sad = false;
happy = false;
walking = false;
can_walk = true;
bath_time = true;
//set idle sprite
idle_sprite = $"spr_{global.game.current_pet_type}_base";
pet_idle_sprite = asset_get_index(idle_sprite);

//set eating sprite
eating_sprite = $"spr_{global.game.current_pet_type}_eat";
pet_eating_sprite = asset_get_index(eating_sprite);

//set walking sprite
walking_sprite = $"spr_{global.game.current_pet_type}_walk";
pet_walking_sprite = asset_get_index(walking_sprite);

//set sad sprite
sad_sprite = $"spr_{global.game.current_pet_type}_sad";
pet_sad_sprite = asset_get_index(sad_sprite);

//set happy sprite
happy_sprite = $"spr_{global.game.current_pet_type}_happy";
pet_happy_sprite = asset_get_index(happy_sprite);

// All sprites are now at native pixel-art resolution — no runtime scaling needed
pet_scale = 1;
image_xscale = pet_scale;
image_yscale = pet_scale;

//Need degradation
//TODO should i put this in game controller?
alarm[0] = 60*20;

//Random Walking
alarm[1] = 30;

//character talks
//alarm[2] = game_get_speed(gamespeed_fps) * 60 * 1;

//Happiness goes up when hunger is full
alarm[3] = 60*20;

//Alarm 6 is for evolution and is called elsewhere

// -- Talk Screen Variables --
talk_active = false;          // whether the talk sequence is currently running
talk_phase = "none";          // "walk_in", "talking", "dismissable", or "none"
talk_anim_t = 0;              // 0→1 animation progress for the walk-in
talk_anim_duration = 26;      // frames for the walk-in animation (~0.43s at 60fps, 30% slower)
talk_start_x = 0;             // pet's original x position before talk started
talk_start_y = 0;             // pet's original y position before talk started
talk_start_xscale = 1;        // pet's original image_xscale before talk started
talk_start_yscale = 1;        // pet's original image_yscale before talk started
talk_target_x = 0;            // where the pet walks to (center of room)
talk_target_y = 0;            // where the pet walks to (near bottom of room)
talk_zoom_multiplier = 3;     // how much to multiply pet_scale by during zoom (tweak this to adjust)
talk_zoom_scale = 0;          // computed target scale: pet_scale * talk_zoom_multiplier
talk_dismiss_timer = 0;       // counts up each frame, becomes dismissable after 60 frames (1 second)
talk_can_dismiss = false;     // whether the player can tap/click to dismiss
talk_typewriter = undefined;  // typewriter struct for the dialogue text
talk_bar_height = 0.3;        // dialogue bar as a fraction of screen height (0.3 = 30%)
talk_wobble_t = 0;            // timer driving the walk-in wiggle (sine wave)
talk_mouth_timer = 0;         // counts frames the eating sprite has played
talk_mouth_duration = 60;     // stop the eating/mouth animation after this many frames (~1 second)
talk_squash_t = 0;            // timer driving the squash-and-stretch oscillation
talk_facing = 1;              // 1 = facing left (default), -1 = facing right (flipped)

/// @function start_talk()
/// @description Begins the talk sequence — called from Cloud_Menu's Talk button callback
start_talk = function() {
	if (talk_active) return;                    // don't start if already talking

	// Store the pet's current position and scale so we can restore them on dismiss
	talk_start_x = x;
	talk_start_y = y;
	talk_start_xscale = image_xscale;
	talk_start_yscale = image_yscale;

	// Stop the pet from wandering during the talk
	can_walk = false;
	walking = false;

	// Activate the talk state (hides menus, skips normal pet Step logic)
	talk_active = true;
	global.talk_active = true;

	// Set the walk-in destination: horizontally centered, near the bottom of the room
	talk_target_x = room_width / 2;
	talk_target_y = room_height - 50;           // 50px from the bottom edge (tweak if sprite origin needs it)

	// Compute the zoom scale from the base pet_scale and the multiplier
	talk_zoom_scale = pet_scale * talk_zoom_multiplier;

	// Reset animation state
	talk_phase = "walk_in";
	talk_anim_t = 0;
	talk_dismiss_timer = 0;
	talk_can_dismiss = false;
	talk_wobble_t = 0;
	talk_mouth_timer = 0;
	talk_squash_t = 0;
	talk_facing = sign(image_xscale);  // capture which way the pet is currently facing

	// Increase happiness by 2 (capped at 20)
	global.game.happiness = min(global.game.happiness + 2, 20);

	// Pick a random dialogue line and create the typewriter effect
	talk_typewriter = typewriter_create(get_pet_dialogue(), 2);
};