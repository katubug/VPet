if (playername == ""){
draw_text(100, 64, "Please enter your name.");
draw_roundrect(100, 100, 250, 125, true)
draw_text_color(105, 100, keyboard_string, c_aqua, c_aqua, c_aqua, c_aqua, 1);
draw_set_color(c_aqua);
if alarm[0]{
    draw_line_width(105+string_width(keyboard_string), 102, 105+string_width(keyboard_string), 102+20, 3);
}
}
else draw_text(250, 250, playername)

