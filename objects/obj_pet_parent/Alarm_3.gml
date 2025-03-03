/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 20C49C1B
/// @DnDInput : 3
/// @DnDArgument : "output" "temp_happiness"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "output_1" "temp_hunger"
/// @DnDArgument : "output_temp_1" "1"
/// @DnDArgument : "output_2" "temp_health"
/// @DnDArgument : "output_temp_2" "1"
/// @DnDArgument : "var" "happiness"
/// @DnDArgument : "var_1" "hunger"
/// @DnDArgument : "var_2" "health"
var temp_happiness = global.happiness;
var temp_hunger = global.hunger;
var temp_health = global.health;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 090B1356
/// @DnDArgument : "var" "temp_happiness"
/// @DnDArgument : "op" "4"
if(temp_happiness >= 0){	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 620AA45D
	/// @DnDParent : 090B1356
	/// @DnDArgument : "var" "temp_hunger"
	/// @DnDArgument : "op" "4"
	/// @DnDArgument : "value" "10"
	if(temp_hunger >= 10){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 4F3D1EA9
		/// @DnDParent : 620AA45D
		/// @DnDArgument : "expr" "min(temp_health+1,20)"
		/// @DnDArgument : "var" "temp_health"
		temp_health = min(temp_health+1,20);
	
		/// @DnDAction : YoYo Games.Common.Set_Global
		/// @DnDVersion : 1
		/// @DnDHash : 587A92F7
		/// @DnDParent : 620AA45D
		/// @DnDArgument : "value" "temp_health"
		/// @DnDArgument : "var" "health"
		global.health = temp_health;}}

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 1D74100E
/// @DnDArgument : "steps" "60*20"
/// @DnDArgument : "alarm" "3"
alarm_set(3, 60*20);