/// @description Initialize Shop UI

// UI Configuration
ui_title = "Shop";

// Grid Layout
grid_columns = 7;
grid_rows = 3;
slot_size = 80;
slot_padding = 10;
slot_border = 3;

// Position
ui_x = 50;
ui_y = 150;
ui_width = (grid_columns * (slot_size + slot_padding)) + slot_padding;
ui_height = (grid_rows * (slot_size + slot_padding)) + slot_padding + 150; // +150 for title/info

// Colors
color_background = c_dkgray;
color_border = c_white;
color_slot_empty = c_black;
color_slot_filled = make_color_rgb(40, 40, 40);
color_slot_hover = c_orange;
color_slot_selected = c_yellow;
color_text = c_white;
color_price_affordable = c_lime;
color_price_expensive = c_red;

// Background alpha
bg_alpha = 0.95;

// Selection State
selected_slot = -1;
hover_slot = -1;

// Scrolling
scroll_offset = 0;
max_scroll = 0;

// Define shop inventory (items available for purchase)
shop_items = [
    // Foods
    { item_id: "apple", stock: -1 },      // -1 = unlimited
    { item_id: "bread", stock: -1 },
    { item_id: "lemon", stock: -1 },
    
    // Toys
    { item_id: "ball", stock: 5 },        // Limited stock
    { item_id: "plushie", stock: 3 },
    
    // Seeds
    { item_id: "tomato_seed", stock: -1 },
    { item_id: "carrot_seed", stock: -1 },
    
    // Ingredients
    { item_id: "flour", stock: -1 },
    { item_id: "sugar", stock: -1 },
    { item_id: "egg", stock: -1 }
];

// Calculate max scroll
update_max_scroll();

// Close button
show_close_button = true;
close_button_x = ui_x + ui_width - 40;
close_button_y = ui_y + 10;
close_button_size = 30;

// Purchase confirmation
pending_purchase = undefined;
show_confirmation = false;

// Animations
slot_scale = array_create(grid_columns * grid_rows, 1.0);
target_scale = array_create(grid_columns * grid_rows, 1.0);
scale_speed = 0.15;

/// @function update_max_scroll()
function update_max_scroll() {
    var total_slots_needed = array_length(shop_items);
    var visible_slots = grid_columns * grid_rows;
    
    if (total_slots_needed > visible_slots) {
        max_scroll = ceil((total_slots_needed - visible_slots) / grid_columns);
    } else {
        max_scroll = 0;
    }
}

/// @function get_slot_at_position(mx, my)
function get_slot_at_position(_mx, _my) {
    var grid_start_x = ui_x + slot_padding;
    var grid_start_y = ui_y + 80 + slot_padding;
    
    for (var row = 0; row < grid_rows; row++) {
        for (var col = 0; col < grid_columns; col++) {
            var slot_x = grid_start_x + (col * (slot_size + slot_padding));
            var slot_y = grid_start_y + (row * (slot_size + slot_padding));
            
            if (point_in_rectangle(_mx, _my, slot_x, slot_y, slot_x + slot_size, slot_y + slot_size)) {
                var slot_index = ((row + scroll_offset) * grid_columns) + col;
                return slot_index;
            }
        }
    }
    
    return -1;
}

/// @function purchase_item(item_id)
function purchase_item(_item_id) {
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) {
        show_debug_message("ERROR: Item not found!");
        return false;
    }
    
    var price = item_data.buy_price;
    
    // Check if player has enough corns
    if (global.game.corns < price) {
        show_debug_message("Not enough corns! Need " + string(price) + ", have " + string(global.game.corns));
        return false;
    }
    
    // Check stock
    for (var i = 0; i < array_length(shop_items); i++) {
        if (shop_items[i].item_id == _item_id) {
            if (shop_items[i].stock == 0) {
                show_debug_message("Out of stock!");
                return false;
            }
            
            // Deduct corns
            global.game.corns -= price;
            
            // Add item to inventory
            if (inventory_add(_item_id, 1)) {
                // Decrease stock (if not unlimited)
                if (shop_items[i].stock > 0) {
                    shop_items[i].stock--;
                }
                
                show_debug_message("Purchased " + item_data.name + " for " + string(price) + " corns!");
                return true;
            } else {
                // Inventory full - refund
                global.game.corns += price;
                show_debug_message("Inventory full!");
                return false;
            }
        }
    }
    
    return false;
}
