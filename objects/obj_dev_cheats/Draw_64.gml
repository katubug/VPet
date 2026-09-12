/// @description Draw the dev cheat panel with dropdown selectors

draw_set_font(fnt_Kubasta);

// -- Panel background --
draw_set(c_black, 0.75);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, false);
draw_set(c_yellow, 1);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, true);

// -- Title --
text_align(fa_center, fa_middle);
draw_set(c_yellow, 1);
draw_text(panel_x + panel_w / 2, panel_y + 22, "DEV CHEATS");

// -- Helper: draw a dropdown field (the closed box showing the current value) --
var _draw_field = function(_label, _value, _label_x, _field_x, _y, _w, _h, _is_open) {
	// Label to the left
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	draw_text(_label_x, _y + _h / 2, _label);

	// Field background
	if (_is_open) {
		draw_set(c_dkgray, 1);  // darker when open to show it's active
	} else {
		draw_set(make_color_rgb(50, 50, 60), 1);
	}
	draw_rectangle(_field_x, _y, _field_x + _w, _y + _h, false);

	// Field border
	draw_set(c_ltgray, 1);
	draw_rectangle(_field_x, _y, _field_x + _w, _y + _h, true);

	// Current value text
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	draw_text(_field_x + 10, _y + _h / 2, _value);

	// Down arrow indicator on the right side
	text_align(fa_right, fa_middle);
	draw_set(c_yellow, 1);
	draw_text(_field_x + _w - 8, _y + _h / 2, "v");
};

// -- Age dropdown field --
_draw_field("Age:", phase_options[phase_selected],
	panel_x + 15, dd_field_x, row1_y, dd_field_w, dd_field_h,
	dropdown_open == 0);

// -- Species dropdown field --
_draw_field("Pet:", species_options[species_selected],
	panel_x + 15, dd_field_x, row2_y, dd_field_w, dd_field_h,
	dropdown_open == 1);

// -- Draw the open dropdown list (if any) --
if (dropdown_open != -1) {
	var _options = (dropdown_open == 0) ? phase_options : species_options;
	var _sel = (dropdown_open == 0) ? phase_selected : species_selected;
	var _count = array_length(_options);
	var _visible = min(_count, max_visible);
	var _anchor_y = (dropdown_open == 0) ? row1_y : row2_y;
	var _list_y = _anchor_y + dd_field_h; // list starts right below the field

	// List background
	draw_set(c_black, 0.9);
	draw_rectangle(dd_field_x, _list_y, dd_field_x + dd_field_w, _list_y + _visible * dd_item_h, false);

	// List border
	draw_set(c_ltgray, 1);
	draw_rectangle(dd_field_x, _list_y, dd_field_x + dd_field_w, _list_y + _visible * dd_item_h, true);

	// Mouse position for hover highlight
	var _mx = device_mouse_x_to_gui(0);
	var _my = device_mouse_y_to_gui(0);

	// Draw each visible item
	for (var _i = 0; _i < _visible; _i++) {
		var _actual = _i + dropdown_scroll;           // the real index in the options array
		var _item_y = _list_y + _i * dd_item_h;      // top of this item's row

		// Hover highlight
		if (point_in_rectangle(_mx, _my, dd_field_x, _item_y, dd_field_x + dd_field_w, _item_y + dd_item_h)) {
			draw_set(make_color_rgb(60, 60, 80), 1);
			draw_rectangle(dd_field_x + 1, _item_y, dd_field_x + dd_field_w - 1, _item_y + dd_item_h, false);
		}

		// Selected item highlight
		if (_actual == _sel) {
			draw_set(c_yellow, 0.2);
			draw_rectangle(dd_field_x + 1, _item_y, dd_field_x + dd_field_w - 1, _item_y + dd_item_h, false);
		}

		// Item text
		draw_set((_actual == _sel) ? c_yellow : c_white, 1);
		text_align(fa_left, fa_middle);
		draw_text(dd_field_x + 10, _item_y + dd_item_h / 2, _options[_actual]);
	}

	// Scroll indicators (arrows at top/bottom of list if there are hidden items)
	text_align(fa_center, fa_middle);
	if (dropdown_scroll > 0) {
		draw_set(c_yellow, 1);
		draw_text(dd_field_x + dd_field_w / 2, _list_y + 8, "^ ^ ^"); // more items above
	}
	if (dropdown_scroll + _visible < _count) {
		draw_set(c_yellow, 1);
		var _bottom = _list_y + _visible * dd_item_h;
		draw_text(dd_field_x + dd_field_w / 2, _bottom - 8, "v v v"); // more items below
	}
}

// -- Reset draw state --
draw_reset();
draw_set_font(-1);
text_align(fa_left, fa_top);
