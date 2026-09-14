new_high_score = false;
runner_score = 0;

global.speed_modifier = 1;

button_width = 25;   // 100 ÷ 4 — width of each virtual button
button_height = 12;  // 50 ÷ 4 — height of each virtual button
jump_button_x = 40;  // 160 ÷ 4 — x position of the jump button
button_y = 115;      // 460 ÷ 4 — y position of both buttons
crouch_button_x = jump_button_x + button_width + 5; // 5px gap between buttons
game_ending = false;

alarm[0] = game_get_speed(gamespeed_fps) * 3;
alarm[1] = game_get_speed(gamespeed_fps) * 2;
alarm[2] = game_get_speed(gamespeed_fps) * 3;

vb_jump = input_virtual_create()
    .rectangle(jump_button_x, button_y, jump_button_x + button_width, button_y + button_height)
    .button("accept");

vb_crouch = input_virtual_create()
    .rectangle(crouch_button_x, button_y, crouch_button_x + button_width, button_y + button_height)
    .button("special");

