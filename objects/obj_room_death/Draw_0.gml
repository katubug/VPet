/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 1B3BDF47
/// @DnDArgument : "output" "temp_petIsDead"
/// @DnDArgument : "output_temp" "1"
/// @DnDArgument : "var" "petIsDead"
var temp_petIsDead = global.petIsDead;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 77143E6C
/// @DnDArgument : "var" "temp_petIsDead"
/// @DnDArgument : "value" "1"
if(temp_petIsDead == 1){	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 048ABC21
	/// @DnDParent : 77143E6C
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""Your pet has been claimed by death. Would you like to try to reclaim it?""
	draw_text(x + 0, y + 0, string("Your pet has been claimed by death. Would you like to try to reclaim it?") + "");

	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 170F68F6
	/// @DnDParent : 77143E6C
	/// @DnDArgument : "xpos_relative" "1"
	/// @DnDArgument : "ypos" "40"
	/// @DnDArgument : "ypos_relative" "1"
	/// @DnDArgument : "objectid" "obj_btn_death_yes"
	/// @DnDSaveInfo : "objectid" "obj_btn_death_yes"
	instance_create_layer(x + 0, y + 40, "Instances", obj_btn_death_yes);

	/// @DnDAction : YoYo Games.Instances.Create_Instance
	/// @DnDVersion : 1
	/// @DnDHash : 7D256687
	/// @DnDParent : 77143E6C
	/// @DnDArgument : "xpos" "40"
	/// @DnDArgument : "xpos_relative" "1"
	/// @DnDArgument : "ypos" "40"
	/// @DnDArgument : "ypos_relative" "1"
	/// @DnDArgument : "objectid" "obj_btn_death_no"
	/// @DnDSaveInfo : "objectid" "obj_btn_death_no"
	instance_create_layer(x + 40, y + 40, "Instances", obj_btn_death_no);}

/// @DnDAction : YoYo Games.Common.Else
/// @DnDVersion : 1
/// @DnDHash : 2AB5C872
else{	/// @DnDAction : YoYo Games.Drawing.Draw_Value
	/// @DnDVersion : 1
	/// @DnDHash : 7A7CC7F0
	/// @DnDParent : 2AB5C872
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "caption" ""How on earth did you get here?""
	draw_text(x + 0, y + 0, string("How on earth did you get here?") + "");}