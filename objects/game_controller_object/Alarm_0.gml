/// @DnDAction : YoYo Games.Common.Get_Global
/// @DnDVersion : 1
/// @DnDHash : 10A4E361
/// @DnDArgument : "output" "temp_health"
/// @DnDArgument : "var" "health"
temp_health = global.health;

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 08962B3C
/// @DnDArgument : "var" "temp_health"
/// @DnDArgument : "op" "3"
if(temp_health <= 0){	/// @DnDAction : YoYo Games.Common.Variable
	/// @DnDVersion : 1
	/// @DnDHash : 3B6FB8C7
	/// @DnDParent : 08962B3C
	/// @DnDArgument : "expr" "true"
	/// @DnDArgument : "var" "petIsDead"
	petIsDead = true;}

/// @DnDAction : YoYo Games.Common.If_Variable
/// @DnDVersion : 1
/// @DnDHash : 20867636
/// @DnDArgument : "var" "petIsDead"
/// @DnDArgument : "value" "true"
if(petIsDead == true){	/// @DnDAction : YoYo Games.Rooms.Go_To_Room
	/// @DnDVersion : 1
	/// @DnDHash : 1FAA81A3
	/// @DnDParent : 20867636
	/// @DnDArgument : "room" "rm_death"
	/// @DnDSaveInfo : "room" "rm_death"
	room_goto(rm_death);}

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 3B421A23
/// @DnDArgument : "steps" "60"
alarm_set(0, 60);