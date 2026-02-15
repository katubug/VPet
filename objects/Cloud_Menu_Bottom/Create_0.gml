/// @description Initialize Icon Menu

// Menu Configuration
menu_y = display_get_gui_height() - 70; // Distance from top of screen
icon_size = 100; // Size of each icon
icon_spacing = 110; // Spacing between icon centers
icon_padding = 20; // Left padding for first icon
menu_alpha_selected = 1.0; // Alpha for selected icon
menu_alpha_unselected = 0.6; // Alpha for unselected icons
menu_alpha_hover = 0.8; // Alpha for mouse hover

// Menu State
selected_index = 0; // Currently selected menu item (keyboard)
hover_index = -1; // Currently hovered menu item (mouse)
last_input_was_keyboard = false; // Track whether last input was keyboard or mouse

// Define Menu Items
// Each item: [sprite_normal, sprite_highlighted, callback_function, enabled]
// For now using placeholder sprite names
menu_items = [
    {
        sprite_normal: spr_btn_garden,      // Replace with your sprite
        sprite_highlight: spr_btn_garden, // Replace with your sprite
        callback: function() {
            room_goto(rm_garden)
        },
        enabled: true,
        tooltip: "Garden"
    },
    {
        sprite_normal: spr_btn_inventory,      // Replace with your sprite
        sprite_highlight: spr_btn_inventory, // Replace with your sprite
        callback: function() {
            room_goto(rm_inventory)
        },
        enabled: true,
        tooltip: "Inventory"
    },
    {
        sprite_normal: spr_btn_game,
        sprite_highlight: spr_btn_game,
        callback: function() {
            room_goto(rm_bathroom)
        },
        enabled: true,
        tooltip: "Games"
    },
    {
        sprite_normal: spr_btn_garden,
        sprite_highlight: spr_btn_garden,
        callback: function() {
            room_goto(rm_garden)
        },
        enabled: true,
        tooltip: "Garden"
    },
    {
        sprite_normal: spr_btn_inventory,
        sprite_highlight: spr_btn_inventory,
        callback: function() {
            show_debug_message("Stats menu clicked");
            // Add your stats display logic here
        },
        enabled: true,
        tooltip: "Inventory"
    },
    {
        sprite_normal: spr_btn_shop,
        sprite_highlight: spr_btn_shop,
        callback: function() {
            show_debug_message("Shop menu clicked");
            // Add your shop logic here
        },
        enabled: true,
        tooltip: "Shop"
    }
];

menu_count = array_length(menu_items);

// Calculate total menu width for centering
total_menu_width = (menu_count - 1) * icon_spacing + icon_size;
menu_start_x = (display_get_gui_width() / 2) - (total_menu_width / 2 - 50);

// Input cooldown (prevents double-triggering)
input_cooldown = 0;
cooldown_duration = 10; // frames
