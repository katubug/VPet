/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 6222631E
/// @DnDApplyTo : {obj_pet_parent}
/// @DnDArgument : "expr" "min(obj_pet_parent.hunger+1,20)"
/// @DnDArgument : "var" "hunger"
with(obj_pet_parent) {
hunger = min(obj_pet_parent.hunger+1,20);

}