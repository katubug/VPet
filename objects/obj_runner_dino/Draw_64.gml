if (!obj_runner_dino.gameover){
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_text(2, 2, $"Lives: {dino_hp}");
    draw_text(2, 8, $"Score: {obj_runner_controller.runner_score}");
    draw_text(2, 15, $"High Score: {global.game.high_score_runner}");
}