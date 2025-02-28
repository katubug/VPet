/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 55FF544C
/// @DnDInput : 9
/// @DnDArgument : "expr" "10"
/// @DnDArgument : "expr_1" "10"
/// @DnDArgument : "expr_2" "10"
/// @DnDArgument : "expr_3" "10"
/// @DnDArgument : "expr_4" "10"
/// @DnDArgument : "expr_5" "x"
/// @DnDArgument : "expr_6" "y"
/// @DnDArgument : "expr_7" "layer_tilemap_get_id("Tiles_Col")"
/// @DnDArgument : "expr_8" "1"
/// @DnDArgument : "var" "hunger"
/// @DnDArgument : "var_1" "happiness"
/// @DnDArgument : "var_2" "thirst"
/// @DnDArgument : "var_3" "energy"
/// @DnDArgument : "var_4" "temperature"
/// @DnDArgument : "var_5" "target_x"
/// @DnDArgument : "var_6" "target_y"
/// @DnDArgument : "var_7" "tilemap"
/// @DnDArgument : "var_8" "move_speed"
hunger = 10;
happiness = 10;
thirst = 10;
energy = 10;
temperature = 10;
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