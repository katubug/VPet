if (room == rm_shop){
    global.pantry.item_add("Lemon", "basic", 1, spr_food_basic, 1);
    show_debug_message($"Now buying lemon. Lemons are now {global.pantry.item_amount("Lemon")}");
}