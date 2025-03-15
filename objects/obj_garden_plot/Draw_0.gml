/// @DnDAction : YoYo Games.Drawing.Draw_Self
/// @DnDVersion : 1
/// @DnDHash : 2B47ECAF
draw_self();

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 43B413CD
/// @DnDArgument : "var" "plot_seed_type"
/// @DnDArgument : "value" ""obj_seed_joy""
if(plot_seed_type == "obj_seed_joy"){	/// @DnDAction : YoYo Games.Drawing.Draw_Gradient_Ellipse
	/// @DnDVersion : 1
	/// @DnDHash : 7B60A5A3
	/// @DnDParent : 43B413CD
	/// @DnDArgument : "x1" "plot_x-10"
	/// @DnDArgument : "y1" "plot_y-10"
	/// @DnDArgument : "x2" "plot_x+20"
	/// @DnDArgument : "y2" "plot_y+20"
	/// @DnDArgument : "col1" "$FFF26BFF"
	/// @DnDArgument : "col2" "$FFFF7FEE"
	/// @DnDArgument : "fill" "1"
	draw_ellipse_colour(plot_x-10, plot_y-10, plot_x+20, plot_y+20, $FFF26BFF & $FFFFFF, $FFFF7FEE & $FFFFFF, 0);}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 2AE71C3A
/// @DnDArgument : "var" "plot_seed_type"
/// @DnDArgument : "value" ""obj_seed_plain""
if(plot_seed_type == "obj_seed_plain"){	/// @DnDAction : YoYo Games.Drawing.Draw_Gradient_Ellipse
	/// @DnDVersion : 1
	/// @DnDHash : 3DCB5B6E
	/// @DnDParent : 2AE71C3A
	/// @DnDArgument : "x1" "plot_x-10"
	/// @DnDArgument : "y1" "plot_y-10"
	/// @DnDArgument : "x2" "plot_x+20"
	/// @DnDArgument : "y2" "plot_y+20"
	/// @DnDArgument : "fill" "1"
	draw_ellipse_colour(plot_x-10, plot_y-10, plot_x+20, plot_y+20, $FFFFFF & $FFFFFF, $FFFFFF & $FFFFFF, 0);}