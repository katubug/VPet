/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Mouse_Pressed
/// @DnDVersion : 1.1
/// @DnDHash : 6368937C
/// @DnDApplyTo : all
/// @DnDArgument : "button" "mb_any"
var l6368937C_0;with(all) l6368937C_0 = mouse_check_button_pressed(mb_any);if (l6368937C_0){	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 65B7D901
	/// @DnDParent : 6368937C
	/// @DnDArgument : "var" "click_count"
	/// @DnDArgument : "op" "3"
	/// @DnDArgument : "value" "max_clicks"
	if(click_count <= max_clicks){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 2FE279A6
		/// @DnDParent : 65B7D901
		/// @DnDArgument : "expr" "1"
		/// @DnDArgument : "expr_relative" "1"
		/// @DnDArgument : "var" "click_count"
		click_count += 1;}}