function icon_menu(_x, _y, _options, _description = -1) 
{
    with (instance_create_depth(_x, _y, -998, obj_menu_template)){
        options = _options;
        description = _description;
        options_count = array_length(_options);
        
        //Set up size
        margin = 15;
            
        for (var index = 0; index < options_count; index++)
        {
            object = _options[index][0];
            sprite = object_get_sprite(_options[index][0]);
            width = sprite_get_width(sprite);
            height = sprite_get_height(sprite);
            instance_create_depth(x + index * width, y, -999, object);
            
        }
        
        option_width = width * (options_count); // this line is explained at like 3:45
        
        width_full = option_width + (margin *2);
        height_full = height + (margin*2);
    }
}

//Following this tutorial: https://www.youtube.com/watch?v=0IUT_M1Mx_E

function go_to_kitchen() 
{
    room_goto(rm_kitchen);
}

function go_to_garden() 
{
    room_goto(rm_garden);
}

function go_to_games() 
{
    room_goto(rm_game_buttonmash);
    //room_goto(rm_game_runner);
}

function go_to_inventory()
{
    room_goto(rm_inventory);
}

function go_to_shop()
{
    room_goto(rm_shop);
}