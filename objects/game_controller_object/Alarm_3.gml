//Alarm 3 is for evolution and will be activated in the does_evolve() function called in Step
//Set evolution queue to 0 to prevent locking
global.game.evolution_queued = 0;
show_debug_message("evolution is now queued");