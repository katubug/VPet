if file_exists("save_data.txt"){
   var _data = load_game("save_data.txt");
   show_debug_message(_data);
   global.game = _data.game;
   global.pet = _data.pet;
   //global.game.session_time = 0;

date_time();
}