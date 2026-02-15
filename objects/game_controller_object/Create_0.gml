//Update running time alarm
alarm[0] = 60;

// Set Clutter Spawning alarm to every 5 minutes (fps times 60 seconds times 5)
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Clutter determining alarm
alarm[1] = game_get_speed(gamespeed_fps) * 60 * 5;

//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step

//Give player some food to start (using NEW inventory system)
inventory_add("apple", 10);
inventory_add("bread", 5);