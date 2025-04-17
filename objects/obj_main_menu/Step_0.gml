cursor += input_check_pressed("right") - input_check_pressed("left")

  if (cursor > menu_columns-1) cursor = 0;
  if (cursor < 0) cursor = menu_columns-1;