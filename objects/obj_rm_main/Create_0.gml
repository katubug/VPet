if (obj_evolution_control.pet_evolution != 0){
    var pet_name = $"obj_pet_{obj_evolution_control.pet_evolution}";
    pet_object_index = asset_get_index(pet_name);
    instance_create_layer(500, 200, "Instances", pet_object_index);
}