if(room == rm_initial)
{
	if (obj_initial_setup.playername != "") room_goto(rm_main);
        else obj_initial_setup.playername = keyboard_string;
}