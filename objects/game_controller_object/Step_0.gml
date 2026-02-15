

if(global.game.health <= 0)
{
    global.game.living = false;
}

if(room != rm_death && global.game.living = false)
{
    room_goto(rm_death);
}

//Check for evolution
does_evolve();

