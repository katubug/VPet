/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 1368892D
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Health: ""
/// @DnDArgument : "var" "global.health"
draw_text(x + 0, y + 0, string("Health: ") + string(global.health));

/// @DnDAction : YoYo Games.Drawing.Draw_Rectangle
/// @DnDVersion : 1
/// @DnDHash : 7241BD34
/// @DnDArgument : "x1" "50"
/// @DnDArgument : "x1_relative" "1"
/// @DnDArgument : "y1" "50"
/// @DnDArgument : "y1_relative" "1"
/// @DnDArgument : "x2" "50+(200*(global.health/20))"
/// @DnDArgument : "x2_relative" "1"
/// @DnDArgument : "y2" "70"
/// @DnDArgument : "y2_relative" "1"
/// @DnDArgument : "fill" "1"
draw_rectangle(x + 50, y + 50, x + 50+(200*(global.health/20)), y + 70, 0);