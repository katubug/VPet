draw_text(x + 0, y + 0, string("Health: ") + string(global.pet.health));

draw_rectangle(x + 0, y + 20, x + 0+(200*(global.pet.health/20)), y + 40, 0);