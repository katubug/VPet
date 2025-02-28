/// @DnDAction : YoYo Games.Common.Set_Global
/// @DnDVersion : 1
/// @DnDHash : 79418303
/// @DnDInput : 2
/// @DnDArgument : "value" """"
/// @DnDArgument : "value_1" "100"
/// @DnDArgument : "var" "inventory"
/// @DnDArgument : "var_1" "corns"
global.inventory = "";
global.corns = 100;

/// @DnDAction : YoYo Games.Data Structures.Create_List
/// @DnDVersion : 1
/// @DnDHash : 5468096C
/// @DnDArgument : "var" "global.inventory"
global.inventory = ds_list_create();