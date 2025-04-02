    global.game.evolution_queued = 1;    
    var _pet_x = obj_pet_parent.x;
    var _pet_y = obj_pet_parent.y;  
    var _partsys = part_system_create(particle_evolution_1);
    part_system_position(_partsys, _pet_x, _pet_y);  
    instance_destroy((obj_pet_parent));
    var pet_name = $"obj_pet_{global.game.current_pet_type}";
    var pet_object_index = asset_get_index(pet_name);
    instance_create_layer(_pet_x, _pet_y, "Instances", pet_object_index);