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

	//Then get ready to save
	var _dataToSave = {
		game: global.game,
		pet: global.pet,
		inventory: global.inventory,
		pantry: global.pantry,
	};

	//And then save.
	json_save_classful("save_data.txt", _dataToSave);
}

function pre_load() {
	//Check if there's a save file
	if (file_exists("save_data.txt")) {
		//load the save data into a variable
		var _data = json_load_classful("save_data.txt");

		//parse that data into our global variables
		global.inventory = _data.inventory;
		static_set(global.inventory, static_get(Inventory));
		global.pantry = _data.pantry;
		static_set(global.pantry, static_get(Inventory));
		global.game = _data.game;
		global.pet = _data.pet;

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
