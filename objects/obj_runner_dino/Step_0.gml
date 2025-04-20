if (hurt == true){
        sprite_index = spr_dino_hurt;
    }

if (dino_hp <= 0){
    gameover = true;
    obj_runner_controller.game_ending = true;
    grav = 0;
    image_alpha = 0.5;
    global.speed_modifier = 0;
    image_speed = 0;
    if (!instance_exists(obj_runner_replay)){
        instance_create_layer(room_width/2, 300, "Instances", obj_runner_replay);
    }
}

if (gameover){
    exit;
}

if (dino_invincible && !hurt){
    image_alpha = 0.5;
} else {
	image_alpha = 1;
}

//Detect Key
    var jump_key = input_check_pressed("up") or input_check_pressed("action");
    var duck_key = input_check("down") or input_check("special");

//Ground Check
if (duck_key)
	{
		ducking = true;
		jumping = false;
		falling = true;
	}

	if (place_meeting(x, y + 1, obj_runner_block))
	{
		// we're touching the ground
		vertical_speed = 0;
		jumping = false;
		falling = false;
	
		if (!duck_key)
			ducking = false;
		
		// if the player wants to jump
		if (jump_key && !duck_key){
				jumping = true;
				vertical_speed = -jump_speed;
		}
	}
	else
	{
		if (ducking)
		{
			vertical_speed += grav * 4;	
		}
		else
		{
			if (vertical_speed < terminal_velocity)
				vertical_speed += grav;
			
			if (sign(vertical_speed) == 1)
				falling = true;
		}
	}

//Jump Check
if (jumping){
        if (vertical_speed < 0){
            jumping = true;
        } else {
            jumping = false;
            falling = true;
        }
    }

//Collision Check
if (place_meeting(x, y + vertical_speed, obj_runner_block)){
        while(!place_meeting(x, y + sign(vertical_speed), obj_runner_block)){
            y += sign(vertical_speed);
        }
        vertical_speed = 0;
    }
    y += vertical_speed;

//Set Sprite

    if (!hurt && (jumping || falling)){
        sprite_index = spr_dino_jump;
    }
    if (!hurt && ducking) {
        sprite_index = spr_dino_crouch;
    }
    if (!jumping && !falling && !ducking && !hurt){
        sprite_index = spr_dino_run;
    }