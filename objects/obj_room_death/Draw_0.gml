/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 1B3BDF47
/// @DnDArgument : "output" "temp_petIsDead"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "petIsDead"
var temp_petIsDead = global.petIsDead;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 77143E6C
/// @DnDArgument : "var" "temp_petIsDead"
/// @DnDArgument : "value" "true"
if(temp_petIsDead == true){	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 048ABC21
	/// @DnDParent : 77143E6C
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""
	/// @DnDArgument : "var" ""Your pet has been claimed by death. Would you like to try to reclaim it?""
	draw_text(x + 0, y + 0,  + string("Your pet has been claimed by death. Would you like to try to reclaim it?"));}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 2AB5C872
else{	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 48AE172D
	/// @DnDParent : 2AB5C872
	/// @DnDArgument : "caption" ""How on earth did you get here?""
	draw_text(0, 0, string("How on earth did you get here?") + "");}