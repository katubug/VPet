if (room == rm_shop){
    global.pantry.item_add("Bibo", 1, obj_food_bibo, spr_food_bibo, 1);
    show_debug_message($"Now buying bibo. Bibo are now {global.pantry.item_amount("Bibo")}");
}