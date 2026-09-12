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
panel_h = 160;                                          // panel height (collapsed, no dropdown open)
panel_x = display_get_gui_width() - panel_w - 20;      // anchored to the right side with a margin
panel_y = 120;                                          // below the top menu row
dd_field_w = 240;                                       // width of each dropdown field
dd_field_h = 36;                                        // height of each dropdown field
dd_item_h = 32;                                         // height of each item in the open list
dd_field_x = panel_x + panel_w - dd_field_w - 15;      // right-aligned inside the panel
row1_y = panel_y + 55;                                  // Y of the Age dropdown field
row2_y = row1_y + 50;                                   // Y of the Species dropdown field

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
