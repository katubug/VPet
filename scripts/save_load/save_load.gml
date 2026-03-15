function pre_save() {
	//Ensure we save the end-of-session date and time so they can be properly calculated on load.
	save_date();
	_new_time = global.game.session_time - global.game.last_saved_time;

	//Bank the previous total time played.
	global.game.banked_time = global.game.previous_total_time + _new_time;

	show_debug_message(
		$"banking previous total time ({
			global.game.previous_total_time
		}) plus current session time since last save ({_new_time}), equalling {
			global.game.banked_time
		}"
	);
	//Reset previous time to zero because all that time is banked now.
	global.game.previous_total_time = global.game.banked_time;

	//Reset the last-saved current time to right now
	global.game.last_saved_time = current_time / 1000;

	//Then get ready to save (NEW INVENTORY SYSTEM)
	var _dataToSave = {
		game: global.game,
		pet: global.pet,
		inventory: global.inventory,  // New inventory system structure
		inventory_limits: global.inventory_limits,
		pet_diet_stats: global.pet_diet_stats,
		discovered_items: ds_map_write(global.discovered_items)  // Save discovered items
	};

	//And then save.
    if (global.game.ownername != ""){
	json_save_classful("save_data.txt", _dataToSave);
    }
}

function pre_load() {
	//Check if there's a save file
	if (file_exists("save_data.txt")) {
		//load the save data into a variable
		var _data = json_load_classful("save_data.txt");

		//parse that data into our global variables
		global.game = _data.game;
		global.pet = _data.pet;
		
		// Load new inventory system
		if (variable_struct_exists(_data, "inventory")) {
			global.inventory = _data.inventory;
		}
		
		if (variable_struct_exists(_data, "inventory_limits")) {
			global.inventory_limits = _data.inventory_limits;
		}
		
		if (variable_struct_exists(_data, "pet_diet_stats")) {
			global.pet_diet_stats = _data.pet_diet_stats;
		}
		
		// Load discovered items
		if (variable_struct_exists(_data, "discovered_items")) {
			global.discovered_items = ds_map_create();
			ds_map_read(global.discovered_items, _data.discovered_items);
		}
		
		// Migrate old saves that predate petname/gender fields
		if (!variable_struct_exists(global.game, "petname")) {
			global.game.petname = "";
		}
		if (!variable_struct_exists(global.game, "gender")) {
			global.game.gender = "";
		}

		// Migrate old saves that used a garden struct instead of garden_plots array
		if (!variable_struct_exists(global.game, "garden_plots")) {
			global.game.garden_plots = [];
			for (var _gi = 0; _gi < 9; _gi++) {
				array_push(global.game.garden_plots, {
					seed_type: "none", plant_time: -1,
					water_time: -1, bonus_seconds: 0,
				});
			}
		}

		// Make sure item database is initialized
		inventory_init_database();

		//Reset the session time and the last saved time to the current session
		show_debug_message(
			$"Previous game session time was {
				global.game.session_time
			} seconds. Setting to 0 now."
		);
		global.game.session_time = 0;
		global.game.last_saved_time = 0;

		//Do date/time function to calculate elapsed time plus banked time, and to set both banked and
		//previous total times.
		date_time();
	}
}
