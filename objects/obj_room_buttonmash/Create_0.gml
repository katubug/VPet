/// @DnDAction : YoYo Games.Common.Function
/// @DnDVersion : 1
/// @DnDHash : 2FE2DC2A
/// @DnDArgument : "funcName" "times_up"
/// @DnDArgument : "arg" "msg"
/// @DnDArgument : "temp" "1"
var times_up = function(msg) {	/// @DnDAction : YoYo Games.Miscellaneous.Debug_Show_Message
	/// @DnDVersion : 1
	/// @DnDHash : 29A0A9DC
	/// @DnDParent : 2FE2DC2A
	/// @DnDArgument : "msg" "msg"
	show_debug_message(string(msg));}

/// @DnDAction : YoYo Games.Time.Time_Source_Create
/// @DnDVersion : 1
/// @DnDHash : 022B95E1
/// @DnDArgument : "idx" "button_mash_timer"
/// @DnDArgument : "parent" "time_source_game"
/// @DnDArgument : "period" "5"
/// @DnDArgument : "callback" "times_up"
/// @DnDArgument : "args" "["Time's Up!"]"
button_mash_timer = time_source_create(time_source_game, 5, time_source_units_seconds, times_up, ["Time's Up!"], 1, time_source_expire_after);

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 30D1B6D3
/// @DnDInput : 3
/// @DnDArgument : "expr_1" "30"
/// @DnDArgument : "expr_2" "15"
/// @DnDArgument : "var" "click_count"
/// @DnDArgument : "var_1" "max_clicks"
/// @DnDArgument : "var_2" "click_goal"
click_count = 0;
max_clicks = 30;
click_goal = 15;