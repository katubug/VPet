/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 0ED608B3
/// @DnDArgument : "output" "temp_hunger"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "hunger"
var temp_hunger = global.hunger;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 33933518
/// @DnDArgument : "expr" "max(temp_hunger-1,0)"
/// @DnDArgument : "var" "temp_hunger"
temp_hunger = max(temp_hunger-1,0);

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 689FA5E9
/// @DnDArgument : "steps" "60*20"
alarm_set(0, 60*20);