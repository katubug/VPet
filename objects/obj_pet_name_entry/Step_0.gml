/// @description Handle Name Input

// Skip all input once the player has submitted
if (submitted) exit;


// ── CURSOR BLINK ─────────────────────────────────────────────────────────────
cursor_timer++;
if (cursor_timer >= cursor_blink_speed) {
    cursor_visible = !cursor_visible; // Flip visibility each blink cycle
    cursor_timer   = 0;
}


// ── DESKTOP / PC KEYBOARD INPUT ──────────────────────────────────────────────
if (os_type != os_android && os_type != os_ios) {

    var _raw = keyboard_string; // GML's built-in running string of what's been typed

    // Filter to allowed characters: letters, digits, spaces, hyphens, apostrophes
    var _filtered = "";
    for (var i = 1; i <= string_length(_raw); i++) {
        var _ch = string_char_at(_raw, i);
        if (string_lettersdigits(_ch) != "" || _ch == " " || _ch == "-" || _ch == "'") {
            _filtered += _ch;
        }
    }

    // Enforce the character limit
    pet_name       = string_copy(_filtered, 1, max_name_length);
    keyboard_string = pet_name; // Keep the built-in in sync so backspace stays accurate

    // Backspace support (GML's keyboard_string handles most deletion but this is a safety net)
    if (keyboard_check_pressed(vk_backspace)) {
        if (string_length(pet_name) > 0) {
            pet_name        = string_delete(pet_name, string_length(pet_name), 1);
            keyboard_string = pet_name;
        }
    }

    // Submit on Enter — require at least one non-whitespace character
    if (keyboard_check_pressed(vk_enter)) {
        if (string_length(string_trim(pet_name)) > 0) {
            submit_pet_name();
        }
    }
}


// ── MOBILE / TOUCH INPUT ─────────────────────────────────────────────────────
else {
    // Always read from keyboard_string — keyboard_virtual_status() is unreliable on Android
    // (returns -1 briefly after show, and kbv_type_none is not a valid constant on Android)
    {
        var _raw = keyboard_string;
        var _filtered = "";
        for (var i = 1; i <= string_length(_raw); i++) {
            var _ch = string_char_at(_raw, i);
            if (string_lettersdigits(_ch) != "" || _ch == " " || _ch == "-" || _ch == "'") {
                _filtered += _ch;
            }
        }
        pet_name = string_copy(_filtered, 1, max_name_length);
        // Only write back if changed — writing every frame causes [VK] SetInputString spam
        if (_raw != pet_name) {
            keyboard_string = pet_name;
        }
    }

    if (mouse_check_button_pressed(mb_left)) {
        var _mx = device_mouse_x_to_gui(0); // GUI-space tap X
        var _my = device_mouse_y_to_gui(0); // GUI-space tap Y
        // Tap Done button → submit if name is non-empty
        if (point_in_rectangle(_mx, _my, done_btn_x, done_btn_y, done_btn_x + done_btn_width, done_btn_y + done_btn_height)) {
            if (string_length(string_trim(pet_name)) > 0) {
                keyboard_virtual_hide();
                submit_pet_name();
            }
        // Tap inside the input field → reopen keyboard
        } else if (point_in_rectangle(_mx, _my, box_x + 40, box_y + 346, box_x + box_width - 40, box_y + 394)) {
            keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_words, false);
            keyboard_showing = true;
        }
    }
}


// ── SUBMIT FUNCTION ───────────────────────────────────────────────────────────
function submit_pet_name() {
    if (submitted) exit; // Guard against double-fire
    submitted = true;

    // Strip leading/trailing whitespace before saving
    global.game.petname = string_trim(pet_name);

    // Fallback in case something weird strips the name to empty after trimming
    if (string_length(global.game.petname) == 0) {
        global.game.petname = "Goober";
    }

    show_debug_message($"Pet named: {global.game.petname} ({global.game.gender})");

    // Hide mobile keyboard if it's still showing
    if (os_type == os_android || os_type == os_ios) {
        keyboard_virtual_hide();
    }

    instance_destroy(self); // Done — remove the prompt
}
