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

function stat_init_touch()
{
    global.pet.touch_counter = 0;                                       // ticks up on every stat change; lets me break ties by recency without depending on real time
    global.pet.touched = { nonsense: 0, selfesteem: 0, joy: 0, enthusiasm: 0 }; // last touch_counter value per stat; higher = more recently changed
}

// EVERY hidden stat change must go through this or the tie rule won't know about it
function stat_add(_stat, _amount)
{
    global.pet[$ _stat] += _amount;                                     // apply the change (negative amounts work too, for curses)
    global.pet.touch_counter += 1;                                      // bump the counter so this touch is newer than any previous one
    global.pet.touched[$ _stat] = global.pet.touch_counter;             // stamp this stat as the most recently touched
}

function evolution_control(_phase)
{
    global.game.previous_pet_type = global.game.current_pet_type;       // remember what we were so the evolution screen can show before/after
    show_debug_message($"the evolution script is executing the {_phase} phase"); // debug breadcrumb

    // ---- 1. rank the four hidden stats ----
    var _pool = ["nonsense", "selfesteem", "joy", "enthusiasm"];        // hardcoded so I never accidentally sort a non-numeric field on global.pet

    array_sort(_pool, function(_a, _b) {
        var _diff = global.pet[$ _b] - global.pet[$ _a];                // positive means b is bigger, so b sorts first (highest first)
        if (_diff != 0) return sign(_diff);                             // values differ: normal highest-first sort
        return sign(global.pet.touched[$ _b] - global.pet.touched[$ _a]); // tied: the more recently touched stat wins the spot
    });

    var _highest        = _pool[0];                                     // name of the top stat
    var _second_highest = _pool[1];                                     // name of the runner-up
    var _lowest         = _pool[3];                                     // name of the bottom stat (index 2 is unused by design)

    // ---- 2. lookup tables ----
    // to rename a form, edit the string; to change which stats produce it, edit the key

    // child: keyed by highest stat only
    static _child_table = {
        enthusiasm: "phil",
        selfesteem: "gnart",
        joy:        "looma",
        nonsense:   "plang"
    };

    // teen: keyed by highest stat -> [partner stat, form if second-highest == partner, form otherwise]
    static _teen_table = {
        selfesteem: ["joy",        "vleesh",    "goot"],
        nonsense:   ["enthusiasm", "blertrand", "merm"],
        joy:        ["enthusiasm", "moof",      "yorge"],
        enthusiasm: ["joy",        "pleh",      "teru"]
    };

    // adult: keyed by "highest_second_lowest" -> form. all 24 signatures covered, so nothing can fall through
    static _adult_table = {
        // self-esteem highest
        selfesteem_joy_enthusiasm:        "chomly",
        selfesteem_joy_nonsense:          "placeholder1",
        selfesteem_nonsense_enthusiasm:   "froodle",
        selfesteem_nonsense_joy:          "placeholder2",
        selfesteem_enthusiasm_joy:        "grimble",
        selfesteem_enthusiasm_nonsense:   "tibb",
        // nonsense highest
        nonsense_joy_selfesteem:          "bedapy_crinoga",
        nonsense_joy_enthusiasm:          "placeholder3",
        nonsense_selfesteem_enthusiasm:   "homma",
        nonsense_selfesteem_joy:          "placeholder4",
        nonsense_enthusiasm_selfesteem:   "gluft",
        nonsense_enthusiasm_joy:          "teemb",
        // joy highest
        joy_selfesteem_nonsense:          "balbio",
        joy_selfesteem_enthusiasm:        "placeholder5",
        joy_enthusiasm_nonsense:          "chimchee",
        joy_enthusiasm_selfesteem:        "placeholder6",
        joy_nonsense_enthusiasm:          "elboo",
        joy_nonsense_selfesteem:          "nabafee",
        // enthusiasm highest
        enthusiasm_selfesteem_joy:        "blinko",
        enthusiasm_selfesteem_nonsense:   "placeholder7",
        enthusiasm_joy_selfesteem:        "clup",
        enthusiasm_joy_nonsense:          "teedee",
        enthusiasm_nonsense_joy:          "slof",
        enthusiasm_nonsense_selfesteem:   "placeholder8"
    };

    // ---- 3. pick the form for this phase ----
    var _form = undefined;                                              // stays undefined if something is badly wrong, which I catch below

    switch (_phase)
    {
        case "child":
            _form = _child_table[$ _highest];                           // child only cares about the top stat
            break;

        case "teen":
            var _row = _teen_table[$ _highest];                         // grab the row for whichever stat came out on top
            _form = (_second_highest == _row[0]) ? _row[1] : _row[2];   // partner stat came second? first form, otherwise second form
            break;

        case "adult":
            var _key = $"{_highest}_{_second_highest}_{_lowest}";       // build the signature key, e.g. "joy_nonsense_selfesteem"
            _form = _adult_table[$ _key];                               // straight lookup; every one of the 24 keys exists
            break;
    }

    // ---- 4. sanity check ----
    if (_form == undefined)                                             // only possible with a bad _phase string or a typo in a table key
    {
        show_debug_message($"evolution_control: no form found for phase '{_phase}' with stats {_highest}/{_second_highest}/{_lowest}"); // loud failure beats a silent non-evolution
        return;                                                         // bail without touching game state so the pet just stays as it is
    }

    // ---- 5. apply ----
    pet_evolution = _form;                                              // the form the evolution animation will play
    global.game.evolution_phase = _phase;                               // record which phase we just entered
    global.game.current_pet_type = _form;                               // keep current type in sync with the chosen form
    event_perform(ev_alarm, 3);                                         // kick off the evolution alarm as before
}