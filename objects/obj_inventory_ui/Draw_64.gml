/// @description Draw Inventory UI

// Draw semi-transparent overlay
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Draw main background
draw_set_alpha(bg_alpha);
draw_set_color(color_background);
draw_rectangle(ui_x, ui_y, ui_x + ui_width, ui_y + ui_height, false);
draw_set_alpha(1);

// Draw border
draw_set_color(color_border);
for (var i = 0; i < slot_border; i++) {
    draw_rectangle(ui_x + i, ui_y + i, ui_x + ui_width - i, ui_y + ui_height - i, true);
}

// Draw tabs
if (show_tabs) {
    var tab_y = ui_y + 40;
    
    for (var i = 0; i < array_length(tabs); i++) {
        var tab_x = ui_x + (i * tab_width);
        var is_active = (i == current_tab);
        
        // Tab background
        draw_set_alpha(is_active ? 1.0 : 0.6);
        draw_set_color(is_active ? color_slot_filled : color_slot_empty);
        draw_rectangle(tab_x, tab_y, tab_x + tab_width - 5, tab_y + tab_height, false);
        
        // Tab border
        draw_set_alpha(1);
        draw_set_color(is_active ? color_border : c_gray);
        draw_rectangle(tab_x, tab_y, tab_x + tab_width - 5, tab_y + tab_height, true);
        
        // Tab text
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_font(fnt_Quicksand);
        draw_set_color(is_active ? c_white : c_gray);
        draw_text(tab_x + (tab_width - 5) / 2, tab_y + tab_height / 2, tabs[i].name);
    }
}

// Draw title
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_Quicksand);
draw_set_color(color_text);
draw_text(ui_x + 20, ui_y + 10, ui_title);

// Draw close button
if (show_close_button) {
    draw_set_color(c_red);
    draw_circle(close_button_x + close_button_size/2, close_button_y + close_button_size/2, close_button_size/2, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(close_button_x + close_button_size/2, close_button_y + close_button_size/2, "X");
}

// Get items for current category
var items = inventory_get_all_items(ui_category);
var grid_start_x = ui_x + slot_padding;
var grid_start_y = ui_y + 80 + slot_padding;

// Draw inventory grid
for (var row = 0; row < grid_rows; row++) {
    for (var col = 0; col < grid_columns; col++) {
        var slot_index = ((row + scroll_offset) * grid_columns) + col;
        var slot_x = grid_start_x + (col * (slot_size + slot_padding));
        var slot_y = grid_start_y + (row * (slot_size + slot_padding));
        
        // Get scale for this slot
        var scale = 1.0;
        if (slot_index < array_length(slot_scale)) {
            scale = slot_scale[slot_index];
        }
        
        var scaled_size = slot_size * scale;
        var scale_offset = (slot_size - scaled_size) / 2;
        
        // Determine slot color
        var slot_color = color_slot_empty;
        var has_item = (slot_index < array_length(items));
        
        if (has_item) {
            slot_color = color_slot_filled;
        }
        
        if (slot_index == hover_slot) {
            slot_color = color_slot_hover;
        }
        
        if (slot_index == selected_slot) {
            slot_color = color_slot_selected;
        }
        
        // Draw slot background
        draw_set_alpha(0.9);
        draw_set_color(slot_color);
        draw_rectangle(
            slot_x + scale_offset, 
            slot_y + scale_offset, 
            slot_x + scale_offset + scaled_size, 
            slot_y + scale_offset + scaled_size, 
            false
        );
        draw_set_alpha(1);
        
        // Draw slot border
        draw_set_color(color_border);
        draw_rectangle(
            slot_x + scale_offset, 
            slot_y + scale_offset, 
            slot_x + scale_offset + scaled_size, 
            slot_y + scale_offset + scaled_size, 
            true
        );
        
        // Draw item if exists
        if (has_item) {
            var item = items[slot_index];
            var item_data = inventory_get_item_data(item.id);
            
            if (item_data != undefined) {
                // Draw item sprite
                var sprite = item_data.sprite;
                var sprite_scale = (scaled_size * 0.8) / max(sprite_get_width(sprite), sprite_get_height(sprite));
                
                draw_sprite_ext(
                    sprite, 
                    0, 
                    slot_x + scale_offset + scaled_size / 2, 
                    slot_y + scale_offset + scaled_size / 2, 
                    sprite_scale, 
                    sprite_scale, 
                    0, 
                    c_white, 
                    1
                );
                
                // Draw quantity
                if (show_quantity && item.quantity > 1) {
                    // Quantity background
                    draw_set_alpha(0.8);
                    draw_set_color(c_black);
                    draw_circle(
                        slot_x + scale_offset + scaled_size - 15, 
                        slot_y + scale_offset + scaled_size - 15, 
                        12, 
                        false
                    );
                    draw_set_alpha(1);
                    
                    // Quantity text
                    draw_set_halign(fa_center);
                    draw_set_valign(fa_middle);
                    draw_set_color(c_white);
                    draw_text(
                        slot_x + scale_offset + scaled_size - 15, 
                        slot_y + scale_offset + scaled_size - 15, 
                        string(item.quantity)
                    );
                }
                
                // Draw durability bar for toys
                if (item_data.category == "toy" && item.durability != undefined && item.durability >= 0) {
                    var durability_percent = item.durability / item_data.durability;
                    var bar_width = scaled_size * 0.8;
                    var bar_height = 4;
                    var bar_x = slot_x + scale_offset + (scaled_size - bar_width) / 2;
                    var bar_y = slot_y + scale_offset + scaled_size - 8;
                    
                    // Background
                    draw_set_alpha(0.7);
                    draw_set_color(c_dkgray);
                    draw_rectangle(bar_x, bar_y, bar_x + bar_width, bar_y + bar_height, false);
                    
                    // Durability bar
                    var durability_color = durability_percent > 0.5 ? c_lime : (durability_percent > 0.25 ? c_yellow : c_red);
                    draw_set_color(durability_color);
                    draw_rectangle(bar_x, bar_y, bar_x + (bar_width * durability_percent), bar_y + bar_height, false);
                    draw_set_alpha(1);
                }
            }
        }
    }
}

// Draw tooltip for hovered item
if (show_tooltips && hover_slot != -1 && hover_slot < array_length(items)) {
    var item = items[hover_slot];
    var item_data = inventory_get_item_data(item.id);
    
    if (item_data != undefined) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        // Tooltip dimensions
        var tooltip_width = 250;
        var tooltip_height = 150;
        var tooltip_x = clamp(mx + 20, 0, display_get_gui_width() - tooltip_width);
        var tooltip_y = clamp(my + 20, 0, display_get_gui_height() - tooltip_height);
        
        // Tooltip background
        draw_set_alpha(0.95);
        draw_set_color(color_background);
        draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_width, tooltip_y + tooltip_height, false);
        draw_set_alpha(1);
        
        // Tooltip border
        draw_set_color(color_border);
        draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_width, tooltip_y + tooltip_height, true);
        draw_rectangle(tooltip_x + 1, tooltip_y + 1, tooltip_x + tooltip_width - 1, tooltip_y + tooltip_height - 1, true);
        
        // Draw item info
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        var text_x = tooltip_x + 10;
        var text_y = tooltip_y + 10;
        var line_height = 18;
        
        // Name
        draw_text(text_x, text_y, item_data.name);
        text_y += line_height + 5;
        
        // Quantity
        draw_set_color(c_ltgray);
        draw_text(text_x, text_y, "Quantity: " + string(item.quantity));
        text_y += line_height;
        
        // Description
        draw_text_ext(text_x, text_y, item_data.description, line_height, tooltip_width - 20);
        text_y += line_height * 2;
        
        // Category-specific info
        draw_set_color(c_white);
        if (item_data.category == "food") {
            draw_text(text_x, text_y, "Hunger: +" + string(item_data.hunger_restore));
            text_y += line_height;
        } else if (item_data.category == "toy") {
            draw_text(text_x, text_y, "Happiness: +" + string(item_data.happiness_restore));
            text_y += line_height;
            draw_text(text_x, text_y, "Durability: " + string(item.durability) + "/" + string(item_data.durability));
        } else if (item_data.category == "seed") {
            draw_text(text_x, text_y, "Grow Time: " + string(item_data.grow_time) + "s");
            text_y += line_height;
            draw_text(text_x, text_y, "Harvest: " + string(item_data.harvest_amount) + "x");
        }
    }
}

// Draw storage info
draw_set_halign(fa_right);
draw_set_valign(fa_top);
draw_set_color(c_ltgray);
var storage_text = string(array_length(items)) + "/" + string(global.inventory_limits[$ ui_category]) + " items";
draw_text(ui_x + ui_width - 20, ui_y + ui_height - 25, storage_text);

// Draw scroll indicator
if (max_scroll > 0) {
    draw_set_halign(fa_center);
    var scroll_text = "Scroll: " + string(scroll_offset) + "/" + string(max_scroll);
    draw_text(ui_x + ui_width / 2, ui_y + ui_height - 25, scroll_text);
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
