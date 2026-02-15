/// @description Draw Icon Menu

// Draw each menu item
for (var i = 0; i < menu_count; i++) {
    var item = menu_items[i];
    
    if (!item.enabled) continue;
    
    var icon_x = menu_start_x + (i * icon_spacing);
    var icon_y = menu_y;
    
    // Determine which sprite and alpha to use
    var use_sprite = item.sprite_normal;
    var use_alpha = menu_alpha_unselected;
    
    // Check if this icon should be highlighted
    var is_selected_keyboard = (last_input_was_keyboard && i == selected_index);
    var is_hovered_mouse = (!last_input_was_keyboard && i == hover_index);
    
    if (is_selected_keyboard || is_hovered_mouse) {
        use_sprite = item.sprite_highlight;
        use_alpha = menu_alpha_selected;
    } else if (i == hover_index) {
        // Mouse is over but not the primary input method
        use_alpha = menu_alpha_hover;
    }
    
    // Draw the icon
    draw_sprite_ext(
        use_sprite, 
        0, 
        icon_x, 
        icon_y, 
        1, 
        1, 
        0, 
        c_white, 
        use_alpha
    );
    
    // Draw selection indicator for keyboard mode
    if (is_selected_keyboard) {
        // Draw a subtle outline or indicator
        draw_set_color(c_yellow);
        draw_set_alpha(0.3);
        draw_circle(icon_x, icon_y, icon_size/2 + 4, true);
        draw_circle(icon_x, icon_y, icon_size/2 + 5, true);
        draw_set_alpha(1);
    }
    
}

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
