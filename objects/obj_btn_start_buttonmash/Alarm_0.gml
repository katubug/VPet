/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 54161155
/// @DnDArgument : "caption" ""Time Left: ""
/// @DnDArgument : "var" "obj_room_buttonmash.button_mash_timer"
draw_text(0, 0, string("Time Left: ") + string(obj_room_buttonmash.button_mash_timer));

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 6FD5C6D9
alarm_set(0, 30);