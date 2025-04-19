draw_set_font(fnt_Quicksand);
draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_text((x + margin), y, string("Corns Owned: ") + string(round(global.game.corns)));

draw_text((x + h_spacing), y, string("Player Name: ") + string(global.game.ownername));

draw_text((x + h_spacing * 2), y, string("Pet Type: ") + string(global.game.current_pet_type));

//Hunger Bar
var _hunger = string("Hunger: ") + string(round(global.game.hunger));
draw_text((x + margin), (y + v_spacing), _hunger);
draw_rectangle((x + bar_spacing), (y + v_spacing), (x + bar_spacing + max(0,(bar_width*(global.game.hunger/20)))), (y + v_spacing + bar_height), 0);
draw_rectangle((x + bar_spacing), (y + v_spacing), (x + bar_spacing + bar_width), (y + v_spacing + bar_height), 1);

//Happiness Bar
var _happiness = string("Happy: ") + string(round(global.game.happiness));
draw_text((x + margin), (y + v_spacing * 2), _happiness);
draw_rectangle((x + bar_spacing), (y + v_spacing * 2), (x + bar_spacing + max(0,(bar_width*(global.game.happiness/20)))), ((y + v_spacing * 2) + bar_height), 0);
draw_rectangle((x + bar_spacing), (y + v_spacing * 2), (x + bar_spacing + bar_width), ((y + v_spacing * 2) + bar_height), 1);

//Health Bar
var _health = string("Health: ") + string(round(global.game.health));
draw_text((x + margin), (y + v_spacing * 3), _health);
draw_rectangle((x + bar_spacing), (y + v_spacing * 3), (x + bar_spacing + max(0,(bar_width*(global.game.health/20)))), ((y + v_spacing * 3) + bar_height), 0);
draw_rectangle((x + bar_spacing), (y + v_spacing * 3), (x + bar_spacing + bar_width), ((y + v_spacing * 3) + bar_height), 1);

/*

if(room==rm_garden)
{
	draw_text((x + margin), (y + v_spacing), string($"Seed Planted: {obj_garden_plot.plot_seed_type}"));
}