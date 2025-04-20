//Obstacle Spawning
randomize();
var count = irandom_range(1, 2);

var i = instance_create_layer(room_width+100, y, "Instances", obj_obstacle_parent);
i.sprite_index = choose(spr_obstacle_frog, spr_obstacle_bat);
switch (i.sprite_index){
    case spr_obstacle_frog:
        if (global.speed_modifier > 1.5){
            if (count == 2){
                var j = instance_create_layer(room_width+100, y, "Instances", obj_obstacle_parent);
                j.sprite_index = spr_obstacle_frog; 
            }
        }
    break;
    
    default: //bat
        i.y = choose(y-100, y-50, y-10);
}

alarm[0] = game_get_speed(gamespeed_fps) * random_range(1/global.speed_modifier, 3/global.speed_modifier);