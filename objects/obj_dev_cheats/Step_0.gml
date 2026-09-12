/// @description Handle dropdown interaction — open, scroll, select

// -- Mouse wheel scrolling (works even without a click) --
if (dropdown_open != -1) {
	var _options = (dropdown_open == 0) ? phase_options : species_options;
	var _count = array_length(_options);
	var _visible = min(_count, max_visible);

	if (mouse_wheel_down()) {
		dropdown_scroll = min(_count - _visible, dropdown_scroll + 3); // scroll down 3 items
	}
	if (mouse_wheel_up()) {
		dropdown_scroll = max(0, dropdown_scroll - 3);                 // scroll up 3 items
	}
}

// -- Click handling --
if (!mouse_check_button_pressed(mb_left)) exit;

var _mx = device_mouse_x_to_gui(0); // mouse X in GUI space
var _my = device_mouse_y_to_gui(0); // mouse Y in GUI space

// -- If a dropdown is open, check for clicks on its items --
if (dropdown_open != -1) {
	var _options = (dropdown_open == 0) ? phase_options : species_options;
	var _count = array_length(_options);
	var _visible = min(_count, max_visible);
	var _anchor_y = (dropdown_open == 0) ? row1_y : row2_y; // the field this list drops from
	var _list_y = _anchor_y + dd_field_h;                    // top of the dropdown list

	// Check if the click landed on one of the visible items
	for (var _i = 0; _i < _visible; _i++) {
		var _item_y = _list_y + _i * dd_item_h;             // top edge of this item
		if (point_in_rectangle(_mx, _my, dd_field_x, _item_y, dd_field_x + dd_field_w, _item_y + dd_item_h)) {
			var _actual_index = _i + dropdown_scroll;        // account for scroll offset
			if (dropdown_open == 0) {
				phase_selected = _actual_index;
				apply_phase();
			} else {
				species_selected = _actual_index;
				apply_species();
			}
			dropdown_open = -1;                              // close the dropdown after selection
			dropdown_scroll = 0;
			exit;
		}
	}

	// Click was outside the dropdown list — close it
	dropdown_open = -1;
	dropdown_scroll = 0;
	exit;
}

// -- No dropdown is open — check if clicking on a dropdown field to open it --

// Age field
if (point_in_rectangle(_mx, _my, dd_field_x, row1_y, dd_field_x + dd_field_w, row1_y + dd_field_h)) {
	dropdown_open = 0;
	dropdown_scroll = 0;
	exit;
}

// Species field
if (point_in_rectangle(_mx, _my, dd_field_x, row2_y, dd_field_x + dd_field_w, row2_y + dd_field_h)) {
	dropdown_open = 1;
	dropdown_scroll = 0;
	exit;
}

// -- Need stat arrow buttons (hunger, happiness, health) --
// Each has a left arrow (decrease by 1) and right arrow (increase by 1)
var _need_rows = [
	{ field: "hunger",    y: hunger_row_y },
	{ field: "happiness", y: happiness_row_y },
	{ field: "health",    y: health_row_y },
];
for (var _i = 0; _i < array_length(_need_rows); _i++) {
	var _row = _need_rows[_i];
	var _ry = _row.y;                                              // center Y of this row
	// Left arrow — decrease by 1
	if (point_in_rectangle(_mx, _my, arrow_left_x, _ry - arrow_h / 2, arrow_left_x + arrow_w, _ry + arrow_h / 2)) {
		adjust_need(_row.field, -1);
		exit;
	}
	// Right arrow — increase by 1
	if (point_in_rectangle(_mx, _my, arrow_right_x, _ry - arrow_h / 2, arrow_right_x + arrow_w, _ry + arrow_h / 2)) {
		adjust_need(_row.field, 1);
		exit;
	}
}

// -- Corns arrow buttons (±10 per click) --
// Left arrow — decrease by 10
if (point_in_rectangle(_mx, _my, arrow_left_x, corns_row_y - arrow_h / 2, arrow_left_x + arrow_w, corns_row_y + arrow_h / 2)) {
	adjust_corns(-10);
	exit;
}
// Right arrow — increase by 10
if (point_in_rectangle(_mx, _my, arrow_right_x, corns_row_y - arrow_h / 2, arrow_right_x + arrow_w, corns_row_y + arrow_h / 2)) {
	adjust_corns(10);
	exit;
}

// -- Name fields (click to edit via async dialog) --
// Player name — clickable text area
if (point_in_rectangle(_mx, _my, dd_field_x, ownername_row_y - dd_field_h / 2, dd_field_x + dd_field_w, ownername_row_y + dd_field_h / 2)) {
	async_target = "ownername";                                    // remember which name field we're editing
	get_string_async("Enter player name:", global.game.ownername); // opens OS text input dialog
	exit;
}
// Pet name — clickable text area
if (point_in_rectangle(_mx, _my, dd_field_x, petname_row_y - dd_field_h / 2, dd_field_x + dd_field_w, petname_row_y + dd_field_h / 2)) {
	async_target = "petname";                                      // remember which name field we're editing
	get_string_async("Enter pet name:", global.game.petname);      // opens OS text input dialog
	exit;
}

// -- Queue Evolution button --
if (point_in_rectangle(_mx, _my, btn_x, evolve_btn_y, btn_x + btn_w, evolve_btn_y + btn_h)) {
	queue_evolution();
	exit;
}

// -- Kill Pet button --
if (point_in_rectangle(_mx, _my, btn_x, kill_btn_y, btn_x + btn_w, kill_btn_y + btn_h)) {
	kill_pet();
	exit;
}
