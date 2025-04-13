function Menu(_x, _y, _options, _description = -1) 
{
    with (instance_create_depth(_x, _y, -999, obj_menu_template)){
        options = _options;
        description = _description;
        options_count = array_length(_options);
        hovermarker = "* ";
        
        //Set up size
        margin = 15;
        draw_set_font(fnt_Quicksand);
        
        width = 100;
        if (_description != 1) width = max(width, string_width(_description));
            
        for (var index = 0; index < options_count; index++)
        {
            width = max(width, string_width(_options[index][0]));
        }
        width += string_width(hovermarker);
        
        height_line = 24;
        height = height_line * (options_count+ !(description == -1)); // this line is explained at like 3:45
        
        width_full = width + (margin *2);
        height_full = height + (margin*2);
    }
}

//Following this tutorial: https://www.youtube.com/watch?v=0IUT_M1Mx_E