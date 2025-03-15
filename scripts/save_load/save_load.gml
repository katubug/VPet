function save_game() 
{
    
    var _struct = {
        corns: global.corns,
        health: global.health,
        happiness: global.happiness,
        pet_type: global.pet_type
        
    };
    
    var _string = json_stringify(_struct);
    
    var _file = file_text_open_write("save_data.txt");
    
    file_text_write_string(_file, _string);
    
    file_text_close(_file);
}
function load_game()
{
    if (file_exists("save_data.txt")){
        
        var _file = file_text_open_read("save_data.txt");
        
        var _json = file_text_read_string(_file);
        
        var _struct = json_parse(_json);
        
        global.corns = _struct.corns;
        global.health = _struct.health;
        global.happiness = _struct.happiness;
        global.pet_type  = _struct.pet_type;
        
        file_text_close(_file);
    }
}