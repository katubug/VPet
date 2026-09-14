/// @description Layout constants for the stats screen

// Outer padding from screen edges
margin = 8; // 30 ÷ 4 ≈ 8

// Vertical spacing
line_height     = 9;   // Height of one text row (28 ÷ 4)
section_gap     = 6;   // Extra vertical space added before each section header (24 ÷ 4)
header_height   = 10;   // Height of the section header row itself (30 ÷ 4 ≈ 8)

// Bar dimensions — match obj_ui_HUD for visual consistency
bar_width  = 75;  // Width of the stat bars (300 ÷ 4)
bar_height = 6;   // Height of the stat bars (18 ÷ 4 ≈ 5)
bar_outline = 1;  // Border thickness in pixels (minimum 1)

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
label_col_width = 55; // Edit to adjust label/value column split (150 ÷ 4 ≈ 38)

// Scrolling
scroll_y        = 0;    // current scroll offset in pixels
scroll_target   = 0;    // where scroll is heading (lerps toward this)
scroll_speed    = 8;    // pixels per mouse-wheel notch or keyboard tick
content_height  = 0;    // total drawn height — measured each frame in Draw_64
scroll_lerp     = 0.25; // smoothing (0 = frozen, 1 = instant)
_drag_active    = false; // true while the player is touch/mouse-dragging to scroll
_drag_start_y   = 0;    // GUI Y where the drag began
_drag_start_scroll = 0; // scroll_target at the moment the drag began
