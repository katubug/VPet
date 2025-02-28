/// @DnDAction : YoYo Games.Data Structures.Create_List
/// @DnDVersion : 1
/// @DnDHash : 5468096C
/// @DnDApplyTo : {game_controller_object}
/// @DnDArgument : "var" "list_inventory"
with(game_controller_object) {
list_inventory = ds_list_create();

}

/// @DnDAction : YoYo Games.Common.Set_Global
/// @DnDVersion : 1
/// @DnDHash : 79418303
/// @DnDInput : 2
/// @DnDArgument : "value" "list_inventory"
/// @DnDArgument : "value_1" "100"
/// @DnDArgument : "var" "inventory"
/// @DnDArgument : "var_1" "corns"
global.inventory = list_inventory;
global.corns = 100;