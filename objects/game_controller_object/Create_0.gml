with(game_controller_object) {
list_inventory = ds_list_create();

}

randomize();

global.inventory = list_inventory;
global.petIsDead = 0;
//access with global.pet.joy++ etc
global.pet = {
    ownername: "Bub",
    living: 1,
    corns: 100,
    hunger: 20,
    health: 20,
    happiness: 20,
    joy: 0,
    nonsense: 0,
    selfesteem: 0,
    enthusiasm: 0,
};
