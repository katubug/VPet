/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 7F0F22BA
/// @DnDApplyTo : {obj_pantry}
/// @DnDArgument : "var" "hasFood"
/// @DnDArgument : "op" "4"
/// @DnDArgument : "value" "1"
with(obj_pantry) var l7F0F22BA_0 = hasFood >= 1;
if(l7F0F22BA_0){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 6222631E
	/// @DnDApplyTo : {obj_pet_parent}
	/// @DnDParent : 7F0F22BA
	/// @DnDArgument : "expr" "min(obj_pet_parent.hunger+1,20)"
	/// @DnDArgument : "var" "hunger"
	with(obj_pet_parent) {
	hunger = min(obj_pet_parent.hunger+1,20);
	
	}}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 22698954
else{	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 358ABAF5
	/// @DnDBreak : 1

	/// @DnDParent : 22698954
	/// @DnDArgument : "x" "50"
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y" "50"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""Error: ""
	/// @DnDArgument : "var" "obj_pantry.hasFood"
	draw_text(x + 50, y + 50, string("Error: ") + string(obj_pantry.hasFood));}