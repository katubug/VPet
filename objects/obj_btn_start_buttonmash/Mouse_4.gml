if(room == rm_game_buttonmash){
time_source_start(obj_room_buttonmash.button_mash_timer);
obj_room_buttonmash.game_on = true;
obj_room_buttonmash.outcome = "none";
}

if (room == rm_rps)
{
    obj_room_rps.games_on = 1
    //show_message(string(obj_room_rps.games_on))
}
