/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 55FF544C
/// @DnDInput : 6
/// @DnDArgument : "expr" "10"
/// @DnDArgument : "expr_1" "10"
/// @DnDArgument : "expr_2" "x"
/// @DnDArgument : "expr_3" "y"
/// @DnDArgument : "expr_4" "layer_tilemap_get_id("Tiles_Col")"
/// @DnDArgument : "expr_5" "1"
/// @DnDArgument : "var" "hunger"
/// @DnDArgument : "var_1" "happiness"
/// @DnDArgument : "var_2" "target_x"
/// @DnDArgument : "var_3" "target_y"
/// @DnDArgument : "var_4" "tilemap"
/// @DnDArgument : "var_5" "move_speed"
hunger = 10;
happiness = 10;
target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 031B2BB5
/// @DnDInput : 2
/// @DnDArgument : "steps" "60*20"
/// @DnDArgument : "alarm_1" "1"
alarm_set(0, 60*20);
alarm_set(1, 30);