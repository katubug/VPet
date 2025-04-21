/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 38ED834A
/// @DnDArgument : "var" "global.game.ownername"
/// @DnDArgument : "value" """"
if(global.game.ownername == ""){	/// @DnDAction : YoYo Games.Rooms.Go_To_Room
	/// @DnDVersion : 1
	/// @DnDHash : 2F3CB3DE
	/// @DnDParent : 38ED834A
	/// @DnDArgument : "room" "room_main"
	room_goto(room_main);}