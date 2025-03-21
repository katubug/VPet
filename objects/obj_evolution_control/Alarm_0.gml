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
    
    if (evolution_phase = "child"){
                pet_evolution = "gnart";
            }
        
    if (evolution_phase = "teen"){
            if (global.pet.joy > global.pet.nonsense) pet_evolution = "vleesh"; 
                else pet_evolution = "goot";
            }
    
    if (evolution_phase = "adult"){
       //chomly: joy, -enthu
       //froodle: nonsense, -enthu
       //grimble: enthu, -joy
       //tibb: enthu, -nonsense
    if (_second_highest == "joy" && _lowest == "enthusiasm") pet_evolution = "chomly";
    if (_second_highest == "nonsense" && _lowest == "enthusiasm") pet_evolution = "froodle";
    if (_second_highest == "enthusiasm" && _lowest =="joy") pet_evolution = "grimble";
    if (_second_highest == "enthusiasm" && _lowest =="nonsense") pet_evolution = "tibb";
    }
}

if (_highest == "nonsense"){
    
    if (evolution_phase = "child"){
            pet_evolution = "plang";
        }
    
    if (evolution_phase = "teen"){
        if (global.pet.enthusiasm > global.pet.selfesteem) pet_evolution = "blertrand"; 
                        else pet_evolution = "merm";
        }
        
    if (evolution_phase = "adult"){
       //bedapy crinoga: joy, -self
       //gluft: enthu, -self
       //homma: self, -enthu
       //teemb: enthu, -joy
    
    if (_second_highest == "joy" && _lowest == "selfesteem") pet_evolution = "bedapy_crinoga";
    if (_second_highest == "enthusiasm" && _lowest == "selfesteem") pet_evolution = "gluft";
    if (_second_highest == "selfesteem" && _lowest =="enthusiasm") pet_evolution = "homma";
    if (_second_highest == "enthusiasm" && _lowest =="joy") pet_evolution = "teemb";
    }
}
if (_highest == "joy"){
    
    if (evolution_phase = "child"){
            pet_evolution = "looma";
        }
    
    if (evolution_phase = "teen"){
        if (global.pet.enthusiasm > global.pet.nonsense) pet_evolution = "moof"; 
                        else pet_evolution = "yorge";
        }
    
    if (evolution_phase = "adult"){
      //balbio: self, -nonsense
      //chimchee: enthu, -nonsense
      //elboo: nonsense, -enthu
      //nabafee: nonsense, -self

    if (_second_highest == "selfesteem" && _lowest == "nonsense") pet_evolution = "balbio";
    if (_second_highest == "enthusiasm" && _lowest == "nonsense") pet_evolution = "chimchee";
    if (_second_highest == "nonsense" && _lowest == "enthusiasm") pet_evolution = "elboo";
    if (_second_highest == "nonsense" && _lowest == "selfesteem") pet_evolution = "nabafee";
    }
}

if (_highest == "enthusiasm"){
    
    if (evolution_phase = "child"){
            pet_evolution = "phil";
        }
    
    if (evolution_phase = "teen"){
        if (global.pet.joy > global.pet.selfesteem) pet_evolution = "pleh"; 
                        else pet_evolution = "teru";
        }
    
    if (evolution_phase = "adult"){
       //blinko: self, -joy
       //clup: joy, -self
       //slof: nonsense, -joy
       //teedee: joy, -nonsense

    if (_second_highest == "selfesteem" && _lowest == "joy") pet_evolution = "blinko";
    if (_second_highest == "joy" && _lowest == "selfesteem") pet_evolution = "clup";
    if (_second_highest == "nonsense" && _lowest == "joy") pet_evolution = "slof";
    if (_second_highest == "joy" && _lowest == "nonsense") pet_evolution = "teedee";
    }
}

    
    /* this accesses the value of each value in the pool
    var _highest = global.pet[$ _pool[0]];
    var _second_highest = global.pet[$ _pool[1]];
    var _lowest = global.pet[$ _pool[3]];
    */