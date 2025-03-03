/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 0ED608B3
/// @DnDInput : 2
/// @DnDArgument : "output" "temp_hunger"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "output_1" "temp_health"
/// @DnDArgument : "output_temp_1" "1"
/// @DnDArgument : "var" "hunger"
/// @DnDArgument : "var_1" "health"
var temp_hunger = global.hunger;
var temp_health = global.health;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 2BD5FED4
/// @DnDArgument : "var" "temp_hunger"
/// @DnDArgument : "op" "2"
if(temp_hunger > 0){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 33933518
	/// @DnDParent : 2BD5FED4
	/// @DnDArgument : "expr" "max(temp_hunger-1,0)"
	/// @DnDArgument : "var" "temp_hunger"
	temp_hunger = max(temp_hunger-1,0);

	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 264D21D4
	/// @DnDParent : 2BD5FED4
	/// @DnDArgument : "value" "temp_hunger"
	/// @DnDArgument : "var" "hunger"
	global.hunger = temp_hunger;}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 51838DA4
else{	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 0028655D
	/// @DnDParent : 51838DA4
	/// @DnDArgument : "expr" "-1"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "temp_health"
	temp_health += -1;

	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 67B9B53F
	/// @DnDParent : 51838DA4
	/// @DnDArgument : "value" "temp_health"
	/// @DnDArgument : "var" "health"
	global.health = temp_health;}

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 689FA5E9
/// @DnDArgument : "steps" "60*20"
alarm_set(0, 60*20);