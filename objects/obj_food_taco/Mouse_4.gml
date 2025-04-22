if (room == rm_shop){
    //Add name, quantity, sprite, then hunger restored
    global.pantry.item_add("Taco", 1, spr_btn_taco, 3);
    show_debug_message($"Now buying Taco. Tacos are now {global.pantry.item_amount("Taco")}");
}