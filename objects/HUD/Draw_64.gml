/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 2BABFCCB
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Corns Owned: ""
/// @DnDArgument : "var" "global.pet.corns"
draw_text(x + 0, y + 0, string("Corns Owned: ") + string(global.pet.corns));

/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 75F23D4C
/// @DnDArgument : "x_relative" "1"
/// @DnDArgument : "y" "20"
/// @DnDArgument : "y_relative" "1"
/// @DnDArgument : "caption" ""Hunger: ""
/// @DnDArgument : "var" "global.pet.hunger"
draw_text(x + 0, y + 20, string("Hunger: ") + string(global.pet.hunger));

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