/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 33933518
/// @DnDArgument : "expr" "max(hunger-1,0)"
/// @DnDArgument : "expr_relative" "1"
/// @DnDArgument : "var" "hunger"
hunger += max(hunger-1,0);

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 689FA5E9
/// @DnDArgument : "steps" "60*20"
alarm_set(0, 60*20);