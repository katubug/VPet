draw_set_font(fnt_Quicksand);
draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_text((x + margin), y, string("Corns Owned: ") + string(round(global.game.corns)));

draw_text((x + h_spacing), y, string("Player Name: ") + string(global.game.ownername));

draw_text((x + h_spacing * 2), y, string("Pet Type: ") + string(global.game.current_pet_type));

//Health Bar
var _health = string("Health: ") + string(round(global.game.health));
var _health_spacing = string_length(_health) + margin;
draw_text((x + margin), (y + v_spacing), _health);
draw_rectangle((x + _health_spacing), (y + v_spacing), (x + _health_spacing + (bar_width*(global.game.health/20))), (y + v_spacing + bar_height), 0);
draw_rectangle((x + _health_spacing), (y + v_spacing), (x + _health_spacing + bar_width), (y + v_spacing + bar_height), 1);

/*
draw_text((x + margin), (y + spacing * 2), string("Hunger: ") + string(round(global.game.hunger)));
draw_rectangle((x + 100), (y + 50), (x + 100+(200*(global.game.hunger/20))), (y + 70), 0);

draw_text((x + margin), (y + spacing * 3), string("Happy: ") + string(round(global.game.happiness)));
draw_rectangle((x + 100), (y + 80), (x + 100+(200*(global.game.happiness/20))), (y + 100), 0);

if(room==rm_garden)
{
	draw_text((x + margin), (y + v_spacing), string($"Seed Planted: {obj_garden_plot.plot_seed_type}"));
}