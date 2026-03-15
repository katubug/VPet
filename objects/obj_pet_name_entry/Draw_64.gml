/// @description Draw Pet Name & Gender Entry Screen

// ── DARK OVERLAY ─────────────────────────────────────────────────────────────
// Semi-transparent black wash over the whole screen so the card pops
draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);


// ── CARD BACKGROUND ───────────────────────────────────────────────────────────
draw_set_alpha(0.92);
draw_set_color(make_color_rgb(40, 40, 55)); // Dark blue-grey card
draw_rectangle(box_x, box_y, box_x + box_width, box_y + box_height, false);
draw_set_alpha(1);

// Card border — white outline, 3px thick
draw_set_color(c_white);
for (var _i = 0; _i < 3; _i++) {
    draw_rectangle(box_x + _i, box_y + _i, box_x + box_width - _i, box_y + box_height - _i, true);
}


// ── PET SPRITE ───────────────────────────────────────────────────────────────
// Draw the baby pet's idle sprite, centered near the top of the card
// pet_spr has bottom-center origin, so the draw point is the bottom of the sprite
// Scale 0.4 = 192x192 display size (sprite is 480x480 native)
// Adjust the scale value to resize — adjust _sprite_y to reposition vertically
var _sprite_scale = 0.4;
var _sprite_x     = box_x + (box_width / 2);        // Horizontally centered on card
var _sprite_y     = box_y + 220;                     // Bottom of the sprite lands here

if (sprite_exists(pet_spr)) {
    draw_sprite_ext(pet_spr, 0, _sprite_x, _sprite_y, _sprite_scale, _sprite_scale, 0, c_white, 1);
}


// ── TEXT SETUP ───────────────────────────────────────────────────────────────
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_Quicksand);
var _cx = box_x + (box_width / 2); // Horizontal center of the card


// ── PET TYPE & GENDER LINE ────────────────────────────────────────────────────
// Shows e.g. "Dodati  •  Boy"
// Adjust _info_y to move this line up or down within the card
var _info_y = box_y + 260;
draw_set_color(make_color_rgb(180, 220, 255)); // Soft blue — stands out from white name text
draw_text(_cx, _info_y, $"{pet_type_display}  •  {gender_display}");


// ── PROMPT TEXT ───────────────────────────────────────────────────────────────
// "Name your pet!" label above the input field
// Adjust _prompt_y to reposition
var _prompt_y = box_y + 310;
draw_set_color(c_white);
draw_text(_cx, _prompt_y, "Name your pet!");


// ── NAME INPUT FIELD ──────────────────────────────────────────────────────────
// The text being typed, with a blinking cursor
var _field_y    = box_y + 370;
var _field_w    = box_width - 80;
var _field_x    = box_x + 40;

// Input field background box
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(_field_x, _field_y - 24, _field_x + _field_w, _field_y + 24, false);
draw_set_alpha(1);
draw_set_color(c_white);
draw_rectangle(_field_x, _field_y - 24, _field_x + _field_w, _field_y + 24, true);

// Name text + blinking cursor
var _display = pet_name;
if (cursor_visible && !submitted) {
    _display += "|"; // Blinking caret
}
draw_set_color(c_white);
draw_text(_cx, _field_y, _display);


// ── INSTRUCTION TEXT ─────────────────────────────────────────────────────────
var _instr_y = box_y + box_height - 36;
draw_set_alpha(0.6);
var _instr = (os_type == os_android || os_type == os_ios)
           ? "(Tap Done when finished)"
           : "(Press Enter when done)";
draw_text(_cx, _instr_y, _instr);

// Character counter — bottom-right of card
draw_set_halign(fa_right);
draw_text(box_x + box_width - 16, _instr_y, $"{string_length(pet_name)}/{max_name_length}");


// ── RESET DRAW STATE ─────────────────────────────────────────────────────────
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
