// plot_index is set per-instance via Variable Definition in the room editor (0–8)

// Stop animation — frame 0 = dry, frame 1 = watered; switched manually in Draw
image_speed = 0;

// Cache half-dimensions for centering plants, hover, and progress bar
_half_w = sprite_width * 0.5;  // half the tile width — used for horizontal centering
_half_h = sprite_height * 0.5; // half the tile height — used for vertical centering

// Used for hover highlight in Draw event
_hover = false;
