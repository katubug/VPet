/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 307E073D
/// @DnDArgument : "var" "dragged"
if(dragged == 0){	/// @DnDAction : YoYo Games.Common.Exit_Event
	/// @DnDVersion : 1
	/// @DnDHash : 1C935399
	/// @DnDParent : 307E073D
	exit;}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 024166CD
else{	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 5CBB261B
	/// @DnDInput : 2
	/// @DnDParent : 024166CD
	/// @DnDArgument : "expr" "mouse_x+xx"
	/// @DnDArgument : "expr_1" "mouse_y+yy"
	/// @DnDArgument : "var" "x"
	/// @DnDArgument : "var_1" "y"
	x = mouse_x+xx;
	y = mouse_y+yy;}