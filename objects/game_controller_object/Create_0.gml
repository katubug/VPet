
//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 20 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 20;

//Clutter determining alarm
alarm[2] = 60 * 20;

global.pantry.item_add("Lemon", "basic", 99, spr_food_basic, 1);

paused = false;
layer_name = "MainUI"

update_pause = function(){
    if (paused){
        instance_deactivate_all(true);
        instance_activate_object(input_controller_object)
        layer_set_visible(layer_name, true);
    } else {
        instance_activate_all();
        layer_set_visible(layer_name, false);
    }
}
update_pause();

