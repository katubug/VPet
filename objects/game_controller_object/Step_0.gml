if (input_check_released("pause")){
    show_debug_message("pausing");
    paused = !paused;
    update_pause();
}

var temp_health = global.game.health;

if(temp_health <= 0)
{
    global.game.living = false;
}

if(room != rm_death && global.game.living = false)
{
    room_goto(rm_death);
}

does_evolve();

