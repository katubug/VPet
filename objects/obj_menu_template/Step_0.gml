
mouse_over = false;

if (point_in_rectangle(mouse_x, mouse_y, x, y, x+width_full, y+height_full)){
    mouse_over = true;
    hover = mouse_in_rectangle(hover, array_length(options), mouse_x, mouse_y, options);
}

/*
if (point_in_rectangle(mouse_x, mouse_y, x, y, x+width_full, y+height_full)){
if (mx_previous != mouse_x || my_previous != mouse_y){
        
    var _mouse_hover_line = (mouse_x-x) div width;
    if !(description == -1) _mouse_hover_line-=1;
        if (_mouse_hover_line < 0) _mouse_hover_line = 0;
        if (_mouse_hover_line > options_count-1) _mouse_hover_line = options_count-1;
        hover = _mouse_hover_line;
    }
}
*/

//hover += input_check_pressed("right") - input_check_pressed("left")

if hover != undefined
{
  //hover += input_check_pressed("right") - input_check_pressed("left")

  if (hover > options_count-1) hover = 0;
  if (hover < 0) hover = options_count-1;
    
  if ((input_check_pressed("action") && mouse_over) || input_check_pressed("accept")){
    if (array_length(options[hover]) == 2){
        var _function = options[hover][1];
        if (_function != -1) _function();
    }
  }
}

mx_previous = mouse_x;
my_previous = mouse_y;