/// @description Handle Input

// Don't process if already submitted
if (submitted) exit;

// Cursor blink animation
cursor_timer++;
if (cursor_timer >= cursor_blink_speed) {
    cursor_visible = !cursor_visible;
    cursor_timer = 0;
}

// === DESKTOP KEYBOARD INPUT ===
if (os_type != os_android && os_type != os_ios) {
    
    // Get keyboard input
    var key_string = keyboard_string;
    
    // Only allow letters, numbers, spaces, and limit length
    var filtered_string = "";
    for (var i = 1; i <= string_length(key_string); i++) {
        var char = string_char_at(key_string, i);
        // Allow letters, numbers, spaces, hyphens, apostrophes
        if (string_lettersdigits(char) != "" || char == " " || char == "-" || char == "'") {
            filtered_string += char;
        }
    }
    
    // Update player name with filtered input
    player_name = string_copy(filtered_string, 1, max_name_length);
    keyboard_string = player_name; // Keep keyboard_string in sync
    
    // Backspace handling (in case of rapid deletion)
    if (keyboard_check_pressed(vk_backspace)) {
        if (string_length(player_name) > 0) {
            player_name = string_delete(player_name, string_length(player_name), 1);
            keyboard_string = player_name;
        }
    }
    
    // Submit with Enter key
    if (keyboard_check_pressed(vk_enter)) {
        if (string_length(string_trim(player_name)) > 0) {
            submit_name();
        }
    }
}

// === MOBILE KEYBOARD INPUT ===
else {
    
    // Get input from virtual keyboard
    if (keyboard_virtual_status() == kbv_type_default) {
        var key_string = keyboard_string;
        
        // Filter and limit input
        var filtered_string = "";
        for (var i = 1; i <= string_length(key_string); i++) {
            var char = string_char_at(key_string, i);
            if (string_lettersdigits(char) != "" || char == " " || char == "-" || char == "'") {
                filtered_string += char;
            }
        }
        
        player_name = string_copy(filtered_string, 1, max_name_length);
        keyboard_string = player_name;
    }
    
    // Check if virtual keyboard was hidden (user pressed Done)
    if (keyboard_showing && keyboard_virtual_status() == kbv_type_none) {
        if (string_length(string_trim(player_name)) > 0) {
            submit_name();
        }
        keyboard_showing = false;
    }
    
    // Also allow screen tap to submit (optional)
    if (mouse_check_button_pressed(mb_left)) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        // Check if clicked the "Done" area or outside the input box
        if (!point_in_rectangle(mx, my, box_x, box_y, box_x + box_width, box_y + box_height)) {
            if (string_length(string_trim(player_name)) > 0) {
                keyboard_virtual_hide();
                submit_name();
            }
        }
    }
}

// Function to submit the name
function submit_name() {
    if (!submitted) {
        submitted = true;
        
        // Trim whitespace
        player_name = string_trim(player_name);
        
        // Save to global variable
        global.game.ownername = player_name;
        
        show_debug_message($"Player name set to: {player_name}");
        
        // Hide keyboard if on mobile
        if (os_type == os_android || os_type == os_ios) {
            keyboard_virtual_hide();
        }
        
        // Destroy this object
        instance_destroy();
    }
}
