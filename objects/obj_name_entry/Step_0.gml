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

    // Always read from keyboard_string on mobile -- don't gate on keyboard_virtual_status()
    // because it's unreliable (returns -1 briefly after keyboard_virtual_show, causing false negatives)
    {
        var key_string = keyboard_string;

        // Filter to allowed characters only
        var filtered_string = "";
        for (var i = 1; i <= string_length(key_string); i++) {
            var char = string_char_at(key_string, i);
            if (string_lettersdigits(char) != "" || char == " " || char == "-" || char == "'") {
                filtered_string += char;
            }
        }

        player_name = string_copy(filtered_string, 1, max_name_length);
        // Only write back if we actually changed the string (avoids constant [VK] SetInputString spam)
        if (key_string != player_name) {
            keyboard_string = player_name;
        }
    }

    // Handle screen taps
    if (mouse_check_button_pressed(mb_left)) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);

        if (point_in_rectangle(mx, my, done_btn_x, done_btn_y, done_btn_x + done_btn_width, done_btn_y + done_btn_height)) {
            // Tapped the Done button -- submit if a name has been entered
            if (string_length(string_trim(player_name)) > 0) {
                keyboard_virtual_hide();
                submit_name();
            }
        } else if (point_in_rectangle(mx, my, box_x, box_y, box_x + box_width, box_y + box_height)) {
            // Tapped inside the input box -- always call show so it reopens after system dismiss too
            // (safe to call even if already open)
            keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_words, false);
            keyboard_showing = true;
        }
        // Taps outside both regions are ignored (no accidental submit)
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
