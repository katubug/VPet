/// @description Draw the stats screen panel

draw_set_font(fnt_Kubasta);

// Precompute layout positions used throughout this event
var _mx      = margin;                      // Left x edge for all labels
var _vx      = _mx + label_col_width;       // X where values and bars begin
var _gui_w   = display_get_gui_width();     // Full canvas width — used for centering and line ends
var _cy      = margin + 120;                // Cursor y — incremented as rows are drawn; +120 pushes content down from top

// =========================================================
//  READ DATA
// =========================================================
var _petname    = (global.game.petname != "")        ? global.game.petname        : "???";
var _pet_type   = (global.game.current_pet_type != "") ? global.game.current_pet_type : "???";
var _phase      = global.game.evolution_phase;
var _age        = global.game.pet_age_days;   // Placeholder — not yet calculated
var _gen        = global.game.generation;     // Placeholder — always 1
var _gender     = (global.game.gender != "") ? global.game.gender : "???";
var _corns      = global.game.corns;

var _hunger     = global.game.hunger;
var _thirst     = global.game.thirst;         // Placeholder — system not implemented
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
draw_text(_gui_w / 2, _cy, "STATS"); // Centered title at top
_cy += 50;

// =========================================================
//  SECTION: PET
// =========================================================
_cy += section_gap;
draw_set_color(color_border);
draw_line(_mx, _cy + 10, _gui_w - _mx, _cy + 10); // Horizontal rule
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_rectangle(_mx, _cy, _mx + string_width("PET") + 10, _cy + header_height, false); // Label backing
draw_set_color(color_header);
draw_text(_mx + 5, _cy, "PET");
_cy += header_height + 6;

// Name
draw_set_color(color_label);     draw_text(_mx, _cy, "Name");
draw_set_color(color_value);     draw_text(_vx, _cy, _petname);
_cy += line_height;

// Type
draw_set_color(color_label);     draw_text(_mx, _cy, "Type");
draw_set_color(color_value);     draw_text(_vx, _cy, _pet_type);
_cy += line_height;

// Phase
draw_set_color(color_label);     draw_text(_mx, _cy, "Phase");
draw_set_color(color_value);     draw_text(_vx, _cy, _phase);
_cy += line_height;

// Age (placeholder)
draw_set_color(color_label);        draw_text(_mx, _cy, "Age");
draw_set_color(color_placeholder);  draw_text(_vx, _cy, string(_age) + " days"); // Not yet calculated
_cy += line_height;

// Generation (placeholder)
draw_set_color(color_label);        draw_text(_mx, _cy, "Generation");
draw_set_color(color_placeholder);  draw_text(_vx, _cy, string(_gen)); // Always 1 for now
_cy += line_height;

// Gender
draw_set_color(color_label);     draw_text(_mx, _cy, "Gender");
draw_set_color(color_value);     draw_text(_vx, _cy, _gender);
_cy += line_height;

// Corns
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
var _bar_y = _cy + 2; // Small nudge to optically align bar with label text
draw_set_alpha(bar_bg_alpha);   draw_set_color(color_bg);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width, _bar_y + bar_height, false);
draw_set_alpha(bar_fill_alpha); draw_set_color(color_hunger);
draw_rectangle(_bar_x, _bar_y, _bar_x + bar_width * clamp(_hunger / 20, 0, 1), _bar_y + bar_height, false);
draw_set_alpha(1);              draw_set_color(color_border);
for (var _i = 0; _i < bar_outline; _i++) draw_rectangle(_bar_x - _i, _bar_y - _i, _bar_x + bar_width + _i, _bar_y + bar_height + _i, true);
_cy += bar_height + 14;

// -- Thirst bar (placeholder) --
draw_set_color(color_placeholder); draw_text(_mx, _cy, "Thirst (soon)"); // Not implemented yet
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
draw_set_color(color_value);  draw_text(_vx, _cy, string(_hs_mash)); // Will show real scores once mash saves them
_cy += line_height;

// =========================================================
//  RESET draw state
// =========================================================
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
