/// @description Reusable typewriter text effect system
/// Creates a struct that reveals text one character at a time.
/// Use typewriter_create() to start, typewriter_update() each frame,
/// and typewriter_get_text() to get the visible portion of the string.

/// @function typewriter_create(_text, _chars_per_frame)
/// @param {string} _text             The full string to reveal
/// @param {real}   _chars_per_frame  How many characters to reveal each frame (default 2)
/// @returns {struct} A typewriter struct to pass to the other typewriter functions
function typewriter_create(_text, _chars_per_frame = 2) {
	return {
		text: _text,                        // the full string to reveal
		speed: _chars_per_frame,            // characters revealed per frame
		progress: 0,                        // current reveal position (float, floors to char index)
		length: string_length(_text),       // cached length so we don't recalculate each frame
		complete: false,                    // true once the entire string is visible
	};
}

/// @function typewriter_update(_tw)
/// @param {struct} _tw  The typewriter struct returned by typewriter_create
/// @description Advances the reveal by _tw.speed characters. Call once per frame.
function typewriter_update(_tw) {
	if (_tw.complete) return;               // nothing to do if already finished
	_tw.progress += _tw.speed;              // advance by the configured speed
	if (_tw.progress >= _tw.length) {       // clamp to string length
		_tw.progress = _tw.length;
		_tw.complete = true;                // mark as fully revealed
	}
}

/// @function typewriter_get_text(_tw)
/// @param {struct} _tw  The typewriter struct
/// @returns {string} The portion of the text revealed so far
function typewriter_get_text(_tw) {
	return string_copy(_tw.text, 1, floor(_tw.progress)); // substring from char 1 to current position
}

/// @function typewriter_is_complete(_tw)
/// @param {struct} _tw  The typewriter struct
/// @returns {bool} Whether the full text has been revealed
function typewriter_is_complete(_tw) {
	return _tw.complete;
}
