/// @DnDAction : YoYo Games.Common.Execute_Code
/// @DnDVersion : 1
/// @DnDHash : 582BB086
/// @DnDArgument : "code" "/// @description Execute Code$(13_10)var _hor = clamp(target_x - x, -1, 1);$(13_10)var _ver = clamp(target_y - y, -1, 1);$(13_10)$(13_10)move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);"
/// @description Execute Code
var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);