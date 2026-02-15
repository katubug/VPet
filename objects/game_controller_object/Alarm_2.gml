if (instance_number(obj_clutter_parent) >= 1){
    var clutter_amount = instance_number(obj_clutter_parent);
    clutter_happiness(clutter_amount);
    global.game.clutter_exists = true;
}
else if (instance_number(obj_clutter_parent) < 1){
    global.game.clutter_exists = false;
    show_debug_message("no clutter exists");
    }
// Set Alarm 1 to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 5 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;