/// @description Return to inventory room after animation

// Clean up and return
obj_pet_parent.eating = false;
instance_destroy();
room_goto(return_room);