runner_high_score = 0;
new_high_score = false;

global.speed_modifier = 1;

button_width = 100;
button_height = 50;
jump_button_x = 160;
button_y = 460
crouch_button_x = jump_button_x + button_width + 20;

alarm[0] = game_get_speed(gamespeed_fps) * 3;
alarm[1] = game_get_speed(gamespeed_fps) * 2;
alarm[2] = game_get_speed(gamespeed_fps) * 3;

vb_jump = input_virtual_create()
    .rectangle(jump_button_x, button_y, jump_button_x + button_width, button_y + button_height)
    .button("accept");

vb_crouch = input_virtual_create()
    .rectangle(crouch_button_x, button_y, crouch_button_x + button_width, button_y + button_height)
    .button("special");

