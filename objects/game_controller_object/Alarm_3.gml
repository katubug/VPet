// do the evolution dance!
if (instance_exists(obj_pet_parent)) {
    instance_destroy((obj_pet_parent));
        var pet_name = $"obj_pet_{global.game.current_pet_type}";
        pet_object_index = asset_get_index(pet_name);
        instance_create_layer(200, 380, "Instances", pet_object_index);
    } else {
        show_debug_message("no pet type has been selected?");
    }