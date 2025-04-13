function go_to_kitchen() 
{
    show_debug_message("going to kitchen");
    room_goto(rm_kitchen);
}

function go_to_garden() 
{
    room_goto(rm_garden);
}

function go_to_games() 
{
    room_goto(rm_game_buttonmash);
}