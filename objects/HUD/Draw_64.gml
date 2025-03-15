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
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "40"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Are Dead: ""
/// @DnDArgument : "var" "global.petIsDead"
draw_text(x + 0, y + 40, string("Are Dead: ") + string(global.petIsDead));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 7EB3722C
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "60"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Current Room: ""
/// @DnDArgument : "var" "string(room_get_name(room))"
draw_text(x + 0, y + 60, string("Current Room: ") + string(string(room_get_name(room))));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 4A0A4988
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "80"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Pet Type: ""
/// @DnDArgument : "var" "string(global.pet_type)"
draw_text(x + 0, y + 80, string("Pet Type: ") + string(string(global.pet_type)));

/// @DnDAction : YoYo Games.Common.If_Expression
/// @DnDVersion : 1
/// @DnDHash : 4708D1E6
/// @DnDArgument : "expr" "room==rm_garden"
if(room==rm_garden){	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 3C65DC0A
	/// @DnDParent : 4708D1E6
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y" "100"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""Seed Planted: ""
	/// @DnDArgument : "var" "string(obj_garden_plot.plot_seed_type)"
	draw_text(x + 0, y + 100, string("Seed Planted: ") + string(string(obj_garden_plot.plot_seed_type)));}