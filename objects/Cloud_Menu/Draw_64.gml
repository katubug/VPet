/// @description Draw Icon Menu (Top and Bottom Rows)

// During the egg phase the player is locked to the main room — hide the menu entirely
if (global.game.evolution_phase == "egg") exit;

// Helper: draws a single row of menu items
// row_items  - the array of item structs to draw
// row_y      - the Y center position for this row's icons
// sel_index  - the keyboard-selected index within this row
// hov_index  - the mouse-hovered index within this row (-1 if none)
// is_active_row - true if this row currently has keyboard focus
var _draw_row = function(row_items, row_y, sel_index, hov_index, is_active_row) {

    var count = array_length(row_items); // Number of items in this row

    for (var i = 0; i < count; i++) {
        var item = row_items[i];

        if (!item.enabled) continue; // Skip disabled icons entirely

        var icon_x = menu_start_x + (i * icon_spacing); // X center of this icon
        var icon_y = row_y;                               // Y center comes from the row

        // Decide sprite and alpha based on input state
        var use_sprite = item.sprite_normal;
        var use_alpha  = menu_alpha_unselected; // Default: dimmed

        // Keyboard highlight: only applies when keyboard is active AND this row has focus
        var is_keyboard_selected = (last_input_was_keyboard && is_active_row && i == sel_index);

        // Mouse highlight: applies to whichever icon the mouse is over in this row
        var is_mouse_hovered = (!last_input_was_keyboard && i == hov_index);

        if (is_keyboard_selected || is_mouse_hovered) {
            use_sprite = item.sprite_highlight; // Switch to highlight variant
            use_alpha  = menu_alpha_selected;   // Full opacity
        } else if (i == hov_index) {
            // Mouse is over this icon but mouse isn't the primary input — show soft hover
            use_alpha = menu_alpha_hover;
        }

        // Draw the icon sprite centered at (icon_x, icon_y)
        draw_sprite_ext(use_sprite, 0, icon_x, icon_y, 1, 1, 0, c_white, use_alpha);

        // Keyboard selection ring: yellow circle outline around the active icon
        if (is_keyboard_selected) {
            draw_set_color(c_yellow);
            draw_set_alpha(0.3);
            draw_circle(icon_x, icon_y, icon_size / 2 + 4, true); // Inner ring
            draw_circle(icon_x, icon_y, icon_size / 2 + 5, true); // Outer ring (slightly thicker feel)
            draw_set_alpha(1);
        }
    }
};

// -- Draw Top Row --
// active_row == 0 means keyboard focus is on the top row
_draw_row(top_items, menu_y_top, selected_index_top, hover_index_top, active_row == 0);

// -- Draw Bottom Row --
// active_row == 1 means keyboard focus is on the bottom row
_draw_row(bottom_items, menu_y_bottom, selected_index_bottom, hover_index_bottom, active_row == 1);

// -- Reset Draw State --
// Always restore defaults after custom draw calls to avoid bleeding into other objects
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
