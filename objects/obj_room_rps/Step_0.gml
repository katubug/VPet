/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 4871807F
/// @DnDArgument : "var" "games_on"
/// @DnDArgument : "value" "1"
if(games_on == 1){	/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
	/// @DnDVersion : 1
	/// @DnDHash : 7D89C452
	/// @DnDParent : 4871807F
	/// @DnDArgument : "key" "ord("R")"
	var l7D89C452_0;l7D89C452_0 = keyboard_check_pressed(ord("R"));if (l7D89C452_0){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 62E2DBD6
		/// @DnDParent : 7D89C452
		/// @DnDArgument : "var" "player_choice"
		player_choice = 0;}

	/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
	/// @DnDVersion : 1
	/// @DnDHash : 4527A4D4
	/// @DnDParent : 4871807F
	/// @DnDArgument : "key" "ord("P")"
	var l4527A4D4_0;l4527A4D4_0 = keyboard_check_pressed(ord("P"));if (l4527A4D4_0){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 6A0F17A6
		/// @DnDParent : 4527A4D4
		/// @DnDArgument : "expr" "1"
		/// @DnDArgument : "var" "player_choice"
		player_choice = 1;}

	/// @DnDAction : YoYo Games.Mouse & Keyboard.If_Key_Pressed
	/// @DnDVersion : 1
	/// @DnDHash : 29F09EAD
	/// @DnDParent : 4871807F
	/// @DnDArgument : "key" "ord("S")"
	var l29F09EAD_0;l29F09EAD_0 = keyboard_check_pressed(ord("S"));if (l29F09EAD_0){	/// @DnDAction : YoYo Games.Common.Variable
		/// @DnDVersion : 1
		/// @DnDHash : 46635D98
		/// @DnDParent : 29F09EAD
		/// @DnDArgument : "expr" "2"
		/// @DnDArgument : "var" "player_choice"
		player_choice = 2;}

	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 32F72A86
	/// @DnDParent : 4871807F
	/// @DnDArgument : "expr" "irandom_range(0, 2)"
	/// @DnDArgument : "var" "computer_choice"
	computer_choice = irandom_range(0, 2);

	/// @DnDAction : YoYo Games.Common.If_Variable
	/// @DnDVersion : 1
	/// @DnDHash : 1E050DFF
	/// @DnDParent : 4871807F
	/// @DnDArgument : "var" "player_choice"
	/// @DnDArgument : "not" "1"
	/// @DnDArgument : "value" "-1"
	if(!(player_choice == -1)){	/// @DnDAction : YoYo Games.Common.If_Variable
		/// @DnDVersion : 1
		/// @DnDHash : 2D13D491
		/// @DnDParent : 1E050DFF
		/// @DnDArgument : "var" "computer_choice"
		/// @DnDArgument : "not" "1"
		/// @DnDArgument : "value" "-1"
		if(!(computer_choice == -1)){	/// @DnDAction : YoYo Games.Common.If_Expression
			/// @DnDVersion : 1
			/// @DnDHash : 6EBB75A6
			/// @DnDParent : 2D13D491
			/// @DnDArgument : "expr" "player_choice == computer_choice"
			if(player_choice == computer_choice){	/// @DnDAction : YoYo Games.Drawing.Draw_Value
				/// @DnDVersion : 1
				/// @DnDHash : 653B1024
				/// @DnDParent : 6EBB75A6
				/// @DnDArgument : "caption" ""Draw, replay the round.""
				draw_text(0, 0, string("Draw, replay the round.") + "");}}}}