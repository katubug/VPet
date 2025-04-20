if (!obj_runner_dino.gameover){
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_text(10,10, $"Lives: {dino_hp}");
    draw_text(10,30, $"Score: {score}");
    draw_text(10,60, $"High Score: {global.game.high_score_runner}");
}