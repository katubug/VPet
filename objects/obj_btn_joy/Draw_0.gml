/// @DnDAction : YoYo Games.Drawing.Draw_Self
/// @DnDVersion : 1
/// @DnDHash : 7E5311A3
draw_self();

/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 03ECBF0F
/// @DnDArgument : "output" "temp_pet_type"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "pet_type"
var temp_pet_type = global.pet_type;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 31E6DA39
/// @DnDArgument : "var" "temp_pet_type"
/// @DnDArgument : "value" ""joy""
if(temp_pet_type == "joy"){	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 1D09844A
	/// @DnDParent : 31E6DA39
	/// @DnDArgument : "caption" ""You will start the game with a""
	/// @DnDArgument : "var" ""joy-type pet.""
	draw_text(0, 0, string("You will start the game with a") + string("joy-type pet."));}