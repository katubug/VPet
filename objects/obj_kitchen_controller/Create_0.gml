/// @description Kitchen Room Controller - handles feeding animation

show_debug_message("=== KITCHEN CONTROLLER CREATE ===");
show_debug_message("Checking for feeding_sprite global...");

// Check if we're here for a feeding animation
if (variable_global_exists("feeding_sprite")) {
    show_debug_message("feeding_sprite global EXISTS");
    
    if (global.feeding_sprite != undefined) {
        show_debug_message("feeding_sprite is DEFINED: " + sprite_get_name(global.feeding_sprite));
        
        // Create the food animation object
        var food_anim = instance_create_layer(0, 0, "Instances", obj_food_animation);
        food_anim.food_sprite = global.feeding_sprite;
        food_anim.return_room = global.feeding_return_room;
        
        show_debug_message("Created food animation object!");
        show_debug_message("Animation sprite_index: " + sprite_get_name(food_anim.sprite_index));
        
        // Clear the globals
        global.feeding_sprite = undefined;
        global.feeding_return_room = undefined;
    } else {
        show_debug_message("feeding_sprite global is UNDEFINED");
    }
} else {
    show_debug_message("feeding_sprite global DOES NOT EXIST");
    show_debug_message("This is normal if you entered kitchen without feeding");
}
