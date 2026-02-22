/// @description Initialize popup message

// Message to display (set when creating)
message = "Pet is full!";

// Position
x = display_get_gui_width() / 2;
y = display_get_gui_height() / 2;

// Duration
duration = 45; // 0.75 seconds at 60fps
timer = 0;

// Visual settings
text_color = c_white;
bg_color = c_black;
bg_alpha = 0.8;
