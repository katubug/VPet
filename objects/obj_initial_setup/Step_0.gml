if (input_check_pressed("accept")){
    playername = keyboard_string;
    show_message(string(playername));
}
if string_length(keyboard_string)>name_max{
    //input_keyboard_virtual_show(kbv_type_default)
    //keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_words, false)
    keyboard_string = string_copy(keyboard_string, 1, name_max);
    }
