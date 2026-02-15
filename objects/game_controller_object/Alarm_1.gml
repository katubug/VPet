var clutter_type = irandom_range(0,2);
var clutter_location = irandom_range(0,4);
var clutter_x = 200;
var clutter_y = 200;

if (clutter_location == 0){
    clutter_x = 100;
    clutter_y = 100;
}

if (clutter_location == 1){
    clutter_x = 200;
    clutter_y = 200;
}

if (clutter_location == 2){
    clutter_x = 300;
    clutter_y = 300;
}

if (clutter_location == 3){
    clutter_x = 400;
    clutter_y = 400;
}

if (clutter_location == 4){
    clutter_x = 500;
    clutter_y = 500;
}

if (clutter_type == 0){
    show_debug_message("Attempting to spawn clutter 0.");
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_clothes);
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_clothes);
}

if (clutter_type == 1){
     show_debug_message("Attempting to spawn clutter 1.");
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_dishes);
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_dishes);
}

if (clutter_type == 2){
     show_debug_message("Attempting to spawn clutter 2.");
    if (room != rm_main) room_instance_add(rm_main, clutter_x, clutter_y, obj_clutter_paper);
    else instance_create_layer(clutter_x, clutter_y, "Instances", obj_clutter_paper);
}
// Set Alarm 1 to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 20 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;
    