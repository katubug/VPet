/// @description Initialize Name Entry System

// Check if save file exists
if (file_exists("save_data.txt")) {
    // Save file exists, skip name entry
    instance_destroy();
    exit;
}

// Input state
player_name = "";
max_name_length = 20;
cursor_visible = true;
cursor_timer = 0;
cursor_blink_speed = 30; // Frames between blinks

// UI Settings
box_width = 600;
box_height = 200;
box_x = (display_get_gui_width() / 2) - (box_width / 2);
box_y = (display_get_gui_height() / 2) - (box_height / 2);
box_color = c_dkgray;
box_alpha = 0.9;
border_color = c_white;
border_width = 4;

// Text settings
text_color = c_white;
prompt_text = "Enter your name:";
instruction_text = "(Press Enter when done)";
if (os_type == os_android || os_type == os_ios) {
    instruction_text = "(Tap Done when finished)";
}

// Mobile keyboard state
keyboard_showing = false;

// Start mobile keyboard if on mobile device
if (os_type == os_android || os_type == os_ios) {
    keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_words, false);
    keyboard_showing = true;
}

// Flag to prevent accidental double-submission
submitted = false;
