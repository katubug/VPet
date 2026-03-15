function does_evolve(){
    
    var _time_check = global.game.running_time;
    
    if (global.game.evolution_phase != "none"){
        if (global.game.evolution_phase == "baby"){
                    if (_time_check >= global.game.evolution_time.child){
                        evolution_control("child");
                    }
                }
        if (global.game.evolution_phase == "child"){
                    if (_time_check >= global.game.evolution_time.teen){
                        evolution_control("teen");
                    }
                }
        if (global.game.evolution_phase == "teen"){
                    if (_time_check >= global.game.evolution_time.adult){
                        evolution_control("adult");
                    }
                }
    }
}

function evolution_control(_phase) 
{
    global.game.previous_pet_type = global.game.current_pet_type;
    show_debug_message($"the evolution script is executing the {_phase} phase");
    // hardcode just the 4 stat names so we don't accidentally pull in non-numeric fields
    var _pool = ["nonsense", "selfesteem", "joy", "enthusiasm"];

    // sort the stat names by their numeric values, highest first
    array_sort(_pool, function(_a, _b) {
        return sign(global.pet[$ _b] - global.pet[$ _a]);
    });
    
    //this gets the name of each stat
    var _highest = _pool[0];
    var _second_highest = _pool[1];
    var _lowest = _pool[3];
    
    //show_message($"highest stat is {_highest}");
    
if (_highest == "selfesteem"){
    
   if (_phase = "child"){
        pet_evolution = "gnart";
        global.game.evolution_phase = "child";
        global.game.current_pet_type = "gnart";
        event_perform(ev_alarm, 3);
   }
   
   if (_phase = "teen"){
       if (global.pet.joy > global.pet.nonsense) {
            pet_evolution = "vleesh"; 
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "vleesh";
            event_perform(ev_alarm, 3);
       }
       else {
             pet_evolution = "goot";
             global.game.evolution_phase = "teen";
             global.game.current_pet_type = "goot";
            event_perform(ev_alarm, 3);
       }
   }
    
    if (_phase = "adult"){
       if (_second_highest == "joy" && _lowest == "enthusiasm") {
           pet_evolution = "chomly";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "chomly";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "nonsense" && _lowest == "enthusiasm") {
           pet_evolution = "froodle";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "froodle";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "enthusiasm" && _lowest =="joy") {
           pet_evolution = "grimble";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "grimble";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "enthusiasm" && _lowest =="nonsense") {
           pet_evolution = "tibb";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "grimble";
        event_perform(ev_alarm, 3);
       }
    }
}
    
if (_highest == "nonsense"){

   if (_phase = "child"){
       pet_evolution = "plang";
       global.game.evolution_phase = "child";
       global.game.current_pet_type = "plang";
    event_perform(ev_alarm, 3);
   }

   if (_phase = "teen"){
         if (global.pet.enthusiasm > global.pet.selfesteem) {
             pet_evolution = "blertrand"; 
             global.game.evolution_phase = "teen";
             global.game.current_pet_type = "blertrand";
            event_perform(ev_alarm, 3);
        }
         else {
             pet_evolution = "merm";
             global.game.evolution_phase = "teen";
             global.game.current_pet_type = "merm";
            event_perform(ev_alarm, 3);
        }
    }

    if (_phase = "adult"){

       if (_second_highest == "joy" && _lowest == "selfesteem") {
            pet_evolution = "bedapy_crinoga";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "bedapy_crinoga";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "enthusiasm" && _lowest == "selfesteem") {
            pet_evolution = "gluft";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "gluft";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "selfesteem" && _lowest =="enthusiasm") {
            pet_evolution = "homma";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "homma";
        event_perform(ev_alarm, 3);
       }
       if (_second_highest == "enthusiasm" && _lowest =="joy") {
            pet_evolution = "teemb";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "teemb";
        event_perform(ev_alarm, 3);
       }
    }
}
    
if (_highest == "joy"){

   if (_phase = "child"){
        pet_evolution = "looma";
        global.game.evolution_phase = "child";
        global.game.current_pet_type = "looma";
    event_perform(ev_alarm, 3);
   }

    if (_phase = "teen"){
       if (global.pet.enthusiasm > global.pet.nonsense) {
            pet_evolution = "moof"; 
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "moof";
        event_perform(ev_alarm, 3);
       }
       else {
            pet_evolution = "yorge";
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "yorge";
        event_perform(ev_alarm, 3);
       }
    }

    if (_phase = "adult"){
       if (_second_highest == "selfesteem" && _lowest == "nonsense"){
            pet_evolution = "balbio";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "balbio";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "enthusiasm" && _lowest == "nonsense"){
            pet_evolution = "chimchee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "chimchee";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "nonsense" && _lowest == "enthusiasm"){
            pet_evolution = "elboo";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "elboo";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "nonsense" && _lowest == "selfesteem"){
            pet_evolution = "nabafee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "nabafee";
        event_perform(ev_alarm, 3);
        }
    }
}

if (_highest == "enthusiasm"){

    if (_phase = "child"){
        pet_evolution = "phil";
        global.game.evolution_phase = "child";
        global.game.current_pet_type = "phil";
        event_perform(ev_alarm, 3);
    }

    if (_phase = "teen"){
        if (global.pet.joy > global.pet.selfesteem){ 
            pet_evolution = "pleh"; 
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "pleh";
            event_perform(ev_alarm, 3);
        }
        else {
            pet_evolution = "teru";
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "teru";
            event_perform(ev_alarm, 3);
        }
    }

   if (_phase = "adult"){
   
       if (_second_highest == "selfesteem" && _lowest == "joy") {
            pet_evolution = "blinko";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "blinko";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "joy" && _lowest == "selfesteem") {
            pet_evolution = "clup";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "clup";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "nonsense" && _lowest == "joy") {
            pet_evolution = "slof";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "slof";
        event_perform(ev_alarm, 3);
        }
       if (_second_highest == "joy" && _lowest == "nonsense") {
            pet_evolution = "teedee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "teedee";
        event_perform(ev_alarm, 3);
       }
    } 
}
}