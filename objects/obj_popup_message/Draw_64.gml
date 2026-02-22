/// @description Draw popup message

// Measure text size
draw_set_font(fnt_Quicksand);
var text_width = string_width(message);
var text_height = string_height(message);

// Box padding
var padding = 20;
var box_width = text_width + (padding * 2);
var box_height = text_height + (padding * 2);

// Draw background box
draw_set_alpha(bg_alpha);
draw_set_color(bg_color);
draw_rectangle(
    x - box_width/2,
    y - box_height/2,
    x + box_width/2,
    y + box_height/2,
    false
);

// Draw border
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(
    x - box_width/2,
    y - box_height/2,
    x + box_width/2,
    y + box_height/2,
    true
);

// Draw text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);
draw_text(x, y, message);

// Reset draw settings
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
