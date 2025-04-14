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


//From Tosh in discord
function mouse_in_rectangle(current_option, options_number, mouse_x, mouse_y, array)
{
    var i = 0;
    repeat(options_number)
    {
        if point_in_rectangle(mouse_x,mouse_y,array[i].x1,array[i].y1,array[i].x2,array[i].y2)
        {
            return i;
        }
        i++;
    }    
}

function menu_options(sprite, x1,y1,x2,y2, optional_function = -1) constructor
{
    self.sprite = sprite;
    self.x1 = x1;
    self.y1 = y1;
    self.x2 = x2;
    self.y2 = y2;
    self.optional_function = optional_function;
}