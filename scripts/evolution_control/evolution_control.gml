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
    
    show_debug_message($"the evolution script is executing the {_phase} phase");
    var _pool = []; //declare empty array
    //populate array with items from the global.pet struct.
    //the "with" functions as a "diy closure" so that the local variables are accessible. 
    //I don't fully understand this but here's the link: https://yal.cc/gamemaker-diy-closures/
    with ({_pool}) struct_foreach(global.pet, function(_stat) {
        array_push(_pool, _stat);
    });
    
    //then this sorts the array by the value of each stat
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
       }
       else {
             pet_evolution = "goot";
             global.game.evolution_phase = "teen";
             global.game.current_pet_type = "goot";
       }
   }
    
    if (_phase = "adult"){
       if (_second_highest == "joy" && _lowest == "enthusiasm") {
           pet_evolution = "chomly";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "chomly";
       }
       if (_second_highest == "nonsense" && _lowest == "enthusiasm") {
           pet_evolution = "froodle";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "froodle";
       }
       if (_second_highest == "enthusiasm" && _lowest =="joy") {
           pet_evolution = "grimble";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "grimble";
       }
       if (_second_highest == "enthusiasm" && _lowest =="nonsense") {
           pet_evolution = "tibb";
           global.game.evolution_phase = "adult";
           global.game.current_pet_type = "grimble";
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
        }
         else {
             pet_evolution = "merm";
             global.game.evolution_phase = "teen";
             global.game.current_pet_type = "merm";
        }
    }

    if (_phase = "adult"){

       if (_second_highest == "joy" && _lowest == "selfesteem") {
            pet_evolution = "bedapy_crinoga";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "bedapy_crinoga";
       }
       if (_second_highest == "enthusiasm" && _lowest == "selfesteem") {
            pet_evolution = "gluft";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "gluft";
       }
       if (_second_highest == "selfesteem" && _lowest =="enthusiasm") {
            pet_evolution = "homma";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "homma";
       }
       if (_second_highest == "enthusiasm" && _lowest =="joy") {
            pet_evolution = "teemb";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "teemb";
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
       }
       else {
            pet_evolution = "yorge";
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "yorge";
       }
    }

    if (_phase = "adult"){
       if (_second_highest == "selfesteem" && _lowest == "nonsense"){
            pet_evolution = "balbio";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "balbio";
        }
       if (_second_highest == "enthusiasm" && _lowest == "nonsense"){
            pet_evolution = "chimchee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "chimchee";
        }
       if (_second_highest == "nonsense" && _lowest == "enthusiasm"){
            pet_evolution = "elboo";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "elboo";
        }
       if (_second_highest == "nonsense" && _lowest == "selfesteem"){
            pet_evolution = "nabafee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "nabafee";
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
        }
        else {
            pet_evolution = "teru";
            global.game.evolution_phase = "teen";
            global.game.current_pet_type = "teru";
        }
    }

   if (_phase = "adult"){
   
       if (_second_highest == "selfesteem" && _lowest == "joy") {
            pet_evolution = "blinko";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "blinko";
        }
       if (_second_highest == "joy" && _lowest == "selfesteem") {
            pet_evolution = "clup";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "clup";
        }
       if (_second_highest == "nonsense" && _lowest == "joy") {
            pet_evolution = "slof";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "slof";
        }
       if (_second_highest == "joy" && _lowest == "nonsense") {
            pet_evolution = "teedee";
            global.game.evolution_phase = "adult";
            global.game.current_pet_type = "teedee";
       }
    } 
}
}