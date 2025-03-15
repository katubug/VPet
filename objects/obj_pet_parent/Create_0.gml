target_x = x;
target_y = y;
tilemap = layer_tilemap_get_id("Tiles_Col");
move_speed = 1;

alarm_set(0, 60*20);
alarm_set(1, 30);
alarm_set(3, 60*20);