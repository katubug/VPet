/// @description Draw Icon Menu (Debug - Colored Circles)

// Draw each menu item as a colored circle
for (var i = 0; i < menu_count; i++) {
    var item = menu_items[i];
    
    if (!item.enabled) continue;
    
    var icon_x = menu_start_x + (i * icon_spacing);
    var icon_y = menu_y;
    
    // Determine color and alpha
    var use_color = item.color;
    var use_alpha = menu_alpha_unselected;
    
    var is_selected_keyboard = (last_input_was_keyboard && i == selected_index);
    var is_hovered_mouse = (!last_input_was_keyboard && i == hover_index);
    
    if (is_selected_keyboard || is_hovered_mouse) {
        use_color = item.color_highlight;
        use_alpha = menu_alpha_selected;
    } else if (i == hover_index) {
        use_alpha = menu_alpha_hover;
    }
    
    // Draw the icon circle
    draw_set_alpha(use_alpha);
    draw_set_color(use_color);
    draw_circle(icon_x, icon_y, icon_size/2, false);
    
    // Draw outline
    draw_set_color(c_white);
    draw_set_alpha(use_alpha * 0.5);
    draw_circle(icon_x, icon_y, icon_size/2, true);
    draw_circle(icon_x, icon_y, icon_size/2 - 1, true);
    
    // Draw selection indicator for keyboard mode
    if (is_selected_keyboard) {
        draw_set_color(c_yellow);
        draw_set_alpha(0.6);
        draw_circle(icon_x, icon_y, icon_size/2 + 4, true);
        draw_circle(icon_x, icon_y, icon_size/2 + 5, true);
        draw_circle(icon_x, icon_y, icon_size/2 + 6, true);
    }
    
    // Draw label
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(-1); // Default font
    
    // Draw text on the circle
    var label_alpha = is_selected_keyboard || is_hovered_mouse ? 1.0 : 0.7;
    draw_set_alpha(label_alpha);
    draw_text(icon_x, icon_y, item.label);
}

// Reset draw settings
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
