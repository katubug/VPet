foods = [
    obj_food_basic,
    obj_food_taco
]

        foods_count = array_length(foods);
        
        //Set up size
        margin = 15;
            
        for (var index = 0; index < foods_count; index++)
        {
            object = foods[index];
            sprite = object_get_sprite(foods[index]);
            width = sprite_get_width(sprite);
            height = sprite_get_height(sprite);
            instance_create_depth(x + index * width, y, -999, object);
            
        }
        
        option_width = width * (foods_count); // this line is explained at like 3:45
        
        width_full = option_width + (margin *2);
        height_full = height + (margin*2);