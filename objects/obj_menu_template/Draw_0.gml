draw_sprite_stretched(spr_ui_box,0, x-margin, y-margin, width_full, height_full);


for (var line = 0; line < (options_count); line++)
{
        var _spr = options[line][0];
        if (hover == line){
            draw_set_alpha(1);
        } else{
            draw_set_alpha(0.5)
        }
        draw_sprite(_spr, 0, x+ line * width, y);
}