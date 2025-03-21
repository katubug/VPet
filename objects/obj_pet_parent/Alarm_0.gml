if(global.game.hunger > 0)
{
	global.game.hunger = max(global.game.hunger-1,0);
}

else
{
	global.game.health += -1;
}

if(global.game.happiness > 0)
{
    
	global.game.happiness = max(global.game.happiness-1,0);

}

alarm_set(0, 60*20);