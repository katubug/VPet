randomize();

global.game = {
	struct_version: 0.4,
	ownername: "",
	living: 1,
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
	evolution_phase: "baby",
	current_pet_type: "",
	evolution_queued: 1,
	previous_pet_type: "",
	garden: {
		seed_planted: "",
		growth_time: 0,
		watered: 0,
	},
    high_score_runner: 0,
};

var _base = 86400; //86400 = 24 hours in seconds 
global.game.evolution_time = {
	base: _base,
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

starter_pet = irandom_range(0, 2);
if (global.game.current_pet_type == "") {
	if (starter_pet == 0) global.game.current_pet_type = "chobo";
	if (starter_pet == 1) global.game.current_pet_type = "pomba";
	if (starter_pet == 2) global.game.current_pet_type = "dodati";
}