/// @description Draw the stats screen panel (scrollable)

draw_set_font(fnt_Kubasta);

// Display area bounds from global layout
var _clip_top    = global.display_area_top;
var _clip_bottom = global.display_area_bottom;
var _visible_h   = _clip_bottom - _clip_top;
var _gui_w       = display_get_gui_width();
var _gui_h       = display_get_gui_height();

// Precompute layout positions
var _mx = margin;                // left edge for labels
var _vx = _mx + label_col_width; // x where values and bars start

// Content starts at the top of the display area (with internal padding),
// then shifts up by scroll_y as the player scrolls
var _content_pad = 4; // breathing room inside the top of the display area
var _cy = _clip_top + _content_pad - scroll_y;


// =========================================================
//  SCISSOR CLIP — hide anything drawn outside the display area
// =========================================================
// gpu_set_scissor works in window-pixel coordinates, so scale GUI → window
var _sx = window_get_width()  / _gui_w;
var _sy = window_get_height() / _gui_h;
gpu_set_scissor(
    0,
    floor(_clip_top * _sy),
    ceil(_gui_w * _sx),
    ceil(_visible_h * _sy)
);


// =========================================================
//  READ DATA
// =========================================================
var _petname    = (global.game.petname != "")           ? global.game.petname           : "???";
var _pet_type   = (global.game.current_pet_type != "")  ? global.game.current_pet_type  : "???";
var _phase      = global.game.evolution_phase;
var _age        = global.game.pet_age_days;
var _gen        = global.game.generation;
var _gender     = (global.game.gender != "") ? global.game.gender : "???";
var _corns      = global.game.corns;

var _hunger     = global.game.hunger;
var _thirst     = global.game.thirst;
var _happiness  = global.game.happiness;

var _joy        = global.pet.joy;
var _nonsense   = global.pet.nonsense;
var _selfesteem = global.pet.selfesteem;
var _enthusiasm = global.pet.enthusiasm;

var _hs_runner  = global.game.high_score_runner;
var _hs_mash    = global.game.high_score_buttonmash;


// =========================================================
//  TITLE
// =========================================================
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(color_title);
draw_text(_gui_w / 2, _cy, "STATS");
_cy += line_height;


// =========================================================
//  SECTION: PET
// =========================================================
_cy += section_gap;
draw_set_color(color_border);
draw_line(_mx, _cy + 10, _gui_w - _mx, _cy + 10);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_rectangle(_mx, _cy, _mx + string_width("PET") + 10, _cy + header_height, false);
draw_set_color(color_header);
draw_text(_mx + 5, _cy, "PET");
_cy += header_height + 6;

draw_set_color(color_label);     draw_text(_mx, _cy, "Name");
draw_set_color(color_value);     draw_text(_vx, _cy, _petname);
_cy += line_height;

draw_set_color(color_label);     draw_text(_mx, _cy, "Type");
draw_set_color(color_value);     draw_text(_vx, _cy, _pet_type);
_cy += line_height;

draw_set_color(color_label);     draw_text(_mx, _cy, "Phase");
draw_set_color(color_value);     draw_text(_vx, _cy, _phase);
_cy += line_height;

draw_set_color(color_label);        draw_text(_mx, _cy, "Age");
draw_set_color(color_placeholder);  draw_text(_vx, _cy, string(_age) + " days");
_cy += line_height;

draw_set_color(color_label);        draw_text(_mx, _cy, "Generation");
draw_set_color(color_placeholder);  draw_text(_vx, _cy, string(_gen));
_cy += line_height;

draw_set_color(color_label);     draw_text(_mx, _cy, "Gender");
draw_set_color(color_value);     draw_text(_vx, _cy, _gender);
_cy += line_height;

draw_set_color(color_label);     draw_text(_mx, _cy, "Corns");
draw_set_color(color_value);     draw_text(_vx, _cy, string(_corns));
_cy += line_height;


// =========================================================
//  SECTION: NEEDS
// =========================================================
_cy += section_gap;
draw_set_color(color_border);
draw_line(_mx, _cy + 10, _gui_w - _mx, _cy + 10);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_rectangle(_mx, _cy, _mx + string_width("NEEDS") + 10, _cy + header_height, false);
draw_set_color(color_header);
draw_text(_mx + 5, _cy, "NEEDS");
_cy += header_height + 6;

// -- Hunger bar --
draw_set_color(color_label);    draw_text(_mx, _cy, "Hunger");
var _bar_x = _vx;
var _bar_y = _cy + 2;
draw_set_alpha(bar_bg_alpha);   draw_set_color(color_bg);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width, _bar_y + bar_height, false);
draw_set_alpha(bar_fill_alpha); draw_set_color(color_hunger);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width * clamp(_hunger / 20, 0, 1), _bar_y + bar_height, false);
draw_set_alpha(1);              draw_set_color(color_border);
for (var _i = 0; _i < bar_outline; _i++) draw_rectangle(_bar_x - _i, _bar_y - _i, _bar_x + bar_width + _i, _bar_y + bar_height + _i, true);
_cy += bar_height + 14;

// -- Thirst bar (placeholder) --
draw_set_color(color_placeholder); draw_text(_mx, _cy, "Thirst (soon)");
_bar_y = _cy + 2;
draw_set_alpha(bar_bg_alpha);   draw_set_color(color_bg);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width, _bar_y + bar_height, false);
draw_set_alpha(1);              draw_set_color(color_border);
for (var _i = 0; _i < bar_outline; _i++) draw_rectangle(_bar_x - _i, _bar_y - _i, _bar_x + bar_width + _i, _bar_y + bar_height + _i, true);
_cy += bar_height + 14;

// -- Happiness bar --
draw_set_color(color_label);    draw_text(_mx, _cy, "Happiness");
_bar_y = _cy + 2;
draw_set_alpha(bar_bg_alpha);   draw_set_color(color_bg);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width, _bar_y + bar_height, false);
draw_set_alpha(bar_fill_alpha); draw_set_color(color_happiness);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width * clamp(_happiness / 20, 0, 1), _bar_y + bar_height, false);
draw_set_alpha(1);              draw_set_color(color_border);
for (var _i = 0; _i < bar_outline; _i++) draw_rectangle(_bar_x - _i, _bar_y - _i, _bar_x + bar_width + _i, _bar_y + bar_height + _i, true);
_cy += bar_height + 14;


// =========================================================
//  SECTION: PERSONALITY
// =========================================================
_cy += section_gap;
draw_set_color(color_border);
draw_line(_mx, _cy + 10, _gui_w - _mx, _cy + 10);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_rectangle(_mx, _cy, _mx + string_width("PERSONALITY") + 10, _cy + header_height, false);
draw_set_color(color_header);
draw_text(_mx + 5, _cy, "PERSONALITY");
_cy += header_height + 6;

draw_set_color(color_label);  draw_text(_mx, _cy, "Nonsense");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_nonsense));
_cy += line_height;

draw_set_color(color_label);  draw_text(_mx, _cy, "Joy");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_joy));
_cy += line_height;

draw_set_color(color_label);  draw_text(_mx, _cy, "Self-Esteem");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_selfesteem));
_cy += line_height;

draw_set_color(color_label);  draw_text(_mx, _cy, "Enthusiasm");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_enthusiasm));
_cy += line_height;


// =========================================================
//  SECTION: HIGH SCORES
// =========================================================
_cy += section_gap;
draw_set_color(color_border);
draw_line(_mx, _cy + 10, _gui_w - _mx, _cy + 10);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_rectangle(_mx, _cy, _mx + string_width("HIGH SCORES") + 10, _cy + header_height, false);
draw_set_color(color_header);
draw_text(_mx + 5, _cy, "HIGH SCORES");
_cy += header_height + 6;

draw_set_color(color_label);  draw_text(_mx, _cy, "Runner");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_hs_runner));
_cy += line_height;

draw_set_color(color_label);  draw_text(_mx, _cy, "Button Mash");
draw_set_color(color_value);  draw_text(_vx, _cy, string(_hs_mash));
_cy += line_height;


// =========================================================
//  MEASURE CONTENT HEIGHT (used by Step for scroll clamping)
// =========================================================
// _cy has been incrementing from (_clip_top + _content_pad - scroll_y).
// Add scroll_y back and subtract the start to get the total content height.
content_height = (_cy + scroll_y) - (_clip_top + _content_pad);


// =========================================================
//  CLEAR SCISSOR
// =========================================================
gpu_set_scissor(0, 0, window_get_width(), window_get_height());


// =========================================================
//  SCROLL INDICATOR — thin bar on the right edge
// =========================================================
var _max_scroll = max(0, content_height - _visible_h);
if (_max_scroll > 0) {
    // Proportional scrollbar thumb
    var _sb_x     = _gui_w - 3;             // 3px from right edge
    var _sb_w     = 1;                       // 1px wide
    var _thumb_h  = max(8, _visible_h * (_visible_h / content_height)); // thumb size, min 8px
    var _sb_range = _visible_h - _thumb_h;   // travel distance
    var _sb_y     = _clip_top + _sb_range * (scroll_y / _max_scroll);   // thumb position

    draw_set_alpha(0.4);
    draw_set_color(c_white);
    draw_rectangle(_sb_x, _sb_y, _sb_x + _sb_w, _sb_y + _thumb_h, false);
    draw_set_alpha(1);
}


// =========================================================
//  RESET draw state
// =========================================================
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
