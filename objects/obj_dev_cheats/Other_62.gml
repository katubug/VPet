/// @description Handle async dialog result (name editing via get_string_async)

var _status = ds_map_find_value(async_load, "status"); // 1 = OK pressed, 0 = cancelled
var _str = ds_map_find_value(async_load, "string");    // the text the user typed

if (_status == 1 && async_target != "") {
    // Apply the new name to the correct field based on which one was being edited
    if (async_target == "ownername") {
        global.game.ownername = _str;                  // update player name
    }
    if (async_target == "petname") {
        global.game.petname = _str;                    // update pet name
    }
    pre_save();                                         // persist the change to disk
}

async_target = "";                                      // clear the tracking variable regardless of outcome
