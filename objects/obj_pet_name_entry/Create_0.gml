/// @description Initialize Pet Name & Gender Entry

// ── PET INFO ─────────────────────────────────────────────────────────────────
// Look up the baby pet's idle sprite by constructing the asset name at runtime
// e.g. current_pet_type "dodati" → spr_dodati_base
pet_spr = asset_get_index($"spr_{global.game.current_pet_type}_base");

// Build a display-friendly version of the pet type name (capitalize first letter)
// e.g. "dodati" → "Dodati"
var _type = global.game.current_pet_type;
pet_type_display = string_upper(string_char_at(_type, 1))
                 + string_copy(_type, 2, string_length(_type) - 1);

// Gender string is already set on global at hatch time ("boy" or "girl")
gender_display = string_upper(string_char_at(global.game.gender, 1))
               + string_copy(global.game.gender, 2, string_length(global.game.gender) - 1);


// ── TEXT INPUT STATE ─────────────────────────────────────────────────────────
// Clear keyboard_string so nothing leftover from earlier rooms bleeds in
keyboard_string = "";

pet_name        = "";   // The name being typed
max_name_length = 20;   // Max characters allowed — adjust freely
cursor_visible  = true;
cursor_timer    = 0;
cursor_blink_speed = 30; // Frames between cursor blinks — lower = faster blink
submitted       = false;


// ── LAYOUT ───────────────────────────────────────────────────────────────────
// Card dimensions — centered on screen
// Adjust box_width/box_height to resize the whole panel
box_width  = 580;
box_height = 480;
// box_x/box_y are recalculated in Draw each frame — display_get_gui_width/height unreliable in Create on Android
done_btn_width  = 200; // Width of the Done button on mobile — adjust freely
done_btn_height = 70;  // Height of the Done button on mobile — adjust freely
done_btn_color  = c_green; // Background color of the Done button
done_btn_label  = "Done";  // Text shown on the Done button


// ── MOBILE KEYBOARD ──────────────────────────────────────────────────────────
keyboard_showing = false;
if (os_type == os_android || os_type == os_ios) {
    keyboard_virtual_show(kbv_type_default, kbv_returnkey_done, kbv_autocapitalize_words, false);
    keyboard_showing = true;
}
