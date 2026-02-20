/// /// @description Initialize Inventory UI Display

// UI Configuration
ui_category = "food"; // Which category to display: "food", "toy", "seed", "ingredient"
ui_title = "Food Inventory";

// Grid Layout
grid_columns = 7;
grid_rows = 4;
slot_size = 80; // Size of each inventory slot
slot_padding = 10; // Space between slots
slot_border = 3;

// Position
ui_x = 50;
ui_y = 150;
ui_width = (grid_columns * (slot_size + slot_padding)) + slot_padding;
ui_height = (grid_rows * (slot_size + slot_padding)) + slot_padding + 100; // +100 for title/info

// Colors
color_background = c_dkgray;
color_border = c_white;
color_slot_empty = c_black;
color_slot_filled = make_color_rgb(40, 40, 40);
color_slot_hover = c_orange;
color_slot_selected = c_yellow;
color_text = c_white;
color_text_shadow = c_black;

// Background alpha
bg_alpha = 0.95;

// Selection State
selected_slot = -1; // Which slot is selected (-1 = none)
hover_slot = -1; // Which slot mouse is over

// Item Display
show_tooltips = true;
show_quantity = true;
show_item_name_on_hover = true;

// Scrolling (for when items exceed grid size)
scroll_offset = 0;
max_scroll = 0;

// Item interaction callback
on_item_click = function(_item_id, _quantity, _slot_index) {
    // Override this function to handle item clicks
    show_debug_message("Clicked: " + _item_id + " (x" + string(_quantity) + ")");
};

on_item_use = function(_item_id) {
    // Default behavior: handle items based on their category
    var item_data = inventory_get_item_data(_item_id);
    
    if (item_data == undefined) return;
    
    // Handle different item types
    switch (item_data.category) {
        case "food":
    if (inventory_feed_pet(_item_id)) {
        // Store sprite info globally (survives room change)
        global.feeding_sprite = item_data.sprite;
        global.feeding_return_room = room;
        
        // Go to kitchen
        room_goto(rm_kitchen);
                
                // Create the food animation object
                var food_anim = instance_create_layer(0, 0, "Instances", obj_food_animation);
                food_anim.food_sprite = item_data.sprite;
                food_anim.return_room = room; // Return to current room (inventory)
            } else {
                show_debug_message("Can't use that right now");
            }
            break;
            
        case "toy":
            // Play with toy
            var items = inventory_get_all_items("toy");
            var toy_instance = undefined;
            
            for (var i = 0; i < array_length(items); i++) {
                if (items[i].id == _item_id) {
                    toy_instance = items[i];
                    break;
                }
            }
            
            if (toy_instance != undefined && toy_instance.durability > 0) {
                // Restore happiness
                global.game.happiness = min(global.game.happiness + item_data.happiness_restore, 20);
                
                // Decrease durability
                toy_instance.durability--;
                
                show_debug_message("Played with " + item_data.name + "! (Durability: " + string(toy_instance.durability) + ")");
                
                // Remove if broken
                if (toy_instance.durability <= 0) {
                    inventory_remove(_item_id, 1);
                    show_debug_message(item_data.name + " broke!");
                }
            }
            break;
            
        case "seed":
            // Can't use seeds directly - need to plant them
            show_debug_message("Go to the garden to plant " + item_data.name);
            break;
            
        case "ingredient":
            // Can't use ingredients directly - need to cook with them
            show_debug_message("Go to the kitchen to cook with " + item_data.name);
            break;
    }
};

// Close button
show_close_button = false;
close_button_x = ui_x + ui_width - 40;
close_button_y = ui_y + 10;
close_button_size = 30;

// Tab system for switching categories
show_tabs = true;
current_tab = 0;
tabs = [
    { name: "Food", category: "food" },
    { name: "Toys", category: "toy" },
    { name: "Seeds", category: "seed" },
    { name: "Ingredients", category: "ingredient" }
];
tab_width = 120;
tab_height = 40;

// Filter/Sort options
sort_mode = "none"; // "none", "name", "quantity", "rarity"
filter_text = "";

// Animations
slot_scale = array_create(grid_columns * grid_rows, 1.0);
target_scale = array_create(grid_columns * grid_rows, 1.0);
scale_speed = 0.15;

// Initialize
update_max_scroll();

/// @function update_max_scroll()
/// @description Calculate maximum scroll based on item count
function update_max_scroll() {
    var items = inventory_get_all_items(ui_category);
    var total_slots_needed = array_length(items);
    var visible_slots = grid_columns * grid_rows;
    
    if (total_slots_needed > visible_slots) {
        max_scroll = ceil((total_slots_needed - visible_slots) / grid_columns);
    } else {
        max_scroll = 0;
    }
}

/// @function get_slot_at_position(mx, my)
/// @description Get which inventory slot is at mouse position
/// @param {Real} mx - Mouse X position
/// @param {Real} my - Mouse Y position
/// @return {Real} Slot index or -1 if none
function get_slot_at_position(_mx, _my) {
    // Check if mouse is in grid area
    var grid_start_x = ui_x + slot_padding;
    var grid_start_y = ui_y + 80 + slot_padding; // +80 for title area
    
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

/// @function switch_category(new_category)
/// @description Switch to a different inventory category
/// @param {String} new_category - Category to switch to
function switch_category(_new_category) {
    ui_category = _new_category;
    scroll_offset = 0;
    selected_slot = -1;
    hover_slot = -1;
    update_max_scroll();
    
    // Update title
    switch (_new_category) {
        case "food": ui_title = "Food Inventory"; break;
        case "toy": ui_title = "Toy Box"; break;
        case "seed": ui_title = "Seed Pouch"; break;
        case "ingredient": ui_title = "Ingredient Storage"; break;
    }
}

