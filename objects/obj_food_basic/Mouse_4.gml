if (global.game.hunger < 20){
    global.game.hunger++;
    global.inventory.item_subtract("Lemon", 1);
}