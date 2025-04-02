if (instance_number(obj_clutter_parent) >= 1){
    var clutter_amount = instance_number(obj_clutter_parent);
    clutter_happiness(clutter_amount);
    global.game.clutter_exists = true;
}
alarm[2] = 60*20;