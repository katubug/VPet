/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 2BABFCCB
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Corns Owned: ""
/// @DnDArgument : "var" "global.corns"
draw_text(x + 0, y + 0, string("Corns Owned: ") + string(global.corns));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 75F23D4C
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "20"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Hunger: ""
/// @DnDArgument : "var" "global.hunger"
draw_text(x + 0, y + 20, string("Hunger: ") + string(global.hunger));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 07D97B47
/// @DnDArgument : "caption" ""Are Dead: ""
/// @DnDArgument : "var" "global.petIsDead"
draw_text(0, 0, string("Are Dead: ") + string(global.petIsDead));