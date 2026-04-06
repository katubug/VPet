/// @description Layout constants for the stats screen

// Outer padding from screen edges
margin = 30;

// Vertical spacing
line_height     = 28;  // Height of one text row — increase to spread rows further apart
section_gap     = 24;  // Extra vertical space added before each section header
header_height   = 30;  // Height of the section header row itself

// Bar dimensions — match obj_ui_HUD for visual consistency
bar_width  = 300; // Width of the stat bars — edit to make them wider/narrower
bar_height = 18;  // Height of the stat bars
bar_outline = 2;  // Border thickness in pixels

// Colors
color_bg          = c_black;   // Bar background fill
color_border      = c_white;   // Bar and section border color
color_title       = c_yellow;  // Screen title color
color_header      = c_yellow;  // Section header label color
color_label       = c_ltgray;  // Left-side stat labels
color_value       = c_white;   // Right-side stat values
color_hunger      = c_lime;    // Hunger bar fill
color_thirst      = make_color_rgb(100, 180, 255); // Thirst bar fill — light blue
color_happiness   = c_yellow;  // Happiness bar fill
color_placeholder = c_dkgray;  // Color for placeholder/unimplemented values

// Alpha
bar_bg_alpha   = 0.5; // Transparency of empty bar background
bar_fill_alpha = 1.0; // Transparency of filled bar portion

// Label column width — the value starts at margin + label_col_width
label_col_width = 150; // Edit to adjust label/value column split
