/// @description Initialize Name Entry System

// Initialize variables first so Step doesn't crash if we destroy early
// (GameMaker runs one Step event even after instance_destroy in Create)
keyboard_showing = false; // Tracks whether the virtual keyboard is open
submitted = false; // Prevents double-submission of the name
player_name = ""; // The name the player is typing
cursor_timer = 0; // Counts frames for cursor blink timing
cursor_visible = true; // Whether the cursor is currently shown
cursor_blink_speed = 30; // Frames between blinks -- increase to blink slower

// Check if save file exists
if (file_exists("save_data.txt")) {
    // Save file exists, skip name entry
    instance_destroy();
    exit;
}

// Input state
max_name_length = 20; // Max characters allowed in the name

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

// Start mobile keyboard if on mobile device
if (os_type == os_android || os_type == os_ios) {
    keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_words, false);
    keyboard_showing = true; // Mark keyboard as open so Step can manage it
}

// submitted and keyboard_showing initialized above the file_exists check
