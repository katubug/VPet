/// @description Draw the talk screen UI (white bar + typewriter text)

// Only draw when the talk sequence is active and past the walk-in phase
if (!talk_active || talk_phase == "walk_in") exit;

var _gui_w = display_get_gui_width();    // width of the GUI canvas
var _gui_h = display_get_gui_height();   // height of the GUI canvas
var _bar_h = _gui_h * 0.3;              // dialogue bar takes up 30% of screen height

// -- White text bar across the top of the screen --
draw_set(c_white, 1);
draw_rectangle(0, 0, _gui_w, _bar_h, false);

// -- Dialogue text (typewriter effect, centered in the bar) --
draw_set_font(fnt_Kubasta_lrg);         // larger font for readability
draw_set(c_black, 1);
text_align(fa_center, fa_middle);

// Get the currently visible portion of the text
var _visible_text = typewriter_get_text(talk_typewriter);

// Draw the text centered horizontally and vertically within the bar
// Use generous margins so long lines wrap nicely inside the bar
draw_text_ext(_gui_w / 2, _bar_h / 2, _visible_text, -1, _gui_w - 80);

// -- Reset draw state so other objects aren't affected --
draw_reset();
draw_set_font(-1);
text_align(fa_left, fa_top);
