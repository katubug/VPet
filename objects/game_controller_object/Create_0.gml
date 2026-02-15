// Initialize inventory system FIRST
inventory_init();

//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to every 5 minutes (fps times 60 seconds times 5)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Clutter determining alarm
alarm[2] = game_get_speed(gamespeed_fps) * 60 * 5;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

//Give player some food to start (using NEW inventory system)
inventory_add("lemon", 99);
inventory_add("apple", 10);
inventory_add("bread", 5);
inventory_add("ball", 1);
inventory_add("flour", 20);

//Set Up Pause Menu
paused = false;
pausemenu = "PauseMenu"

update_pause = function(){
    if (paused){
        instance_deactivate_all(true);
        instance_activate_object(input_controller_object)
        layer_set_visible(pausemenu, true);
    } else {
        instance_activate_all();
        layer_set_visible(pausemenu, false);
    }
}
update_pause();