if (!dino_invincible){
    vspeed =-15;
    hurt = true;
    audio_play_sound(snd_ouch, 1, false); // play hurt sound once per hit
    dino_hp --;
    dino_invincible = true;
    alarm[0] = 1 * game_get_speed(gamespeed_fps)
    alarm[1] = 15;
}