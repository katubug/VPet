if(room == rm_game_buttonmash){
time_source_start(obj_room_buttonmash.button_mash_timer);
obj_room_buttonmash.game_on = true;
obj_room_buttonmash.outcome = "none";
}

if (room == rm_rps)
{
    if (obj_room_rps.round_number <=3){
    obj_room_rps.game_on = 1;
    obj_room_rps.player_choice = -1;
    }
    else {
        obj_room_rps._game_complete = 1;
    }
}
