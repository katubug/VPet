/*with(game_controller_object) {
list_inventory = ds_list_create();

}*/

randomize();

//global.inventory = list_inventory;
//access with global.pet.joy++ etc
global.game = {
    ownername: "Bub",
    living: 1,
    corns: 100,
    hunger: 20,
    health: 20,
    happiness: 20,
}
global.pet = {
    joy: 0,
    nonsense: 0,
    selfesteem: 0,
    enthusiasm: 0,
};
alarm[0] = 30;
