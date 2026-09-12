// -- Talk Screen Logic --
// When the talk sequence is active, this block runs instead of normal pet behavior
if (talk_active) {
	switch (talk_phase) {
		case "walk_in":
			// Advance the animation timer (0 → 1 over talk_anim_duration frames)
			talk_anim_t += 1 / talk_anim_duration;

			// Lerp the pet's position from its starting point to the target
			var _base_x = lerp(talk_start_x, talk_target_x, talk_anim_t);
			y = lerp(talk_start_y, talk_target_y, talk_anim_t);

			// Add a wobble on top of the smooth lerp to look like a bouncy walk
			talk_wobble_t += 0.18;                          // gentle wobble speed
			x = _base_x + sin(talk_wobble_t * 6) * 3;  // ±3px horizontal sway
			image_angle = sin(talk_wobble_t * 6) * 4;   // ±4 degree tilt

			// Lerp the scale from normal to the zoomed-in size
			var _current_scale = lerp(pet_scale, talk_zoom_scale, talk_anim_t);
			image_xscale = _current_scale * talk_facing;  // preserve facing direction
			image_yscale = _current_scale;

			// Show the walking sprite during the approach
			sprite_index = pet_walking_sprite;

			// When the animation completes, snap to final values and switch to talking
			if (talk_anim_t >= 1) {
				talk_anim_t = 1;
				x = talk_target_x;             // snap to exact position (no wobble)
				y = talk_target_y;
				image_angle = 0;               // reset rotation
				image_xscale = talk_zoom_scale * talk_facing;  // preserve facing direction
				image_yscale = talk_zoom_scale;
				sprite_index = pet_eating_sprite;       // mouth open/close animation for "talking"
				talk_phase = "talking";
			}
			break;

		case "talking":
			// Update the typewriter text each frame
			typewriter_update(talk_typewriter);

			// Play eating sprite for ~1 second, then switch to idle
			talk_mouth_timer++;
			if (talk_mouth_timer < talk_mouth_duration) {
				sprite_index = pet_eating_sprite;       // mouth moving (first ~1 second)
			} else {
				sprite_index = pet_idle_sprite;         // mouth stops, pet just stands there
			}

			// Subtle squash-and-stretch to keep the pet feeling alive
			talk_squash_t += 0.08;                      // slow oscillation speed (tweak this)
			var _squash = sin(talk_squash_t) * 0.04;    // 4% amplitude (tweak this)
			image_xscale = talk_zoom_scale * (1 + _squash) * talk_facing;  // wider when squash is positive, preserving facing
			image_yscale = talk_zoom_scale * (1 - _squash);  // shorter when wider (volume preserved)

			// Count frames until the player can dismiss (1 second = 60 frames)
			talk_dismiss_timer++;
			if (talk_dismiss_timer >= 60) {
				talk_can_dismiss = true;
				talk_phase = "dismissable";
			}
			break;

		case "dismissable":
			// Keep updating the typewriter in case it hasn't finished yet
			typewriter_update(talk_typewriter);

			// Continue the mouth timer — eating sprite only plays for talk_mouth_duration frames total
			talk_mouth_timer++;
			if (talk_mouth_timer < talk_mouth_duration) {
				sprite_index = pet_eating_sprite;
			} else {
				sprite_index = pet_idle_sprite;
			}

			// Continue the squash-and-stretch breathing
			talk_squash_t += 0.08;
			var _squash = sin(talk_squash_t) * 0.04;
			image_xscale = talk_zoom_scale * (1 + _squash);
			image_yscale = talk_zoom_scale * (1 - _squash);

			// Check for tap/click or keyboard input to dismiss
			if (mouse_check_button_pressed(mb_left)
			    || input_check_pressed("accept")
			    || input_check_pressed("action")) {
				// Restore the pet to its original position and scale
				x = talk_start_x;
				y = talk_start_y;
				image_xscale = talk_start_xscale;
				image_yscale = talk_start_yscale;
				image_angle = 0;                        // ensure rotation is clean

				// Re-enable walking and clear the talk state
				can_walk = true;
				talk_active = false;
				global.talk_active = false;
				talk_phase = "none";
			}
			break;
	}
	exit; // skip all normal pet movement and sprite logic below
}

//Determines where the pet will begin walking to
var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

if (can_walk) move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);

//Evolve if possible.
if (global.game.evolution_queued == 0){
    // do the evolution dance!
    show_debug_message("attempting to switch pets");
        alarm[6] = 10;
        global.game.evolution_queued = 1;
        }

//If player goes to the bathroom, pet takes a bath
if (room == rm_bathroom && bath_time){
    bath_time = false;
    var take_bath = sequencePlay("seq_bath", "Instances", 0, 224);
}

//Unsure what this does - stops the pet from walking if it gets to its destination?
if (!eating && walking){
     if (point_distance(x, y, target_x, target_y) < 1){
        walking = false;
    }
}

//Flips the pet sprite depending on which way it's facing, I think?
if (!eating && walking){
    if (target_x > x) {
        sprite_index = pet_walking_sprite;
        image_xscale = -pet_scale; // flip sprite to face right, preserving scale
    }
    else if (target_x < x) {
        sprite_index = pet_walking_sprite;
        image_xscale = pet_scale; // flip sprite back to face left, preserving scale
    }
}

//Prevents the pet from walking while eating, and sets the sprite to the eating one.
if (eating){
    walking = false;
    x = room_width/2;
    y = room_height/2;
    sprite_index = pet_eating_sprite;
} 

//Sets the sprite if the pet is joyful
if (happy){
    sprite_index = pet_happy_sprite;
} 

//Sets the sprite if the pet is upset.
if (sad){
    sprite_index = pet_sad_sprite;
}

//If the pet is not doing anything else, then the idle animation should play 
//(facing the correct direction)
if (!sad && !happy && !walking && !eating){
    if (image_xscale != -pet_scale){
        sprite_index = pet_idle_sprite;
    }
    else if (image_xscale == -pet_scale) {
        sprite_index = pet_idle_sprite;
        image_xscale = -pet_scale; // keep facing right, preserving scale
    }
}