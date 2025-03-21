draw_text(x + 0, y + 0, string("Hunger: ") + string(global.game.hunger));

draw_rectangle(x + 0, y + 20, x + 0+(200*(global.game.hunger/20)), y + 40, 0);