/// @DnDAction : YoYo Games.Drawing.Draw_Sprite
/// @DnDVersion : 1
/// @DnDHash : 7CE39C1A
/// @DnDArgument : "x" "10"
/// @DnDArgument : "y" "10"
/// @DnDArgument : "sprite" "bar_border"
/// @DnDSaveInfo : "sprite" "bar_border"
draw_sprite(bar_border, 0, 10, 10);

/// @DnDAction : YoYo Games.Drawing.Draw_Sprite_Transformed
/// @DnDVersion : 1
/// @DnDHash : 6698EC0F
/// @DnDArgument : "xscale" "click_count/max_clicks"
/// @DnDArgument : "sprite" "bar_stretch"
/// @DnDSaveInfo : "sprite" "bar_stretch"
draw_sprite_ext(bar_stretch, 0, 0, 0, click_count/max_clicks, 1, 0, $FFFFFF & $ffffff, 1);