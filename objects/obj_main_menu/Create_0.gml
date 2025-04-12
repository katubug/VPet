menu_columns = 5;
menu_rows = 2;
padding = 100;

buttons = [
    obj_btn_garden,
    obj_btn_gameroom,
    obj_btn_kitchen,
    obj_btn_inventory,
    obj_btn_shop
];
cursor = 0;

button_get = function(){
    return buttons;
}

button_instance = button_get();
for (row = 0; row < menu_rows; row++){
    var pos_y =  (row * padding);
    for (column = 0; column < menu_columns; column++){
        var pos_x = (column * padding);
        var button_index = (row * menu_columns) + column;
        if (button_index < array_length(button_instance)){
                instance_create_layer(pos_x, pos_y, "Instances", buttons[button_index]);
        }
    }
}
