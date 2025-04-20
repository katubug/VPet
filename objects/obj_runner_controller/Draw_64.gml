//input_virtual_debug_draw();
if (!obj_runner_dino.gameover){
draw_sprite(spr_jump_button, 0, jump_button_x, button_y);
draw_sprite(spr_crouch_button, 0, crouch_button_x, button_y)
}


var str_gameover = string("Game Over");
var str_score = string($"Your final score was {score}, you earned {round(score/2)} Corns!");

if (obj_runner_dino.gameover){  
    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
    draw_text(room_width/2, 200, str_gameover);
    draw_text(room_width/2, 230, str_score);
    
    if (new_high_score = true){
    draw_text(room_width/2, 260, "You got a new high score!");
    }
}