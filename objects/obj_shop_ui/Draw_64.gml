/// @description Draw Shop UI

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

// Draw title
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fnt_Quicksand);
draw_set_color(color_text);
draw_text(ui_x + 20, ui_y + 10, ui_title);

// Draw corn count
draw_set_halign(fa_right);
draw_set_color(c_yellow);
draw_text(ui_x + ui_width - 50, ui_y + 10, "Corns: " + string(global.game.corns));

// Draw close button
if (show_close_button) {
    draw_set_color(c_red);
    draw_circle(close_button_x + close_button_size/2, close_button_y + close_button_size/2, close_button_size/2, false);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(close_button_x + close_button_size/2, close_button_y + close_button_size/2, "X");
}

// Draw shop grid
var grid_start_x = ui_x + slot_padding;
var grid_start_y = ui_y + 80 + slot_padding;

for (var row = 0; row < grid_rows; row++) {
    for (var col = 0; col < grid_columns; col++) {
        var slot_index = ((row + scroll_offset) * grid_columns) + col;
        var slot_x = grid_start_x + (col * (slot_size + slot_padding));
        var slot_y = grid_start_y + (row * (slot_size + slot_padding));
        
        // Get scale
        var scale = 1.0;
        if (slot_index < array_length(slot_scale)) {
            scale = slot_scale[slot_index];
        }
        
        var scaled_size = slot_size * scale;
        var scale_offset = (slot_size - scaled_size) / 2;
        
        // Check if slot has item
        var has_item = (slot_index < array_length(shop_items));
        
        if (!has_item) continue; // Skip empty slots
        
        var shop_item = shop_items[slot_index];
        var item_data = inventory_get_item_data(shop_item.item_id);
        
        if (item_data == undefined) continue;
        
        // Determine slot color
        var slot_color = color_slot_filled;
        
        if (slot_index == hover_slot) {
            slot_color = color_slot_hover;
        }
        
        if (slot_index == selected_slot) {
            slot_color = color_slot_selected;
        }
        
        // Check if affordable
        var can_afford = (global.game.corns >= item_data.buy_price);
        var out_of_stock = (shop_item.stock == 0);
        
        // Draw slot background
        draw_set_alpha(out_of_stock ? 0.3 : 0.9);
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
        
        // Draw item sprite
        var sprite = item_data.sprite;
        var sprite_scale = (scaled_size * 0.6) / max(sprite_get_width(sprite), sprite_get_height(sprite));
        
        draw_set_alpha(out_of_stock ? 0.3 : 1);
        draw_sprite_ext(
            sprite, 
            0, 
            slot_x + scale_offset + scaled_size / 2, 
            slot_y + scale_offset + scaled_size / 2 - 10, 
            sprite_scale, 
            sprite_scale, 
            0, 
            c_white, 
            1
        );
        draw_set_alpha(1);
        
        // Draw price
        var price_color = can_afford ? color_price_affordable : color_price_expensive;
        draw_set_halign(fa_center);
        draw_set_valign(fa_bottom);
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(
            slot_x + scale_offset, 
            slot_y + scale_offset + scaled_size - 20, 
            slot_x + scale_offset + scaled_size, 
            slot_y + scale_offset + scaled_size, 
            false
        );
        draw_set_alpha(1);
        
        draw_set_color(price_color);
        draw_text(
            slot_x + scale_offset + scaled_size / 2, 
            slot_y + scale_offset + scaled_size - 2, 
            string(item_data.buy_price) + "c"
        );
        
        // Draw stock (if limited)
        if (shop_item.stock > 0) {
            draw_set_halign(fa_right);
            draw_set_valign(fa_top);
            draw_set_color(c_white);
            draw_set_alpha(0.8);
            draw_text(
                slot_x + scale_offset + scaled_size - 5, 
                slot_y + scale_offset + 5, 
                "x" + string(shop_item.stock)
            );
            draw_set_alpha(1);
        }
        
        // Draw "SOLD OUT" if out of stock
        if (out_of_stock) {
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_set_color(c_red);
            draw_text_transformed(
                slot_x + scale_offset + scaled_size / 2, 
                slot_y + scale_offset + scaled_size / 2, 
                "SOLD OUT",
                0.6,
                0.6,
                -15
            );
        }
    }
}

// Draw tooltip for hovered item
if (hover_slot != -1 && hover_slot < array_length(shop_items)) {
    var shop_item = shop_items[hover_slot];
    var item_data = inventory_get_item_data(shop_item.item_id);
    
    if (item_data != undefined) {
        var mx = device_mouse_x_to_gui(0);
        var my = device_mouse_y_to_gui(0);
        
        // Tooltip dimensions
        var tooltip_width = 250;
        var tooltip_height = 120;
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
        
        // Price
        var can_afford = (global.game.corns >= item_data.buy_price);
        draw_set_color(can_afford ? color_price_affordable : color_price_expensive);
        draw_text(text_x, text_y, "Price: " + string(item_data.buy_price) + " corns");
        text_y += line_height;
        
        // Stock
        draw_set_color(c_ltgray);
        if (shop_item.stock == -1) {
            draw_text(text_x, text_y, "Stock: Unlimited");
        } else {
            draw_text(text_x, text_y, "Stock: " + string(shop_item.stock));
        }
        text_y += line_height;
        
        // Description
        draw_set_color(c_white);
        draw_text_ext(text_x, text_y, item_data.description, line_height, tooltip_width - 20);
    }
}

// Draw instructions at bottom
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(c_ltgray);
draw_set_alpha(0.7);
draw_text(ui_x + ui_width / 2, ui_y + ui_height - 10, "Click to purchase");
draw_set_alpha(1);

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
