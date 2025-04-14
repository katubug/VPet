function text_menu(_x, _y, _options, _description = -1) 
{
    with (instance_create_depth(_x, _y, -999, obj_menu_template)){
        options = _options;
        description = _description;
        options_count = array_length(_options);
        hovermarker = "* ";
        
        //Set up size
        margin = 15;
        draw_set_font(fnt_Quicksand);
        
        width = 10;
        if (_description != 1) width = max(width, string_width(_description));
            
        for (var index = 0; index < options_count; index++)
        {
            //for text based
            width = max(width, string_width(_options[index][0]));
        }
        width += string_width(hovermarker);
        
        
        option_width = width * (options_count); // this line is explained at like 3:45
        height = 100;
        
        width_full = option_width + (margin *2);
        height_full = 100 + (margin*2);
    }
}

function icon_menu(_x, _y, _options, _description = -1) 
{
    with (instance_create_depth(_x, _y, -999, obj_menu_template)){
        options = _options;
        description = _description;
        options_count = array_length(_options);
        
        //Set up size
        margin = 15;
            
        for (var index = 0; index < options_count; index++)
        {
            width = sprite_get_width(_options[index].sprite);
            height = sprite_get_height(_options[index].sprite);
            //x = x + index * width;
        }
        
        option_width = width * (options_count); // this line is explained at like 3:45
        
        width_full = option_width + (margin *2);
        height_full = 100 + (margin*2);
    }
}

//Following this tutorial: https://www.youtube.com/watch?v=0IUT_M1Mx_E