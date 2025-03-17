var temp_health = global.pet.health;

if(temp_health <= 0)
{
    global.pet.living = false;
}

if(room != rm_death && global.pet.living = false)
{
    room_goto(rm_death);
}