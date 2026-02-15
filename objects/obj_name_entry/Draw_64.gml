/// @description Draw Name Entry Interface

// Draw semi-transparent background overlay
draw_set_alpha(0.7);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

// Draw input box background
draw_set_alpha(box_alpha);
draw_set_color(box_color);
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
draw_set_alpha(1);

// Draw border
draw_set_color(border_color);
for (var i = 0; i < border_width; i++) {
    draw_rectangle(box_x + i, box_y + i, box_x + box_width - i, box_y + box_height - i, true);
}

// Set up text drawing
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);
draw_set_font(fnt_Quicksand);

// Draw prompt text
var prompt_y = box_y + 50;
draw_text(box_x + box_width/2, prompt_y, prompt_text);

// Draw the input field
var name_y = box_y + box_height/2;
var display_name = player_name;

// Add blinking cursor
if (cursor_visible && !submitted) {
    display_name += "|";
}

// Draw the name being typed
draw_text(box_x + box_width/2, name_y, display_name);

// Draw instruction text
var instruction_y = box_y + box_height - 40;
draw_set_alpha(0.7);
draw_text(box_x + box_width/2, instruction_y, instruction_text);
draw_set_alpha(1);

// Draw character count
var char_count_text = $"{string_length(player_name)}/{max_name_length}";
draw_set_halign(fa_right);
draw_set_alpha(0.5);
draw_text(box_x + box_width - 20, box_y + box_height - 20, char_count_text);
draw_set_alpha(1);

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
