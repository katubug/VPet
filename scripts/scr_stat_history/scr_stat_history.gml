/// @description Personality stat history tracking scaffold
/// Tracks the source of every personality stat change for debugging and dev tools.
/// Not saved to disk yet — resets each session.

/// @function stat_history_init()
/// @description Creates the global.stat_history struct. Call once from global_values.gml.
function stat_history_init() {
	global.stat_history = {
		joy: [],          // array of { source: "tomato_soup", amount: 2, time: current_time }
		nonsense: [],     // each entry records what changed the stat, by how much, and when
		selfesteem: [],
		enthusiasm: [],
	};
}

/// @function stat_history_log(_stat_name, _source, _amount)
/// @description Pushes a new entry onto the history for the given stat.
/// @param {String} _stat_name  One of "joy", "nonsense", "selfesteem", "enthusiasm"
/// @param {String} _source     Human-readable label for what caused the change (e.g. "tomato_soup", "dev_random")
/// @param {Real}   _amount     How much the stat changed (positive or negative)
function stat_history_log(_stat_name, _source, _amount) {
	var _arr = global.stat_history[$ _stat_name]; // look up the array for this stat
	if (!is_array(_arr)) return;                  // bail if the stat name is invalid
	array_push(_arr, {
		source: _source,        // what caused the change
		amount: _amount,        // how much it changed by
		time: current_time,     // timestamp in milliseconds (game clock)
	});
}

/// @function stat_history_get_last(_stat_name)
/// @description Returns the most recent history entry for a stat, or "none" if empty.
/// @param {String} _stat_name  One of "joy", "nonsense", "selfesteem", "enthusiasm"
/// @return {Struct|String}     The last entry struct, or "none"
function stat_history_get_last(_stat_name) {
	var _arr = global.stat_history[$ _stat_name]; // look up the array for this stat
	if (!is_array(_arr) || array_length(_arr) == 0) return "none"; // nothing logged yet
	return _arr[array_length(_arr) - 1];          // return the most recent entry
}

/// @function stat_history_get_all(_stat_name)
/// @description Returns the full history array for a stat.
/// @param {String} _stat_name  One of "joy", "nonsense", "selfesteem", "enthusiasm"
/// @return {Array}             Array of { source, amount, time } structs
function stat_history_get_all(_stat_name) {
	var _arr = global.stat_history[$ _stat_name]; // look up the array for this stat
	if (!is_array(_arr)) return [];               // return empty array if stat name is invalid
	return _arr;
}
