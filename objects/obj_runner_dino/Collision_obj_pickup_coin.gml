if (!coin_cooldown){
    coin_cooldown = true;
    obj_runner_controller.runner_score +=5;
    audio_play_sound(snd_coin_1, 1, false); // play coin sound once per pickup
    alarm[2] = 15;
}