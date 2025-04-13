if (input_check_released("left")){
    if (cursor < array_length(button_instance) -1){
        cursor-=1
        //if (cursor < 0) cursor = button_instance-1;
    }
}

if (input_check_released("right")){
    if (cursor < array_length(button_instance) -1){
        cursor+=1
        //if (cursor > button_instance-1) cursor = 0;
    }
}