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

// -- Helper: draw a ‹ value › row (label + left arrow + value + right arrow) --
var _draw_arrow_row = function(_label, _value, _y) {
	// Label on the left
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	draw_text(label_x, _y, _label);

	// Left arrow button
	draw_set(make_color_rgb(60, 60, 80), 1);                         // dark background
	draw_rectangle(arrow_left_x, _y - arrow_h / 2, arrow_left_x + arrow_w, _y + arrow_h / 2, false);
	draw_set(c_yellow, 1);
	text_align(fa_center, fa_middle);
	draw_text(arrow_left_x + arrow_w / 2, _y, "<");                 // arrow glyph

	// Value display between arrows
	draw_set(c_white, 1);
	text_align(fa_center, fa_middle);
	draw_text(value_center_x, _y, string(_value));

	// Right arrow button
	draw_set(make_color_rgb(60, 60, 80), 1);                         // dark background
	draw_rectangle(arrow_right_x, _y - arrow_h / 2, arrow_right_x + arrow_w, _y + arrow_h / 2, false);
	draw_set(c_yellow, 1);
	text_align(fa_center, fa_middle);
	draw_text(arrow_right_x + arrow_w / 2, _y, ">");                // arrow glyph
};

// -- Helper: draw a read-only stat row (label: value + last source) --
var _draw_stat_row = function(_label, _value, _stat_name, _y) {
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	var _last = stat_history_get_last(_stat_name);                   // get last history entry or "none"
	var _source_text = "";
	if (is_struct(_last)) {
		_source_text = $" (last: {_last.source} +{_last.amount})";   // show what changed the stat last
	}
	draw_text(label_x, _y, $"{_label}: {_value}{_source_text}");
};

// -- Helper: draw a clickable name field --
var _draw_name_field = function(_label, _value, _y) {
	// Label on the left
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	draw_text(label_x, _y, _label);

	// Clickable field background
	draw_set(make_color_rgb(50, 50, 60), 1);
	draw_rectangle(dd_field_x, _y - dd_field_h / 2, dd_field_x + dd_field_w, _y + dd_field_h / 2, false);
	draw_set(c_ltgray, 1);
	draw_rectangle(dd_field_x, _y - dd_field_h / 2, dd_field_x + dd_field_w, _y + dd_field_h / 2, true);

	// Name text (or placeholder if empty)
	draw_set(c_white, 1);
	text_align(fa_left, fa_middle);
	var _display = (_value == "") ? "(click to set)" : _value;       // show placeholder when empty
	draw_text(dd_field_x + 10, _y, _display);
};

// -- Helper: draw a horizontal separator line --
var _draw_separator = function(_y) {
	draw_set(c_gray, 0.5);
	draw_line(panel_x + 10, _y, panel_x + panel_w - 10, _y);       // thin gray line across the panel
};

// -- Helper: draw an action button --
var _draw_button = function(_text, _y, _color) {
	draw_set(_color, 1);
	draw_rectangle(btn_x, _y, btn_x + btn_w, _y + btn_h, false);   // filled background
	draw_set(c_white, 1);
	draw_rectangle(btn_x, _y, btn_x + btn_w, _y + btn_h, true);    // border
	text_align(fa_center, fa_middle);
	draw_text(btn_x + btn_w / 2, _y + btn_h / 2, _text);           // centered label
};

// -- Need stats (hunger, happiness, health) --
_draw_arrow_row("Hunger:", global.game.hunger, hunger_row_y);
_draw_arrow_row("Happiness:", global.game.happiness, happiness_row_y);
_draw_arrow_row("Health:", global.game.health, health_row_y);

// -- Separator --
_draw_separator(separator1_y);

// -- Personality stats (read-only with last source) --
_draw_stat_row("Joy", global.pet.joy, "joy", joy_row_y);
_draw_stat_row("Nonsense", global.pet.nonsense, "nonsense", nonsense_row_y);
_draw_stat_row("Self-Esteem", global.pet.selfesteem, "selfesteem", selfesteem_row_y);
_draw_stat_row("Enthusiasm", global.pet.enthusiasm, "enthusiasm", enthusiasm_row_y);

// -- Separator --
_draw_separator(separator2_y);

// -- Corns --
_draw_arrow_row("Corns:", global.game.corns, corns_row_y);

// -- Name fields --
_draw_name_field("Player:", global.game.ownername, ownername_row_y);
_draw_name_field("Pet:", global.game.petname, petname_row_y);

// -- Separator --
_draw_separator(separator3_y);

// -- Action buttons --
_draw_button("QUEUE EVOLUTION", evolve_btn_y, make_color_rgb(40, 80, 40));  // dark green
_draw_button("KILL PET", kill_btn_y, make_color_rgb(140, 30, 30));          // dark red

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
