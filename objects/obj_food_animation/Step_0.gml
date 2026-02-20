/// @description Animate eating frames

if (!animation_complete) {
    obj_pet_parent.eating = true;
    // Increment timer
    frame_timer++;
    
    // Check if it's time to advance to next frame
    if (frame_timer >= frame_duration) {
        frame_timer = 0;
        current_frame++;
        
        // Update sprite frame
        if (current_frame < total_frames) {
            image_index = current_frame;
        } else {
            // Animation complete
            animation_complete = true;
            
            // Wait a moment, then return to inventory
            alarm[0] = 15; // Wait 15 frames (0.25 seconds) then switch rooms
        }
    }
}
