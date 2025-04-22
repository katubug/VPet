if(room == rm_game_buttonmash){
time_source_start(obj_buttonmash_controller.button_mash_timer);
obj_buttonmash_controller.game_on = true;
obj_buttonmash_controller.outcome = "none";
}

//if (room == rm_rps)
//{
    //if (obj_room_rps.round_number <=3){
    //obj_room_rps.game_on = 1;
    //obj_room_rps.player_choice = -1;
    //}
    //else {
        //obj_room_rps._game_complete = 1;
    //}
//}
