if (room == rm_dev_room){
    draw_text(25, 25, string($"Pet type is {global.game.current_pet_type}"));
    draw_text(25, 30, string($"Self Esteem is: {global.pet.selfesteem}"));
    draw_text(25, 35, string($"Joy is: {global.pet.joy}"));
    draw_text(25, 40, string($"Nonsense is: {global.pet.nonsense}"));
    draw_text(25, 45, string($"Enthusiasm is: {global.pet.enthusiasm}"));
    draw_text(25, 50, string($"Next Life Phase: {global.game.evolution_phase}"));
}
