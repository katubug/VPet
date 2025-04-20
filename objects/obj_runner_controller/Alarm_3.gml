//Game Over Behavior
game_ending = false;
if (score > global.game.high_score_runner){
    global.game.high_score_runner = score;
    new_high_score = true;
}
global.game.corns += score/2;

