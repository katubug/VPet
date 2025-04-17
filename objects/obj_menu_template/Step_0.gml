

if hover != undefined
{
  hover += input_check_pressed("right") - input_check_pressed("left")

  if (hover > options_count-1) hover = 0;
  if (hover < 0) hover = options_count-1;

  if (input_check_pressed("accept")){
    if (array_length(options[hover]) == 2){

        var _function = options[hover][1];
        if (_function != -1) _function();
    }
  }
}

