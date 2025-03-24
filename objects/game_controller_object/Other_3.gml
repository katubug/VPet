//global.game.session_time = current_time/1000;
//global.game.total_time = global.game.total_time + global.game.session_time;
var _dataToSave = {
    game: global.game,
    pet: global.pet,
};
save_game(_dataToSave, string("save_data.txt"));