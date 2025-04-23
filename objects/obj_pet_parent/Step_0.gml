

var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);

if (global.game.evolution_queued == 0){
    // do the evolution dance!
    show_debug_message("attempting to switch pets");
        alarm[6] = 10;
        global.game.evolution_queued = 1;
        }


if (target_x != 0 && target_y != 0){
    if (target_x > x) {
        sprite_index = pet_walking_sprite;
        image_xscale = -1;
    }
    else if (target_x < x) {
        sprite_index = pet_walking_sprite;
           
    }
} else {
    if (image_xscale != -1){
        show_debug_message("beep");
        sprite_index = pet_idle_sprite;
    }
    else if (image_xscale == -1) {
        show_debug_message("boop");
        sprite_index = pet_idle_sprite;
        image_xscale = -1; 
    }
}

if (eating){
    sprite_index = pet_eating_sprite;
}

if (happy){
    sprite_index = pet_happy_sprite;
}

if (sad){
    sprite_index = pet_sad_sprite;
}