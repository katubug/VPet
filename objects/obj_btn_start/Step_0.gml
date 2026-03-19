/// @description Show/hide based on name entry state

// Hide completely while name entry is open -- show once the player has confirmed their name
// Mouse_4 also has an instance_exists guard since mouse events fire before Step
visible = !instance_exists(obj_name_entry);
