/// @description Initialize Icon Menu

// -- Positioning --
menu_y_top    = 70;                             // Y position of the top row icons
menu_y_bottom = display_get_gui_height() - 120; // Y position of the bottom row icons

// -- Icon Sizing --
icon_size    = 100; // Pixel size of each icon (width and height)
icon_spacing = 110; // Distance between icon centers (icon_size + 10px gap)

// -- Alpha Values --
menu_alpha_selected   = 1.0; // Full opacity when an icon is selected/hovered
menu_alpha_unselected = 0.6; // Dimmed opacity for non-active icons
menu_alpha_hover      = 0.8; // Intermediate opacity when mouse hovers (non-primary input)

// -- Input State --
active_row           = 0;     // Which row has keyboard focus: 0 = top, 1 = bottom
last_input_was_keyboard = false; // Tracks whether keyboard or mouse was used last

selected_index_top    = 0;  // Keyboard-selected icon index in the top row
selected_index_bottom = 0;  // Keyboard-selected icon index in the bottom row

hover_index_top    = -1; // Mouse-hovered icon in top row (-1 = none)
hover_index_bottom = -1; // Mouse-hovered icon in bottom row (-1 = none)

// -- Input Cooldown --
input_cooldown    = 0;  // Frames remaining before another input registers
cooldown_duration = 10; // How many frames the cooldown lasts

// -- Top Row: Navigation --
// 5 items: Home, Stats, Inventory, Kitchen, Bathroom
// Add more items here by appending to this array
top_items = [
    {
        sprite_normal:    spr_btn_home,      // Normal icon sprite
        sprite_highlight: spr_btn_home,      // Highlighted icon sprite (same for now)
        callback: function() {
            room_goto(rm_main); // Navigate to the main/home room
        },
        enabled: true,
        tooltip: "Home"
    },
    {
        sprite_normal:    spr_btn_inventory, // Using inventory sprite as placeholder for Stats
        sprite_highlight: spr_btn_inventory,
        callback: function() {
            room_goto(rm_stats); // Navigate to the stats room
        },
        enabled: true,
        tooltip: "Stats"
    },
    {
        sprite_normal:    spr_btn_inventory,
        sprite_highlight: spr_btn_inventory,
        callback: function() {
            room_goto(rm_inventory); // Navigate to the inventory room
        },
        enabled: true,
        tooltip: "Inventory"
    },
    {
        sprite_normal:    spr_btn_kitchen,
        sprite_highlight: spr_btn_kitchen,
        callback: function() {
            room_goto(rm_kitchen); // Navigate to the kitchen room
        },
        enabled: true,
        tooltip: "Kitchen"
    },
    {
        sprite_normal:    spr_btn_bathroom,
        sprite_highlight: spr_btn_bathroom,
        callback: function() {
            room_goto(rm_bathroom); // Navigate to the bathroom room
        },
        enabled: true,
        tooltip: "Bathroom"
    }
];

// -- Bottom Row: Activities --
// 5 items: Games, Shop, Garden, Explore (placeholder), Placeholder
// Replace placeholder sprites and callbacks when real content is ready
bottom_items = [
    {
        sprite_normal:    spr_btn_game,
        sprite_highlight: spr_btn_game,
        callback: function() {
            room_goto(rm_games); // Navigate to the games room
        },
        enabled: true,
        tooltip: "Games"
    },
    {
        sprite_normal:    spr_btn_shop,
        sprite_highlight: spr_btn_shop,
        callback: function() {
            room_goto(rm_shop); // Navigate to the shop room
        },
        enabled: true,
        tooltip: "Shop"
    },
    {
        sprite_normal:    spr_btn_garden,
        sprite_highlight: spr_btn_garden,
        callback: function() {
            room_goto(rm_garden); // Navigate to the garden room
        },
        enabled: true,
        tooltip: "Garden"
    },
    {
        sprite_normal:    spr_btn_game,      // TODO: replace with spr_btn_explore when created
        sprite_highlight: spr_btn_game,
        callback: function() {
            show_debug_message("Explore: not yet implemented"); // Placeholder — wire up when Explore room exists
        },
        enabled: true,
        tooltip: "Explore"
    },
    {
        sprite_normal:    spr_btn_game,      // TODO: replace with real sprite when decided
        sprite_highlight: spr_btn_game,
        callback: function() {
            show_debug_message("Placeholder: not yet implemented"); // Placeholder — wire up when content is decided
        },
        enabled: true,
        tooltip: "???"
    }
];

// -- Derived Counts --
menu_count_top    = array_length(top_items);    // Number of items in the top row
menu_count_bottom = array_length(bottom_items); // Number of items in the bottom row

// -- Centering --
// Both rows use the same start X since they have the same item count.
// Adjust this formula if row counts differ in future.
var total_menu_width = (menu_count_top - 1) * icon_spacing + icon_size; // Total pixel span of icons
menu_start_x = (display_get_gui_width() / 2) - (total_menu_width / 2 - 50); // Left edge of first icon
