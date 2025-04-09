draw_text(x + 0, y + 0, string("Corns Owned: ") + string(round(global.game.corns)));

draw_text(x + 300, y + 0, string("Player Name: ") + string(global.game.ownername));

draw_text(x + 500, y + 0, string("Pet Type: ") + string(global.game.current_pet_type));


if(room==rm_garden)
{
	draw_text(x + 0, y + 400, string($"Seed Planted: {obj_garden_plot.plot_seed_type}"));
}

draw_text(x + 0, y + 20, string("Health: ") + string(round(global.game.health)));
draw_rectangle(x + 100, y + 20, x + 100+(200*(global.game.health/20)), y + 40, 0);

draw_text(x + 0, y + 50, string("Hunger: ") + string(round(global.game.hunger)));
draw_rectangle(x + 100, y + 50, x + 100+(200*(global.game.hunger/20)), y + 70, 0);

draw_text(x + 0, y + 80, string("Happy: ") + string(round(global.game.happiness)));
draw_rectangle(x + 100, y + 80, x + 100+(200*(global.game.happiness/20)), y + 100, 0);