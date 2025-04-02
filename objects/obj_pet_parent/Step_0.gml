

var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);

if (global.game.evolution_queued == 0){
    // do the evolution dance!
    global.game.evolution_queued = 1;
    show_debug_message("attempting to switch pets");
        var _pet_x = obj_pet_parent.sprite_xoffset;
        var _pet_y = obj_pet_parent.sprite_yoffset;
        var _partsys = part_system_create(particle_evolution_1);
        part_system_position(_partsys, _pet_x, _pet_y);
        instance_destroy((obj_pet_parent));
            var pet_name = $"obj_pet_{global.game.current_pet_type}";
            var pet_object_index = asset_get_index(pet_name);
            instance_create_layer(_pet_x, _pet_y, "Instances", pet_object_index);
        }

