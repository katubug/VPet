

var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);

if (global.game.evolution_queued == 0){
    // do the evolution dance!
    global.game.evolution_queued = 1;
    show_debug_message("attempting to switch pets");
        
        alarm[4] = 60;
        }

