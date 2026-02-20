/// @description Kitchen Room Controller - handles feeding animation

// Check if we're here for a feeding animation
if (variable_global_exists("feeding_sprite") && global.feeding_sprite != undefined) {
    
    // Create the food animation object
    var food_anim = instance_create_layer(0, 0, "Instances", obj_food_animation);
    food_anim.food_sprite = global.feeding_sprite;
    food_anim.return_room = global.feeding_return_room;
    
    // Clear the globals
    global.feeding_sprite = undefined;
    global.feeding_return_room = undefined;
    
    show_debug_message("Created food animation with sprite: " + sprite_get_name(food_anim.sprite_index));
}

show_debug_message("Kitchen controller created!");
show_debug_message("Feeding sprite exists: " + string(variable_global_exists("feeding_sprite")));
if (variable_global_exists("feeding_sprite")) {
    show_debug_message("Feeding sprite: " + sprite_get_name(global.feeding_sprite));
}