var temp_health = global.game.health;

if(temp_health <= 0)
{
    global.game.living = false;
}

if(room != rm_death && global.game.living = false)
{
    room_goto(rm_death);
}

//if (input_check_pressed("jump")) room_goto(rm_dev_room);
    