function seq_bath_happy() 
{
    
    //sequence_instance = sequence_get(seq_bath);
    ////change sprite
    //happy_sprite = $"spr_{global.game.current_pet_type}_happy";
    //pet_happy_sprite = asset_get_index(happy_sprite);
    //get_pet = sequence_get_objects(sequence_instance);
    //show_debug_message($"pet is {get_pet[0]}")
    //get_pet[0].sprite = pet_happy_sprite;
    obj_pet_parent.happy = true;
    
    global.game.happiness = min(global.game.happiness + 5, 20);
}



function seq_bath_leave()
{
    obj_pet_parent.happy = false;
    obj_pet_parent.can_walk = false;
    idle_sprite = $"spr_{global.game.current_pet_type}_base";
    pet_idle_sprite = asset_get_index(idle_sprite);
    //change sprite
}



function seq_bath_destroy()
{
    obj_pet_parent.can_walk = true;
    obj_pet_parent.happy = false;
    sequence_destroy(sequence_get(seq_bath));
}



function seq_bath_goback()
{
    room_goto(rm_main);
}



function seq_bath_begin()
{
    obj_pet_parent.can_walk = false;
    obj_pet_parent.walking = false;
}



function seq_bath_happy2()
{
    obj_pet_parent.happy = true;
}