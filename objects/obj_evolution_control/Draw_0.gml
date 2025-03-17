if (pet_evolution == 0){
    draw_text(100, 100, string("Pet evolution is null."));
    draw_text(100, 120, string($"Self Esteem is: {global.pet.selfesteem}"));
    draw_text(100, 140, string($"Joy is: {global.pet.joy}"));
    draw_text(100, 160, string($"Nonsense is: {global.pet.nonsense}"));
    draw_text(100, 180, string($"Enthusiasm is: {global.pet.enthusiasm}"));
}
else {
    draw_text(100, 100, string($"Pet evolution is {pet_evolution}"));
    draw_text(100, 120, string($"Self Esteem is: {global.pet.selfesteem}"));
    draw_text(100, 140, string($"Joy is: {global.pet.joy}"));
    draw_text(100, 160, string($"Nonsense is: {global.pet.nonsense}"));
    draw_text(100, 180, string($"Enthusiasm is: {global.pet.enthusiasm}"));
}