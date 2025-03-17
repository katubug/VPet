/// @DnDAction : YoYo Games.Data Structures.List_IndexOf
/// @DnDVersion : 1
/// @DnDHash : 3F6ADBB9
/// @DnDArgument : "var" "list_inventory"
variable = ds_list_find_index(list_inventory, 0);

/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 1532591F
/// @DnDArgument : "output" "temp_hunger"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "hunger"
var temp_hunger = global.hunger;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 6222631E
/// @DnDApplyTo : {obj_pet_parent}
/// @DnDArgument : "expr" "min(temp_hunger+1,20)"
/// @DnDArgument : "var" "temp_hunger"
with(obj_pet_parent) {
temp_hunger = min(temp_hunger+1,20);

}

/// @DnDAction : YoYo Games.Common.Set_Global
/// @DnDVersion : 1
/// @DnDHash : 5C089D80
/// @DnDArgument : "value" "temp_hunger"
/// @DnDArgument : "var" "hunger"
global.hunger = temp_hunger;