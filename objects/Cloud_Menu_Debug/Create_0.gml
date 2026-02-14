/// @description Initialize Icon Menu (Debug Version - No Sprites Required)
/// This version uses colored circles instead of sprites for testing

// Menu Configuration
menu_y = 60; // Distance from top of screen
icon_size = 48; // Size of each icon
icon_spacing = 80; // Spacing between icon centers
icon_padding = 20; // Left padding for first icon
menu_alpha_selected = 1.0; // Alpha for selected icon
menu_alpha_unselected = 0.6; // Alpha for unselected icons
menu_alpha_hover = 0.8; // Alpha for mouse hover

// Menu State
selected_index = 0;
hover_index = -1;
last_input_was_keyboard = false;

// Define Menu Items (Debug Version - uses colors instead of sprites)
menu_items = [
    {
        color: c_red,
        color_highlight: c_orange,
        callback: function() {
            room_goto(rm_kitchen)
        },
        enabled: true,
        label: "Food"
    },
    {
        color: c_green,
        color_highlight: c_lime,
        callback: function() {
            show_debug_message("Play menu clicked");
        },
        enabled: true,
        label: "Play"
    },
    {
        color: c_blue,
        color_highlight: c_aqua,
        callback: function() {
            show_debug_message("Clean menu clicked");
        },
        enabled: true,
        label: "Clean"
    },
    {
        color: c_purple,
        color_highlight: c_fuchsia,
        callback: function() {
            show_debug_message("Stats menu clicked");
        },
        enabled: true,
        label: "Stats"
    },
    {
        color: c_yellow,
        color_highlight: c_white,
        callback: function() {
            show_debug_message("Shop menu clicked");
        },
        enabled: true,
        label: "Shop"
    }
];

menu_count = array_length(menu_items);

// Calculate total menu width for centering
total_menu_width = (menu_count - 1) * icon_spacing + icon_size;
menu_start_x = (display_get_gui_width() / 2) - (total_menu_width / 2);

// Input cooldown
input_cooldown = 0;
cooldown_duration = 10;
