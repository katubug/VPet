var clutter_type = irandom_range(0,2);
var clutter_location = irandom_range(0,4);
var clutter_x = 50;  // 200 ÷ 4 = 50 (default position)
var clutter_y = 50;  // 200 ÷ 4 = 50

if (clutter_location == 0){
    clutter_x = 25;  // 100 ÷ 4 = 25
    clutter_y = 25;
}

if (clutter_location == 1){
    clutter_x = 50;  // 200 ÷ 4 = 50
    clutter_y = 50;
}

if (clutter_location == 2){
    clutter_x = 75;  // 300 ÷ 4 = 75
    clutter_y = 75;
}

if (clutter_location == 3){
    clutter_x = 100; // 400 ÷ 4 = 100
    clutter_y = 100;
}

if (clutter_location == 4){
    clutter_x = 125; // 500 ÷ 4 = 125
    clutter_y = 125;
}

if (clutter_type == 0){
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_clothes)
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_clothes)
}

if (clutter_type == 1){
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_dishes)
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_dishes)
}

if (clutter_type == 2){
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_paper)
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_paper)
}
// Set Alarm 1 to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 20 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;
