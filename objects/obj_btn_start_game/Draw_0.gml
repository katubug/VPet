if (room == rm_rps){
    if (obj_room_rps.game_on ==0 && obj_room_rps.game_complete != 1) draw_self()
}
else if (room == rm_game_buttonmash){
    if (obj_buttonmash_controller.game_on == 0) draw_self();
}