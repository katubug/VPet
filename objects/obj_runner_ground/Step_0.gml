speed = -5 * global.speed_modifier; // 20 ÷ 4 = 5 — ground scroll speed

if (!obj_runner_dino.gameover){
    if (x < -12){ // 50 ÷ 4 ≈ 12 — wrap threshold
        randomize();
        var number = irandom(10);
        
        //20% of the time
        if (number <= 1){
            image_index = 4;
        } else if (number > 1 && number <= 4 ) {
            image_index = choose(1, 2, 3);
        } else {
            image_index = 0;
        }
        
        image_speed = 0;
        
        move_wrap(true, false, sprite_get_width(sprite_index));
} 
}