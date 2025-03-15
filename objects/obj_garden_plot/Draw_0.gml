/// @DnDAction : YoYo Games.Drawing.Draw_Self
/// @DnDVersion : 1
/// @DnDHash : 3BEF30EE
draw_self();

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 43B413CD
/// @DnDArgument : "var" "plot_seed_type"
/// @DnDArgument : "value" ""joy""
if(plot_seed_type == "joy"){	/// @DnDAction : YoYo Games.Drawing.Draw_Gradient_Ellipse
	/// @DnDVersion : 1
	/// @DnDHash : 7B60A5A3
	/// @DnDParent : 43B413CD
	/// @DnDArgument : "x1_relative" "1"
	/// @DnDArgument : "y1_relative" "1"
	/// @DnDArgument : "col1" "$FFF26BFF"
	/// @DnDArgument : "col2" "$FFFF7FEE"
	/// @DnDArgument : "fill" "1"
	draw_ellipse_colour(x + 0, y + 0, 0, 0, $FFF26BFF & $FFFFFF, $FFFF7FEE & $FFFFFF, 0);}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 2AE71C3A
/// @DnDArgument : "var" "plot_seed_type"
/// @DnDArgument : "value" ""plain""
if(plot_seed_type == "plain"){	/// @DnDAction : YoYo Games.Drawing.Draw_Gradient_Ellipse
	/// @DnDVersion : 1
	/// @DnDHash : 3DCB5B6E
	/// @DnDParent : 2AE71C3A
	/// @DnDArgument : "x1_relative" "1"
	/// @DnDArgument : "y1_relative" "1"
	draw_ellipse_colour(x + 0, y + 0, 0, 0, $FFFFFF & $FFFFFF, $FFFFFF & $FFFFFF, 1);}