/// @description Draw Name Entry Interface

// Recalculate positions every frame so they stay centered even if GUI dimensions
// weren't ready yet during Create (common on Android at startup)
box_x = (display_get_gui_width() / 2) - (box_width / 2);
box_y = (display_get_gui_height() / 2) - (box_height / 2);
done_btn_x = (display_get_gui_width() / 2) - (done_btn_width / 2); // Centered below the input box
done_btn_y = box_y + box_height + 20; // 20px gap below the box

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

// Draw instruction text (hidden on mobile since there's a Done button instead)
if (os_type != os_android && os_type != os_ios) {
    var instruction_y = box_y + box_height - 40;
    draw_set_alpha(0.7);
    draw_text(box_x + box_width/2, instruction_y, instruction_text);
    draw_set_alpha(1);
}

// Draw Done button on mobile
if (os_type == os_android || os_type == os_ios) {
    draw_set_alpha(1);
    draw_set_color(done_btn_color); // Green button background
    draw_rectangle(done_btn_x, done_btn_y, done_btn_x + done_btn_width, done_btn_y + done_btn_height, false);
    draw_set_color(c_white); // White border
    draw_rectangle(done_btn_x, done_btn_y, done_btn_x + done_btn_width, done_btn_y + done_btn_height, true);
    draw_set_color(c_white); // White label text
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(done_btn_x + done_btn_width / 2, done_btn_y + done_btn_height / 2, done_btn_label);
}

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
