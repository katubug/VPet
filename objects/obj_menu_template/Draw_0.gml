draw_sprite_stretched(spr_ui_box,0, x-margin, y-margin, width_full, height_full);


for (var line = 0; line < options_count; line++)
{
    var _object = options[line][0];
        if (hover == line){
            variable_instance_set(options[line][0], "image_alpha", 1)
        } else{ 
            variable_instance_set(options[line][0], "image_alpha", 0.5)
    }
}
