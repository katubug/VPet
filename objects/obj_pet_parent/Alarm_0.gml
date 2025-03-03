/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 0ED608B3
/// @DnDInput : 3
/// @DnDArgument : "output" "temp_hunger"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "output_1" "temp_health"
/// @DnDArgument : "output_temp_1" "1"
/// @DnDArgument : "output_2" "temp_happiness"
/// @DnDArgument : "output_temp_2" "1"
/// @DnDArgument : "var" "hunger"
/// @DnDArgument : "var_1" "health"
/// @DnDArgument : "var_2" "happiness"
var temp_hunger = global.hunger;
var temp_health = global.health;
var temp_happiness = global.happiness;

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

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 2647767A
/// @DnDArgument : "var" "temp_happiness"
/// @DnDArgument : "op" "2"
if(temp_happiness > 0){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 7A54B59C
	/// @DnDParent : 2647767A
	/// @DnDArgument : "expr" "max(temp_happiness-1,0)"
	/// @DnDArgument : "var" "temp_happiness"
	temp_happiness = max(temp_happiness-1,0);

	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 2B1317A1
	/// @DnDParent : 2647767A
	/// @DnDArgument : "value" "temp_happiness"
	/// @DnDArgument : "var" "happiness"
	global.happiness = temp_happiness;}

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 689FA5E9
/// @DnDArgument : "steps" "60*20"
alarm_set(0, 60*20);