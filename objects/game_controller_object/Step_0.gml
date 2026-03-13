

if(global.game.health <= 0)
{
    global.game.living = false;
}

if(room != rm_death && global.game.living == false)
{
    if (global.game.limbo == 0){
    room_goto(rm_death);}
}

//Check for evolution
if(global.game.living != false){
does_evolve();
}

