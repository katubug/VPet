/// @description Handle Input and State

// Decrease cooldown
if (input_cooldown > 0) {
    input_cooldown--;
}

// Get mouse position in GUI coordinates
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Reset hover state
var previous_hover = hover_index;
hover_index = -1;

// Check mouse hover over icons
for (var i = 0; i < menu_count; i++) {
    if (!menu_items[i].enabled) continue;
    
    var icon_x = menu_start_x + (i * icon_spacing);
    var icon_y = menu_y;
    
    // Check if mouse is over this icon
    if (point_in_circle(mx, my, icon_x, icon_y, icon_size/2)) {
        hover_index = i;
        
        // If hover changed, this is mouse input
        if (hover_index != previous_hover) {
            last_input_was_keyboard = false;
        }
        break;
    }
}

// Handle keyboard navigation
var key_left = input_check_pressed("left");
var key_right = input_check_pressed("right");

if (key_left || key_right) {
    last_input_was_keyboard = true;
    
    var menu_move_dir = key_right - key_left;
    selected_index += menu_move_dir;
    
    if (selected_index >= menu_count) {
        selected_index = 0;
    } else if (selected_index < 0) {
        selected_index = menu_count - 1;
    }
    
    // Skip disabled items
    var safety_counter = 0;
    while (!menu_items[selected_index].enabled && safety_counter < menu_count) {
        selected_index += menu_move_dir;
        if (selected_index >= menu_count) selected_index = 0;
        if (selected_index < 0) selected_index = menu_count - 1;
        safety_counter++;
    }
}

// Handle activation
var activated = false;
var activated_index = -1;

if (input_check_pressed("accept") || input_check_pressed("action")) {
    if (last_input_was_keyboard && input_cooldown <= 0) {
        activated = true;
        activated_index = selected_index;
    }
}

if (mouse_check_button_pressed(mb_left)) {
    if (hover_index != -1 && input_cooldown <= 0) {
        activated = true;
        activated_index = hover_index;
        last_input_was_keyboard = false;
        selected_index = hover_index;
    }
}

if (activated && activated_index != -1) {
    if (menu_items[activated_index].enabled) {
        menu_items[activated_index].callback();
        input_cooldown = cooldown_duration;
    }
}
