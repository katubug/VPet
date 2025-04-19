//Detect Key
    jump_key = input_check_pressed("up") or input_check_pressed("action");
    duck_key = input_check("down") or input_check("special");

//Ground Check
if (duck_key){
        ducking = true;
        jumping = false;
        falling = true;
    }
    
    if (place_meeting(x, y+1, obj_runner_block)){
        vertical_speed = 0;
        jumping = false;
        falling = false;
        
        if (!duck_key) ducking = false;
        }
    
        if (jump_key && !duck_key){
            jumping = true;
            vertical_speed = -jump_speed;
        } else {
            if (ducking){
                vertical_speed += gravity * 4;
            } else {
                if (vertical_speed < terminal_velocity){
                vertical_speed += gravity;
                }
                
                if (sign(vertical_speed) == 1){
                    falling = true;
                }
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

    if (jumping || falling){
        sprite_index = spr_dino_jump;
    }
    if (ducking) {
        sprite_index = spr_dino_crouch;
        image_speed = 10;
    }
    if (!jumping && !falling && !ducking){
        sprite_index = spr_dino_run;
        image_speed = 10;
    }