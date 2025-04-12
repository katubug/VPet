if (input_check_released("left")){
    if (cursor < array_length(button_instance) -1){
        cursor++
        show_debug_message("im working yay")
    }
}

if (input_check_released("right")){
    if (cursor < array_length(button_instance) -1){
        cursor--
        show_debug_message("im working yay")
    }
}