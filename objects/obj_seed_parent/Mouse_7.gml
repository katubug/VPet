/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 0D1867D1
/// @DnDArgument : "var" "dragged"
dragged = 0;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 18A39B64
/// @DnDArgument : "var" "dragged"
if(dragged == 0){	/// @DnDAction : YoYo Games.Collisions.If_Object_At
	/// @DnDVersion : 1.1
	/// @DnDHash : 577ADCA9
	/// @DnDParent : 18A39B64
	/// @DnDArgument : "x_relative" "1"
	/// @DnDArgument : "y_relative" "1"
	/// @DnDArgument : "object" "obj_garden_plot"
	/// @DnDSaveInfo : "object" "obj_garden_plot"
	var l577ADCA9_0 = instance_place(x + 0, y + 0, [obj_garden_plot]);if ((l577ADCA9_0 > 0)){	/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 6BC0B95A
		/// @DnDParent : 577ADCA9
		/// @DnDArgument : "var" "obj_garden_plot.plot_seed_type"
		/// @DnDArgument : "value" ""none""
		if(obj_garden_plot.plot_seed_type == "none"){	/// @DnDAction : YoYo Games.Common.Variable
			/// @DnDVersion : 1
			/// @DnDHash : 4C10ADC8
			/// @DnDParent : 6BC0B95A
			/// @DnDArgument : "expr" ""joy""
			/// @DnDArgument : "var" "obj_garden_plot.plot_seed_type"
			obj_garden_plot.plot_seed_type = "joy";
		
			/// @DnDAction : YoYo Games.Instances.Destroy_Instance
			/// @DnDVersion : 1
			/// @DnDHash : 656F2965
			/// @DnDParent : 6BC0B95A
			instance_destroy();}}}