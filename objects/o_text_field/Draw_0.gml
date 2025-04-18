draw_self();

draw_set_font(font0);

if(string_width(myTXT)>max_text_width)
{ 
  str = "...";
  min_width = max_text_width - string_width(str);
  
  for(i=string_length(myTXT); i>=0; i--)
  {
    text_to_draw = string_copy(myTXT, 1, i);
    if(string_width(text_to_draw)<=min_width) break;
  }
  
  text_to_draw += str;
}
else text_to_draw = myTXT;

draw_set_color(c_black);

draw_set_halign(alignment)
switch(alignment)
{
  case fa_left: off = 20; break;
  case fa_center: off = sprite_width/2; break;
  case fa_right: off = sprite_width - 20; break;  
}
draw_text(x+off, y + (sprite_height - string_height(text_to_draw))/2, text_to_draw);



