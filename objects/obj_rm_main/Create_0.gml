if (obj_evolution_control.pet_evolution != 0){
    var pet_name = $"obj_pet_{obj_evolution_control.pet_evolution}";
    pet_object_index = asset_get_index(pet_name);
    show_debug_message(pet_name);
    show_debug_message(pet_object_index);
    instance_create_layer(500, 200, "Instances", pet_object_index);
}