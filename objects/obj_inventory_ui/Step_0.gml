/// @description Handle Input and Updates

// Get mouse position
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Update hover state
var previous_hover = hover_slot;
hover_slot = get_slot_at_position(mx, my);

// Animate hover effect
if (hover_slot != previous_hover) {
    if (previous_hover != -1 && previous_hover < array_length(target_scale)) {
        target_scale[previous_hover] = 1.0;
    }
    if (hover_slot != -1 && hover_slot < array_length(target_scale)) {
        target_scale[hover_slot] = 1.1;
    }
}

// Update scale animations
for (var i = 0; i < array_length(slot_scale); i++) {
    slot_scale[i] = lerp(slot_scale[i], target_scale[i], scale_speed);
}

// Handle mouse wheel scrolling
if (max_scroll > 0) {
    var mouse_wheel = mouse_wheel_up() - mouse_wheel_down();
    if (mouse_wheel != 0) {
        scroll_offset = clamp(scroll_offset - mouse_wheel, 0, max_scroll);
    }
}

// Handle tab clicks
if (show_tabs && mouse_check_button_pressed(mb_left)) {
    var tab_y = ui_y + 40;
    for (var i = 0; i < array_length(tabs); i++) {
        var tab_x = ui_x + (i * tab_width);
        
        if (point_in_rectangle(mx, my, tab_x, tab_y, tab_x + tab_width, tab_y + tab_height)) {
            current_tab = i;
            switch_category(tabs[i].category);
        }
    }
}

// Handle close button
if (show_close_button && mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, close_button_x, close_button_y, 
        close_button_x + close_button_size, close_button_y + close_button_size)) {
        instance_destroy();
        exit;
    }
}

// Handle item clicks
if (mouse_check_button_pressed(mb_left)) {
    if (hover_slot != -1) {
        var items = inventory_get_all_items(ui_category);
        
        if (hover_slot < array_length(items)) {
            var item = items[hover_slot];
            var item_data = inventory_get_item_data(item.id);
            
            if (item_data != undefined) {
                // Set as selected
                selected_slot = hover_slot;
                
                // Call callback
                on_item_click(item.id, item.quantity, hover_slot);
            }
        }
    }
}

// Handle item usage (double-click or use button)
if (mouse_check_button_pressed(mb_left)) {
    if (hover_slot == selected_slot && hover_slot != -1) {
        var items = inventory_get_all_items(ui_category);
        
        if (hover_slot < array_length(items)) {
            var item = items[hover_slot];
            on_item_use(item.id);
        }
    }
}

// Keyboard controls
if (input_check_pressed("cancel") || keyboard_check_pressed(vk_escape)) {
    instance_destroy();
}

// Arrow key navigation
if (selected_slot != -1) {
    var move_x = input_check_pressed("right") - input_check_pressed("left");
    var move_y = input_check_pressed("down") - input_check_pressed("up");
    
    if (move_x != 0 || move_y != 0) {
        var current_col = selected_slot mod grid_columns;
        var current_row = floor(selected_slot / grid_columns);
        
        current_col = clamp(current_col + move_x, 0, grid_columns - 1);
        current_row = clamp(current_row + move_y, 0, 999); // Allow scrolling
        
        selected_slot = (current_row * grid_columns) + current_col;
        
        // Auto-scroll if needed
        if (current_row < scroll_offset) {
            scroll_offset = current_row;
        }
        if (current_row >= scroll_offset + grid_rows) {
            scroll_offset = current_row - grid_rows + 1;
        }
        
        // Clamp to item count
        var items = inventory_get_all_items(ui_category);
        selected_slot = min(selected_slot, array_length(items) - 1);
    }
}

// Use selected item with Enter/Space
if (selected_slot != -1 && (input_check_pressed("accept") || input_check_pressed("action"))) {
    var items = inventory_get_all_items(ui_category);
    
    if (selected_slot < array_length(items)) {
        var item = items[selected_slot];
        on_item_use(item.id);
    }
}

// Update scroll after item operations
update_max_scroll();

