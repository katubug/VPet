//use items from inventory
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_released(mb_left)){

var inventory_item = _inventory.item_get();
for (var row = 0; row < inventory_rows; row++){
    var pos_y = ui_padding_y + (ui_border_size * 13) + (row * (ui_inventory_margin + ui_inventory_box));
    for (var column = 0; column < inventory_columns; column++){
        var pos_x = ui_padding_x + ui_panel_left + ui_border_size + ui_inventory_padding + (column * (ui_inventory_margin + ui_inventory_box));
        
        
        //hover
        if (is_between(mx, pos_x, pos_x+ui_inventory_box)){
            if (is_between(my, pos_y, pos_y + ui_inventory_box)){
                var inventory_index = (row * inventory_columns) + column;
                
                if (inventory_index <= array_length(inventory_item) -1){
                    show_debug_message($"Using {inventory_item[inventory_index].name}");
                    
                    _inventory.item_subtract(inventory_item[inventory_index].name, 1);
                } else{
                    show_debug_message("No inventory item selected.");
                }
               
            }
        }
    }
}
}