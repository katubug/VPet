function save_game() 
{
    var _file = file_text_open_write("save_data.txt");
    file_text_write_string(_file, "uwu please no hacky")
    file_text_write_real(_file, global.corns);
}
function load_game()
{
    
}