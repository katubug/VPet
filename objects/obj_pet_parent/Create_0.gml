target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;
pet_talking = false;

//Need degradation
//TODO should i put this in game controller?
alarm[0] = 60*20;

//Random Walking
alarm[1] = 30;

//character talks
alarm[2] = game_get_speed(gamespeed_fps) * 60 * 1;

//Happiness goes up when hunger is full
alarm[3] = 60*20;

