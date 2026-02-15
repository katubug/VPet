//Every minute, we will:

//Set the session time to the current seconds played.
global.game.session_time = (current_time/1000);


show_debug_message($"session time is currently: {global.game.session_time} but only {global.game.last_saved_time} since last save.");
show_debug_message($"total banked time is currently: {global.game.banked_time}");
show_debug_message($"total previous time from this session is: {global.game.previous_total_time}");

//Set the running time variable to the previous total time plus the session time

if (global.game.last_saved_time != 0){
    global.game.running_time = (global.game.previous_total_time + global.game.last_saved_time);
    show_debug_message($"that means current total time is {global.game.running_time}");
}  else {
    global.game.running_time = (global.game.previous_total_time + global.game.session_time);
    show_debug_message($"that means current total time is {global.game.running_time}");
}

// Then reset the alarm
alarm[0] = 60 * 20;