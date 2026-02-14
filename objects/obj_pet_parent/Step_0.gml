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
        image_xscale = -1;
    }
    else if (target_x < x) {
        sprite_index = pet_walking_sprite;
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
    if (image_xscale != -1){
        sprite_index = pet_idle_sprite;
    }
    else if (image_xscale == -1) {
        sprite_index = pet_idle_sprite;
        image_xscale = -1; 
    }
}