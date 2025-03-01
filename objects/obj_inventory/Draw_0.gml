/// @DnDAction : YoYo Games.Drawing.Draw_Value
/// @DnDVersion : 1
/// @DnDHash : 7099CB3A
/// @DnDArgument : "caption" ""Inventory: ""
/// @DnDArgument : "var" "global.inventory"
draw_text(0, 0, string("Inventory: ") + string(global.inventory));

/// @DnDAction : YoYo Games.Loops.For_Loop
/// @DnDVersion : 1
/// @DnDHash : 53E75AE6
/// @DnDArgument : "init_temp" "1"
/// @DnDArgument : "cond" "i < ds_list_size(global.inventory)"
for(var i = 0; i < ds_list_size(global.inventory); i += 1) {	/// @DnDAction : YoYo Games.Data Structures.List_Get_At
	/// @DnDVersion : 1
	/// @DnDHash : 7BA3EDF2
	/// @DnDParent : 53E75AE6
	/// @DnDArgument : "assignee" "item"
	/// @DnDArgument : "var" "global.inventory"
	/// @DnDArgument : "index" "i"
	item = ds_list_find_value(global.inventory, i);

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 4CFE0688
	/// @DnDParent : 53E75AE6
	/// @DnDArgument : "expr" "item.display_name"
	/// @DnDArgument : "var" "item_name"
	item_name = item.display_name;

	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 5E7761FD
	/// @DnDParent : 53E75AE6
	/// @DnDArgument : "x" "10"
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y" "30 + (i * 20)"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "var" "string(item_name)"
	draw_text(x + 10, y + 30 + (i * 20), string("Caption: ") + string(string(item_name)));}