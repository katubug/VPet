target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;
pet_talking = false;
eating = false;
sad = false;
happy = false;
walking = false;
can_walk = true;
bath_time = true;
//set idle sprite
idle_sprite = $"spr_{global.game.current_pet_type}_base";
pet_idle_sprite = asset_get_index(idle_sprite);

//set eating sprite
eating_sprite = $"spr_{global.game.current_pet_type}_eat";
pet_eating_sprite = asset_get_index(eating_sprite);

//set walking sprite
walking_sprite = $"spr_{global.game.current_pet_type}_walk";
pet_walking_sprite = asset_get_index(walking_sprite);

//set sad sprite
sad_sprite = $"spr_{global.game.current_pet_type}_sad";
pet_sad_sprite = asset_get_index(sad_sprite);

//set happy sprite
happy_sprite = $"spr_{global.game.current_pet_type}_happy";
pet_happy_sprite = asset_get_index(happy_sprite);

//Need degradation
//TODO should i put this in game controller?
alarm[0] = 60*20;

//Random Walking
alarm[1] = 30;

//character talks
alarm[2] = game_get_speed(gamespeed_fps) * 60 * 1;

//Happiness goes up when hunger is full
alarm[3] = 60*20;

//Alarm 6 is for evolution and is called elsewhere