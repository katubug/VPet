//input_virtual_debug_draw();
if (!obj_runner_dino.gameover){
draw_sprite(spr_jump_button, 0, jump_button_x, button_y);
draw_sprite(spr_crouch_button, 0, crouch_button_x, button_y)
}


var str_gameover = string("Game Over");
var str_score = string($"Your final score was {runner_score}, you earned {round(runner_score/2)} Corns!");

if (obj_runner_dino.gameover){  
    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
    var _gw = display_get_gui_width(); // use GUI width instead of room_width for Draw_64
    draw_text(_gw / 2, 50, str_gameover);
    draw_text(_gw / 2, 58, str_score);

    if (new_high_score = true){
    draw_text(_gw / 2, 65, "You got a new high score!");
    }
}