speed = -20 * global.speed_modifier;

if (x < -100){
    instance_destroy();
}

if (obj_runner_dino.gameover == true){
    image_speed = 0;
}