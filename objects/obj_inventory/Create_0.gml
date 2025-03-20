inventory = new Inventory();

inventory_columns = 5;
inventory_rows = 9;

ui_padding_x = 64;
ui_padding_y = 64;
ui_panel_left = 90;
ui_border_size = 8;
ui_inventory_padding = 48;
ui_inventory_box = 64;
ui_inventory_margin = 16;
color_border = c_teal;
color_background = c_dkgray;

inventory.item_add("Wood", 3, spr_btn_begin);
inventory.item_add("Wood", 7, spr_btn_begin);
inventory.item_add("Strone", 3, spr_btn_begin);

show_debug_message(inventory)