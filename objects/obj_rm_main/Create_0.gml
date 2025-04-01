if (global.game.current_pet_type != ""){
    var pet_name = $"obj_pet_{global.game.current_pet_type}";
    show_debug_message(pet_name);
    pet_object_index = asset_get_index(pet_name);
    show_debug_message(pet_object_index)
    instance_create_layer(200, 380, "Instances", pet_object_index);
} else {
    show_debug_message("no pet type has been selected?");
}