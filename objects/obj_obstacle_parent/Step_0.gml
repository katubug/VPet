speed = -5 * global.speed_modifier; // 20 ÷ 4 = 5 — scroll speed at 180px resolution

if (x < -25){ // destroy once fully offscreen left (100 ÷ 4 = 25)
    instance_destroy();
}

if (obj_runner_dino.gameover == true){
    image_speed = 0;
}