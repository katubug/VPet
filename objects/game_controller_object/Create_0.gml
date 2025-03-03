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
/// @DnDInput : 5
/// @DnDArgument : "value" "list_inventory"
/// @DnDArgument : "value_1" "100"
/// @DnDArgument : "value_2" "20"
/// @DnDArgument : "value_3" "20"
/// @DnDArgument : "value_4" "20"
/// @DnDArgument : "var" "inventory"
/// @DnDArgument : "var_1" "corns"
/// @DnDArgument : "var_2" "hunger"
/// @DnDArgument : "var_3" "health"
/// @DnDArgument : "var_4" "happiness"
global.inventory = list_inventory;
global.corns = 100;
global.hunger = 20;
global.health = 20;
global.happiness = 20;