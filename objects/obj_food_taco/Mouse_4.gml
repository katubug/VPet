if (room == rm_shop){
    //Add name, quantity, associated object, sprite, then hunger restored
    global.pantry.item_add("Taco", 1, obj_food_taco, spr_btn_taco, 1);
    show_debug_message($"Now buying Taco. Tacos are now {global.pantry.item_amount("Taco")}");
}