function pre_save(){
    //Ensure we save the end-of-session date and time so they can be properly calculated on load.
    save_date();
    
    _new_time = (global.game.session_time - global.game.last_saved_time);
    
    //Bank the previous total time played.
    global.game.banked_time = (global.game.previous_total_time + _new_time);
    
    show_debug_message($"banking previous total time ({global.game.previous_total_time}) plus current session time since last save ({_new_time}), equalling {global.game.banked_time}");
    //Reset previous time to zero because all that time is banked now.
    global.game.previous_total_time = global.game.banked_time;
    
    //Reset the last-saved current time to right now
    global.game.last_saved_time = (current_time/1000);
    
    //Then get ready to save
    var _dataToSave = {
        game: global.game,
        pet: global.pet,
    };
    
    //And then save.
    save_game(_dataToSave, string("save_data.txt"));
}

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
    
function pre_load(){
    //Check if there's a save file
    if file_exists("save_data.txt"){
        
    //load the save data into a variable
    var _data = load_game("save_data.txt");
    
    //parse that data into our global variables
    global.game = _data.game;
    global.pet = _data.pet; 
        
    //Reset the session time and the last saved time to the current session
    show_debug_message($"Previous game session time was {global.game.session_time} seconds. Setting to 0 now.")
    global.game.session_time = 0;
    global.game.last_saved_time = 0;
        
    //Do date/time function to calculate elapsed time plus banked time, and to set both banked and 
    //previous total times.
    date_time();
    }
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
