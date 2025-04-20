//Coin Spawning
randomize();
var coin_count = irandom_range(1, 2);

var coin = instance_create_layer(room_width+100, y, "Instances", obj_pickup_coin);

if (global.speed_modifier > 1.5){
    if (coin_count == 2){
        var coin_2 = instance_create_layer(room_width+100, y, "Instances", obj_pickup_coin);
    }
}

alarm[1] = game_get_speed(gamespeed_fps) * random_range(2/global.speed_modifier, 5/global.speed_modifier);