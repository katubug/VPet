var accept = input_check_pressed("accept") or input_check_pressed("action");

if (input_check_pressed("left")){
    image_index--
}

if (input_check_pressed("right")){
    image_index++
}

if (image_index == 0 && accept){
    show_debug_message("0");
}

if (image_index == 1 && accept){
    show_debug_message("1");
}

if (image_index == 2 && accept){
    show_debug_message("2");
}

if (image_index == 3 && accept){
    show_debug_message("3");
}

if (image_index == 4 && accept){
    show_debug_message("4");
}

if (image_index == 5 && accept){
    show_debug_message("5");
}

if (image_index == 6 && accept){
    show_debug_message("6");
}

if (image_index == 7 && accept){
    show_debug_message("7");
}
