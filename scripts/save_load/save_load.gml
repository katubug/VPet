/*function save_game() 
{
    
    var _struct = {
        corns: global.corns,
        health: global.health,
        happiness: global.happiness,
        pet_type: global.pet_type,
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
    }*/
    //----------------------------------------------------------------
    function save_game(_struct, _filename) {
    // We stringify the struct itself into JSON formatting
    var _json = json_stringify(_struct);
    // We get the size of our stringified struct, in raw bytes
    var _size = string_byte_length(_json);
    // We create a buffer to store our string
    var _buff = buffer_create(_size, buffer_fixed, 1);
    // We write to our buffer with the whole string
    buffer_write(_buff, buffer_text, _json);
    // We then save it
    buffer_save(_buff, _filename);
    // And just a bit of a cleanup, by freeing the buffer!
    buffer_delete(_buff);
    }
    
    function load_game(_filename) {
    // We load in the file
    var _buff = buffer_load(_filename);
    // We get the json from the buffer
    var _json = buffer_read(_buff, buffer_text);
    // We free the buffer, since we don't need it now. As we've extracted the whole string
    buffer_delete(_buff);
    // We convert the json into a struct
    var _struct = json_parse(_json);
    // We then return it as a handle
    return _struct;
    }
