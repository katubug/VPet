draw_sprite_stretched(spr_ui_box,0, x-margin, y-margin, width_full, height_full);

draw_set_color(c_white);
draw_set_font(fnt_Quicksand);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = !(description == -1);
for (line = 0; line < (options_count + _desc); line++)
{
    draw_set_color(c_white);
    if (line ==0 && _desc){
        draw_text(x, y, description);
    } else {
    	var _str = options[line-_desc][0]
        if (hover == line - _desc){
            draw_set_color(c_yellow);
            _str = hovermarker+ _str;
        }
        draw_text(x, y + line * height_line, _str);
    }
}