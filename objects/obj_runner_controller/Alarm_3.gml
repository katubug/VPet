//Game Over Behavior
game_ending = false;
if (runner_score > global.game.high_score_runner){
    global.game.high_score_runner = runner_score;
    new_high_score = true;
}
global.game.corns += runner_score/2;
show_debug_message($"corns owned {global.game.corns}");
input_virtual_destroy_all();

