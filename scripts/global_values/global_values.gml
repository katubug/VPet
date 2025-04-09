randomize();

// Following this tutorial: https://www.youtube.com/watch?v=3FGMKQ_8bIc

function Inventory() constructor {
	//Create an empty array.
	_inventory_items = [];

	//A function to set the name of the item type, the quantity, and the sprite of the item.
	static item_set = function(_name, _slug, _quantity, _sprite, _hunger) {
		array_push(_inventory_items, {
			name: _name,
			slug: _slug,
			quantity: _quantity,
			sprite: _sprite,
			hunger: _hunger,
		});
	}

	//Find items in inventory. Accepts the parameter "_name" and iterates over all indexes in the array
	//"_inventory_items." If the name matches, return the index number of the matching items.
	static item_find = function(_name) {
		for (var item_index = 0; item_index < array_length(_inventory_items); item_index++) {
			if (_name == _inventory_items[item_index].name) {
				return item_index;
			}
		}
		//If there are no matches, return -1.
		return -1;
	}

	//Now, a function to add items to the inventory.
	static item_add = function(_name, _slug, _quantity, _sprite, _hunger) {
		//first, check if it exists in the inventory by passing the item's _name into the item_find 
		//function.
		var index = item_find(_name);

		//If the item is in the inventory, increase inventory quantity by newly obtained item quantity
		if (index >= 0) {
			_inventory_items[index].quantity += _quantity;
		} else {
			item_set(_name, _slug, _quantity, _sprite, _hunger);
		}
	}

	//A function to see if our inventory contains the item we're trying to use.
	static item_has = function(_name, _quantity) {
		var index = item_find(_name)

		if (index >= 0) {
			// If the item exists, return true
			return _inventory_items[index].quantity >= _quantity;
		}
		//otherwise false
		return false;
	}

	static item_subtract = function(_name, _quantity) {
		var index = item_find(_name)

		if (index >= 0) {
			if (item_has(_name, _quantity)) {
				_inventory_items[index].quantity -= _quantity;

				if (_inventory_items[index].quantity <= 0) item_remove(index);

			}
		}
	}

	static item_remove = function(_index) {
		array_delete(_inventory_items, _index, 1);
	}

	static item_get = function() {
		return _inventory_items;
	}

	static toString = function() {
		return json_stringify(_inventory_items);
	}

}


global.game = {
	struct_version: 0.3,
	ownername: "",
	living: 1,
	corns: 100,
	hunger: 20,
	health: 20,
	happiness: 20,
	clutter_exists: false,
	year: current_year,
	month: current_month,
	day: current_day,
	hour: current_hour,
	minute: current_minute,
	second: current_second,
	//because current time is in milliseconds, we divide it by 1000 to change it to seconds
	session_time: (current_time / 1000),
	previous_total_time: 0,
	running_time: 0,
	banked_time: 0,
	last_saved_time: 0,
	evolution_phase: "baby",
	current_pet_type: "",
	evolution_queued: 1,
	previous_pet_type: "",
	garden: {
		seed_planted: "",
		growth_time: 0,
		watered: 0,
	}
};

var _base = 86400; //86400 = 24 hours in seconds 
global.game.evolution_time = {
	base: _base,
	child: (_base / 2),
	teen: (_base * 2),
	adult: (_base * 3),
};

global.inventory = new Inventory();
global.pantry = new Inventory();

global.pet = {
	joy: 0,
	nonsense: 0,
	selfesteem: 0,
	enthusiasm: 0,
};

starter_pet = irandom_range(0, 2);
if (global.game.current_pet_type == "") {
	if (starter_pet == 0) global.game.current_pet_type = "chobo";
	if (starter_pet == 1) global.game.current_pet_type = "pomba";
	if (starter_pet == 2) global.game.current_pet_type = "dodati";
}