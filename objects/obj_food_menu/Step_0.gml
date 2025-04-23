//use items from inventory
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

if (mouse_check_button_released(mb_left)) {

	var inventory_item = _inventory.item_get();
	for (var row = 0; row < inventory_rows; row++) {
		var pos_y = ui_padding_y + ui_padding_top + (ui_border_size * 5) + (row * (ui_inventory_margin + ui_inventory_box));
		for (var column = 0; column < inventory_columns; column++) {
			var pos_x = ui_padding_x + ui_border_size + ui_inventory_padding + (column * (ui_inventory_margin + ui_inventory_box));


			//hover
			if (is_between(mx, pos_x, pos_x + ui_inventory_box)) {
				if (is_between(my, pos_y, pos_y + ui_inventory_box)) {
					var inventory_index = (row * inventory_columns) + column;

					//Use Item
					if (inventory_index <= array_length(inventory_item) - 1) {
						show_debug_message($"hunger of selected item is {inventory_item[inventory_index].hunger}")
						//Don't do anything if full.
						if (global.game.hunger >= 20) return;
						//If the pet is hungry...
						if (global.game.hunger < 20) {
                            //Set the alarm to stop eating
                            alarm[0] = game_get_speed(gamespeed_fps) * 2;
                            //Set the pet to eating
                            obj_pet_parent.eating = true;
                            //Create the food
                            food_to_eat = inventory_item[inventory_index].object;
                            food_instance = instance_create_layer(room_width/2, 400, "Instances", food_to_eat);
							//Set the alarm to animate the food
                            alarm[1] = 10;
                            //Increase hunger by hunger value
							//If the food amount would increase hunger past 20, only increase to 20.
							if (global.game.hunger + inventory_item[inventory_index].hunger >= 20) {
								global.game.hunger = 20;
								//Decrease pantry amount of item
								_inventory.item_subtract(inventory_item[inventory_index].name, 1);
								//Otherwise, just restore the hunger value
							} else {
								global.game.hunger += inventory_item[inventory_index].hunger;
								show_debug_message($"Restoring {inventory_item[inventory_index].hunger} hunger")
								//Decrease pantry amount of item
								_inventory.item_subtract(inventory_item[inventory_index].name, 1);
							}
						}
						show_debug_message($"hunger is now {global.game.hunger}")


					} else {
						show_debug_message("No inventory item selected.");
					}

				}
			}
		}
	}
}