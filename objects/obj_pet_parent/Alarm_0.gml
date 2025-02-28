/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 33933518
/// @DnDInput : 3
/// @DnDArgument : "expr" "max(hunger-1,0)"
/// @DnDArgument : "expr_1" "max(hunger-1,0)"
/// @DnDArgument : "expr_2" "max(hunger-1,0)"
/// @DnDArgument : "var" "hunger"
/// @DnDArgument : "var_1" "happiness"
/// @DnDArgument : "var_2" "thirst"
hunger = max(hunger-1,0);
happiness = max(hunger-1,0);
thirst = max(hunger-1,0);

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 689FA5E9
/// @DnDArgument : "steps" "60*20"
alarm_set(0, 60*20);