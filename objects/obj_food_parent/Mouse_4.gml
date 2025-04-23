if (room == rm_shop){
    global.pantry.item_add("Lemon", 1, obj_food_basic, spr_food_basic, 1);
    show_debug_message($"Now buying lemon. Lemons are now {global.pantry.item_amount("Lemon")}");
}