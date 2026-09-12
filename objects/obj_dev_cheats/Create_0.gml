/// @description Initialize dev cheat panel with dropdown selectors

// -- Phase (age) dropdown options --
phase_options = ["baby", "child", "teen", "adult"];
phase_selected = 0; // index of the currently selected phase

// -- Species dropdown options (flat list of every pet type) --
species_options = [
	// baby pets
	"chobo", "pomba", "dodati",
	// child pets
	"phil", "gnart", "looma", "plang",
	// teen pets
	"teru", "pleh", "blertrand", "vleesh", "goot", "merm", "moof", "yorge",
	// adult pets
	"blinko", "tibb", "clup", "teedee", "teemb", "gluft", "chomly", "balbio",
	"homma", "grimble", "chimchee", "elboo", "nabafee", "bedapy_crinoga", "froodle", "slof",
];
species_selected = 0; // index of the currently selected species

// -- Sync selectors to the current game state --
for (var _i = 0; _i < array_length(phase_options); _i++) {
	if (phase_options[_i] == global.game.evolution_phase) {
		phase_selected = _i;
		break;
	}
}
for (var _i = 0; _i < array_length(species_options); _i++) {
	if (species_options[_i] == global.game.current_pet_type) {
		species_selected = _i;
		break;
	}
}

// -- Dropdown state --
dropdown_open = -1;    // which dropdown is open: -1 = none, 0 = age, 1 = species
dropdown_scroll = 0;   // scroll offset (in items) for the open dropdown
max_visible = 25;      // max items visible at once (fits comfortably on a 1280-tall screen)

// -- Layout constants (GUI coordinates) --
panel_w = 420;                                          // panel width
panel_h = 700;                                          // panel height (tall enough for all controls)
panel_x = display_get_gui_width() - panel_w - 20;      // anchored to the right side with a margin
panel_y = 120;                                          // below the top menu row
dd_field_w = 240;                                       // width of each dropdown field
dd_field_h = 36;                                        // height of each dropdown field
dd_item_h = 32;                                         // height of each item in the open list
dd_field_x = panel_x + panel_w - dd_field_w - 15;      // right-aligned inside the panel
row1_y = panel_y + 55;                                  // Y of the Age dropdown field
row2_y = row1_y + 50;                                   // Y of the Species dropdown field

// -- New controls layout (below the dropdowns) --
row_spacing = 36;                                       // vertical gap between each control row
needs_start_y = row2_y + 60;                            // first need stat row starts here
// Row Y positions — each row is row_spacing apart
hunger_row_y = needs_start_y;                           // hunger ‹ value ›
happiness_row_y = hunger_row_y + row_spacing;           // happiness ‹ value ›
health_row_y = happiness_row_y + row_spacing;           // health ‹ value ›
separator1_y = health_row_y + row_spacing;              // visual divider
joy_row_y = separator1_y + 14;                          // joy (read-only + last source)
nonsense_row_y = joy_row_y + row_spacing;               // nonsense (read-only + last source)
selfesteem_row_y = nonsense_row_y + row_spacing;        // self-esteem (read-only + last source)
enthusiasm_row_y = selfesteem_row_y + row_spacing;      // enthusiasm (read-only + last source)
separator2_y = enthusiasm_row_y + row_spacing;          // visual divider
corns_row_y = separator2_y + 14;                        // corns ‹ value ›
ownername_row_y = corns_row_y + row_spacing;            // player name [click to edit]
petname_row_y = ownername_row_y + row_spacing;          // pet name [click to edit]
separator3_y = petname_row_y + row_spacing;             // visual divider
evolve_btn_y = separator3_y + 14;                       // queue evolution button
kill_btn_y = evolve_btn_y + row_spacing + 4;            // kill pet button

// Arrow button dimensions for ‹ value › controls
arrow_w = 28;                                           // width of each < > arrow button
arrow_h = 28;                                           // height of each < > arrow button
value_field_w = 60;                                     // width of the value display between arrows
label_x = panel_x + 15;                                 // left edge of labels
value_center_x = dd_field_x + dd_field_w / 2;           // center of the value area (aligned with dropdowns)
arrow_left_x = value_center_x - value_field_w / 2 - arrow_w; // left arrow x
arrow_right_x = value_center_x + value_field_w / 2;    // right arrow x

// Button dimensions for action buttons
btn_w = 200;                                            // width of action buttons
btn_h = 32;                                             // height of action buttons
btn_x = panel_x + panel_w / 2 - btn_w / 2;             // centered horizontally in the panel

// Async dialog tracking for name editing
async_target = "";                                      // "ownername" or "petname" — which field is being edited

/// @function apply_phase()
/// @description Sets the evolution phase without touching the pet species
apply_phase = function() {
	global.game.evolution_phase = phase_options[phase_selected];
	pre_save(); // persist the change to disk
};

/// @function apply_species()
/// @description Swaps the pet instance to the selected species and saves
apply_species = function() {
	var _species = species_options[species_selected];
	global.game.current_pet_type = _species;
	global.game.evolution_queued = 1; // prevent auto-evolution from overriding

	// Build the object name and look it up
	var _obj_name = $"obj_pet_{_species}";
	var _obj_index = asset_get_index(_obj_name);
	if (_obj_index == -1) {
		show_debug_message($"DEV CHEATS: object '{_obj_name}' not found");
		return;
	}

	// If a pet exists, destroy it and spawn the new one at the same position
	if (instance_exists(obj_pet_parent)) {
		var _px = obj_pet_parent.x;
		var _py = obj_pet_parent.y;
		instance_destroy(obj_pet_parent);
		instance_create_layer(_px, _py, "Instances", _obj_index);
	} else {
		// No pet in this room yet — create one at center of room
		instance_create_layer(room_width / 2, room_height / 2, "Instances", _obj_index);
	}

	pre_save(); // persist the change to disk
};

/// @function adjust_need(_field, _delta)
/// @description Changes a need stat (hunger/happiness/health) by _delta, clamped to 0–20, and saves
adjust_need = function(_field, _delta) {
	global.game[$ _field] = clamp(global.game[$ _field] + _delta, 0, 20); // adjust within 0–20 range
	pre_save(); // persist the change to disk
};

/// @function adjust_corns(_delta)
/// @description Changes corn total by _delta (min 0, no upper cap), and saves
adjust_corns = function(_delta) {
	global.game.corns = max(global.game.corns + _delta, 0); // never go below 0
	pre_save(); // persist the change to disk
};

/// @function queue_evolution()
/// @description Queues an evolution to trigger when the player returns to the main room
queue_evolution = function() {
	global.game.evolution_queued = 0; // obj_pet_parent Step checks for 0 and triggers Alarm_6
	pre_save(); // persist the change to disk
};

/// @function kill_pet()
/// @description Sets health to 0 — game_controller_object Step handles the death flow from there
kill_pet = function() {
	global.game.health = 0; // game_controller detects health <= 0, sets living = false, goes to rm_death
};
