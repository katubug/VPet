draw_sprite_stretched(spr_ui_box,0, x-margin, y-margin, width_full, height_full);

for (line = 0; line < options_count; line++)
{
        var _spr = options[line].sprite;
        if (hover == line){
            draw_set_alpha(1);
        } else{
            draw_set_alpha(0.5)
        }
        draw_sprite_stretched(_spr, 0, options[line].x1, options[line].y1, 50, 20);
    
}