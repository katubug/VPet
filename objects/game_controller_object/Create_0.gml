
//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to 20 minutes (i.e. 60 frames per second * 60 seconds per minute * 20 minutes)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 20;

//Clutter determining alarm
alarm[2] = 60 * 20;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

//Give player some food to start
global.pantry.item_add("Lemon", "basic", 99, spr_food_basic, 1);

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

icon_menu(
50,
50,
[
[spr_btn_game, go_to_games],
[spr_btn_kitchen, go_to_kitchen],
[spr_btn_garden, go_to_garden],
]
);

