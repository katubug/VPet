var temp_health = global.health;

if(temp_health <= 0)
{
    global.petIsDead = true;
}

if(room != rm_death && global.petIsDead = true)
{
    room_goto(rm_death);
}