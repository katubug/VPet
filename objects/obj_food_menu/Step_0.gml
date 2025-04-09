//use items from inventory
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_released(mb_left)){

var inventory_item = _inventory.item_get();
for (var row = 0; row < inventory_rows; row++){
    var pos_y = ui_padding_y + ui_padding_top + (ui_border_size * 5) + (row * (ui_inventory_margin + ui_inventory_box));
    for (var column = 0; column < inventory_columns; column++){
        var pos_x = ui_padding_x + ui_border_size + ui_inventory_padding + (column * (ui_inventory_margin + ui_inventory_box));
        
        
        //hover
        if (is_between(mx, pos_x, pos_x+ui_inventory_box)){
            if (is_between(my, pos_y, pos_y + ui_inventory_box)){
                var inventory_index = (row * inventory_columns) + column;
                
                if (inventory_index <= array_length(inventory_item) -1){
                    show_debug_message($"hunger of selected item is {inventory_item[inventory_index].hunger}")
                    if (global.game.hunger >=20) return;
                    if (global.game.hunger < 20){
                        if (global.game.hunger + inventory_item[inventory_index].hunger >= 20){
                            global.game.hunger = 20;
                            _inventory.item_subtract(inventory_item[inventory_index].name, 1);
                        } else {
                        global.game.hunger += inventory_item[inventory_index].hunger;
                        show_debug_message($"Restoring {inventory_item[inventory_index].hunger} hunger")
                        _inventory.item_subtract(inventory_item[inventory_index].name, 1);
                    }}
                    show_debug_message($"hunger is now {global.game.hunger}")
                    
                    
                } else{
                    show_debug_message("No inventory item selected.");
                }
               
            }
        }
    }
}
}