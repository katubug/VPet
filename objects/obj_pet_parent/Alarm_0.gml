if(global.game.hunger > 0)
{
	global.game.hunger = max(global.game.hunger-1,0);
    show_debug_message($"hunger is now {global.game.hunger}");
}

else
{
	global.game.health += -1;
    show_debug_message($"hunger is empty so health is now {global.game.health}");
}

if(global.game.happiness > 0)
{
    
	global.game.happiness = max(global.game.happiness-1,0);
    show_debug_message($"happiness is now {global.game.happiness}");

}

//20 minutes
alarm[0] = game_get_speed(gamespeed_fps) * 60 * 20;