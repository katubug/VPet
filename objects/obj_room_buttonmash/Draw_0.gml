/// @DnDAction : YoYo Games.Drawing.Draw_Sprite
/// @DnDVersion : 1
/// @DnDHash : 7CE39C1A
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "sprite" "bar_border"
/// @DnDSaveInfo : "sprite" "bar_border"
draw_sprite(bar_border, 0, x + 0, y + 0);

/// @DnDAction : YoYo Games.Drawing.Draw_Sprite_Transformed
/// @DnDVersion : 1
/// @DnDHash : 6698EC0F
/// @DnDArgument : "x" "2"
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "2"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "xscale" "click_count/max_clicks"
/// @DnDArgument : "sprite" "bar_stretch"
/// @DnDSaveInfo : "sprite" "bar_stretch"
draw_sprite_ext(bar_stretch, 0, x + 2, y + 2, click_count/max_clicks, 1, 0, $FFFFFF & $ffffff, 1);