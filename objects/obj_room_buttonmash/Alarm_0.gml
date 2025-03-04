/// @DnDAction : YoYo Games.Time.Time_Source_Get_Time_Remaining
/// @DnDVersion : 1
/// @DnDHash : 739E03FE
/// @DnDArgument : "var" "time_left"
/// @DnDArgument : "idx" "button_mash_timer"
time_left = time_source_get_time_remaining(button_mash_timer);

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 1AF18E70
/// @DnDArgument : "var" "time_left"
draw_text(0, 0, string("Caption: ") + string(time_left));

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 0FB57B54
alarm_set(0, 30);