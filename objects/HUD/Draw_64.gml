draw_text(x + 0, y + 0, string("Corns Owned: ") + string(global.game.corns));

draw_text(x + 0, y + 20, string("Hunger: ") + string(global.game.hunger));

if(room==rm_garden)
{
	draw_text(x + 0, y + 100, string("Seed Planted: ") + string(string(obj_garden_plot.plot_seed_type)));
}