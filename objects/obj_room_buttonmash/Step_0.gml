/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Pressed
/// @DnDVersion : 1.1
/// @DnDHash : 6368937C
var l6368937C_0;l6368937C_0 = mouse_check_button_pressed(mb_left);if (l6368937C_0){	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 65B7D901
	/// @DnDParent : 6368937C
	/// @DnDArgument : "var" "click_count"
	/// @DnDArgument : "op" "1"
	/// @DnDArgument : "value" "max_clicks"
	if(click_count < max_clicks){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 2FE279A6
		/// @DnDParent : 65B7D901
		/// @DnDArgument : "expr" "1"
		/// @DnDArgument : "expr_relative" "1"
		/// @DnDArgument : "var" "click_count"
		click_count += 1;}}