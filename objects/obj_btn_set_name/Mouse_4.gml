if (!obj_initial_setup.typing_allowed) obj_initial_setup.typing_allowed = 1;
    
else {
    obj_initial_setup.typing_allowed = 0;
    obj_initial_setup.playername = keyboard_string;
    global.game.ownername = obj_initial_setup.playername;
}