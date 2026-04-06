randomize();

global.game = {
	struct_version: 0.4,
	ownername: "",
	living: 1,
    limbo:0,
	corns: 100,
	hunger: 20,
	health: 20,
	happiness: 20,
	clutter_exists: false,
	year: current_year,
	month: current_month,
	day: current_day,
	hour: current_hour,
	minute: current_minute,
	second: current_second,
	//because current time is in milliseconds, we divide it by 1000 to change it to seconds
	session_time: (current_time / 1000),
	previous_total_time: 0,
	running_time: 0,
	banked_time: 0,
	last_saved_time: 0,
	evolution_phase: "egg", // Start as an egg before the baby stage
	petname: "",           // Name given to the pet after hatching
	gender: "",            // "boy" or "girl", set randomly at hatch
	current_pet_type: "",
	evolution_queued: 1,
	previous_pet_type: "",
	garden_plots: [], // 9-element array, populated below after struct init
    high_score_runner: 0,
    high_score_buttonmash: 0, // High score for the button mash minigame
    generation: 1,            // Which generation this pet is — always 1 for now, expand later
    pet_age_days: 0,          // Age of the pet in days — calculated/set elsewhere, placeholder for now
    thirst: 10,               // Thirst stat (0–20) — system not implemented yet, starts at mid-value
};

// Initialize 9 garden plots (3x3 grid) — index 0 to 8
for (var _gi = 0; _gi < 9; _gi++) {
    array_push(global.game.garden_plots, {
        seed_type:     "none", // "none" or item id e.g. "tomato_seed"
        plant_time:    -1,     // epoch seconds when planted (-1 = empty)
        water_time:    -1,     // epoch seconds of last watering (-1 = never)
        bonus_seconds: 0,      // accumulated bonus seconds from expired watering windows
    });
}

var _base = 86400; //86400 = 24 hours in seconds 
global.game.evolution_time = {
	base: _base,
	egg: 45,           // Egg lasts 45 seconds — edit this to change egg duration
	child: (_base / 2),
	teen: (_base * 2),
	adult: (_base * 3),
};

global.pet = {
	joy: 0,
	nonsense: 0,
	selfesteem: 0,
	enthusiasm: 0,
};

// Watering mode toggle — set true when the player activates the watering can in the garden
// Plots check this to decide whether a click should water or harvest
global.garden_watering_mode = false;

// Flag used by obj_dialog_modal to block input on the rest of the game.
// Any object whose input should freeze during a dialog should guard its
// input code with: if (!global.dialog_open) { ... }
global.dialog_open = false;

starter_pet = irandom_range(0, 2);
if (global.game.current_pet_type == "") {
	if (starter_pet == 0) global.game.current_pet_type = "chobo";
	if (starter_pet == 1) global.game.current_pet_type = "pomba";
	if (starter_pet == 2) global.game.current_pet_type = "dodati";
}