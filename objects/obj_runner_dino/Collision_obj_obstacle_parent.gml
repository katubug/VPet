if (!dino_invincible){
    vspeed =-15;
    hurt = true;
    dino_hp --;
    dino_invincible = true;
    alarm[0] = 1 * game_get_speed(gamespeed_fps)
    alarm[1] = 15;
}