//Every minute, we will:

//Set the session time to the current seconds played.
global.game.session_time = (current_time/1000);


show_debug_message($"session time is currently: {global.game.session_time}");
show_debug_message($"total previous time is currently: {global.game.banked_time}");

//Set the running time variable to the banked time plus the session time
global.game.running_time = (global.game.banked_time + global.game.session_time);
show_debug_message($"that means current total time is {global.game.running_time}");

//Then reset the alarm
alarm[0] = 60 * 20;