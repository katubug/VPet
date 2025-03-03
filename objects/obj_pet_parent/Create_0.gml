/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 55FF544C
/// @DnDInput : 4
/// @DnDArgument : "expr" "x"
/// @DnDArgument : "expr_1" "y"
/// @DnDArgument : "expr_2" "layer_tilemap_get_id("Tiles_Col")"
/// @DnDArgument : "expr_3" "1"
/// @DnDArgument : "var" "target_x"
/// @DnDArgument : "var_1" "target_y"
/// @DnDArgument : "var_2" "tilemap"
/// @DnDArgument : "var_3" "move_speed"
target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 031B2BB5
/// @DnDInput : 3
/// @DnDArgument : "steps" "60*20"
/// @DnDArgument : "steps_2" "60*20"
/// @DnDArgument : "alarm_1" "1"
/// @DnDArgument : "alarm_2" "3"
alarm_set(0, 60*20);
alarm_set(1, 30);
alarm_set(3, 60*20);