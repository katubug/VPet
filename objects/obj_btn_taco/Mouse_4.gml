/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 27D0C31B
/// @DnDArgument : "output" "temp_corns"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "corns"
var temp_corns = global.corns;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 51F03A4F
/// @DnDArgument : "var" "temp_corns"
/// @DnDArgument : "op" "4"
/// @DnDArgument : "value" "5"
if(temp_corns >= 5){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 1C03F968
	/// @DnDParent : 51F03A4F
	/// @DnDArgument : "expr" "-5"
	/// @DnDArgument : "expr_relative" "1"
	/// @DnDArgument : "var" "temp_corns"
	temp_corns += -5;

	/// @DnDAction : YoYo Games.Data Structures.List_Add
	/// @DnDVersion : 1
	/// @DnDHash : 3A867DAD
	/// @DnDParent : 51F03A4F
	/// @DnDArgument : "var" "inventory"
	/// @DnDArgument : "value" "obj_food_taco"
	ds_list_add(inventory, obj_food_taco);

	/// @DnDAction : YoYo Games.Common.Set_Global
	/// @DnDVersion : 1
	/// @DnDHash : 4BE8B1BF
	/// @DnDParent : 51F03A4F
	/// @DnDArgument : "value" "temp_corns"
	/// @DnDArgument : "var" "corns"
	global.corns = temp_corns;}