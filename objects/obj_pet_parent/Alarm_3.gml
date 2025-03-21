
if(global.game.happiness >= 0)
{
	if(global.game.hunger >= 10)
{
	global.game.health = min(global.game.health+1,20);
}
}

alarm_set(3, 60*20);