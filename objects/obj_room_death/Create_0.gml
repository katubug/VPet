/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 08CA093A
/// @DnDArgument : "var" "petIsDead"
/// @DnDArgument : "value" "true"
if(petIsDead == true){}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 36D2FB77
else{	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 4F74833B
	/// @DnDParent : 36D2FB77
	/// @DnDArgument : "caption" ""Wait a moment, how did you get here?""
	draw_text(0, 0, string("Wait a moment, how did you get here?") + "");}