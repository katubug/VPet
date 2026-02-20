/// @description Initialize Food Animation
/// This object is created when feeding the pet
/// Pass the food sprite in the creation code

// Sprite to animate (set this when creating the object)
if (!variable_instance_exists(id, "food_sprite")) {
    food_sprite = spr_food_bibo; // Default fallback
}

// Animation settings
image_index = 0; // Start at frame 0 (fresh food)
image_speed = 0; // Don't auto-animate, we'll control it manually

// Position
x = room_width / 2;
y = 400;

// Animation timing (in frames, 60fps = 1 second)
frame_duration = 30; // Each eating frame lasts 45 frames (0.75 seconds)
frame_timer = 0;
current_frame = 0;
total_frames = 4; // 4 frames: fresh → partially eaten → mostly eaten → gone

// Which room to return to after animation
return_room = rm_inventory;

// Track if animation is complete
animation_complete = false;
