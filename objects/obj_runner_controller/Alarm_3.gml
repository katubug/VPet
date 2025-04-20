//Game Over Behavior
if (score > runner_high_score){
     runner_high_score = score;
    new_high_score = true;
}
global.game.corns = score/2;
score = 0;
