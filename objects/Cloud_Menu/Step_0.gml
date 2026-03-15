/// @description Handle Input and State

// Lock navigation during the egg phase and while the pet name prompt is open
if (global.game.evolution_phase == "egg" || instance_exists(obj_pet_name_entry)) exit;

// -- Cooldown Tick --
if (input_cooldown > 0) {
    input_cooldown--; // Count down one frame of cooldown each step
}

// -- Mouse Position --
var mx = device_mouse_x_to_gui(0); // Mouse X in GUI space (handles resolution scaling)
var my = device_mouse_y_to_gui(0); // Mouse Y in GUI space

// -- Reset Hover State Each Frame --
hover_index_top    = -1; // Clear top row hover; will be re-set if mouse is over an icon
hover_index_bottom = -1; // Clear bottom row hover; will be re-set if mouse is over an icon

// -- Mouse Hover: Top Row --
for (var i = 0; i < menu_count_top; i++) {
    if (!top_items[i].enabled) continue; // Skip disabled icons

    var icon_x = menu_start_x + (i * icon_spacing); // X center of this icon
    var icon_y = menu_y_top;                          // Y center of top row icons

    // Rectangular hit test around the icon center
    if (point_in_rectangle(mx, my,
        icon_x - icon_size / 2,
        icon_y - icon_size / 2,
        icon_x + icon_size / 2,
        icon_y + icon_size / 2)) {

        hover_index_top = i; // Record which top icon is hovered
        last_input_was_keyboard = false; // Mouse movement counts as mouse input
        break;
    }
}

// -- Mouse Hover: Bottom Row --
for (var i = 0; i < menu_count_bottom; i++) {
    if (!bottom_items[i].enabled) continue; // Skip disabled icons

    var icon_x = menu_start_x + (i * icon_spacing); // X center of this icon
    var icon_y = menu_y_bottom;                       // Y center of bottom row icons

    if (point_in_rectangle(mx, my,
        icon_x - icon_size / 2,
        icon_y - icon_size / 2,
        icon_x + icon_size / 2,
        icon_y + icon_size / 2)) {

        hover_index_bottom = i; // Record which bottom icon is hovered
        last_input_was_keyboard = false;
        break;
    }
}

// -- Keyboard Navigation: Switch Rows (Up/Down) --
var key_up   = input_check_pressed("up");   // Switch to top row
var key_down = input_check_pressed("down"); // Switch to bottom row

if (key_up || key_down) {
    last_input_was_keyboard = true;

    if (key_up && active_row == 1) {
        active_row = 0; // Move focus up to the top row
    } else if (key_down && active_row == 0) {
        active_row = 1; // Move focus down to the bottom row
    }
}

// -- Keyboard Navigation: Move Within Active Row (Left/Right) --
var key_left  = input_check_pressed("left");
var key_right = input_check_pressed("right");

if (key_left || key_right) {
    last_input_was_keyboard = true;

    var move_dir = key_right - key_left; // +1 for right, -1 for left

    if (active_row == 0) {
        // Navigate within the top row
        selected_index_top += move_dir;

        // Wrap around edges
        if (selected_index_top >= menu_count_top) selected_index_top = 0;
        if (selected_index_top < 0) selected_index_top = menu_count_top - 1;

        // Skip over any disabled items
        var safety = 0;
        while (!top_items[selected_index_top].enabled && safety < menu_count_top) {
            selected_index_top += move_dir;
            if (selected_index_top >= menu_count_top) selected_index_top = 0;
            if (selected_index_top < 0) selected_index_top = menu_count_top - 1;
            safety++;
        }
    } else {
        // Navigate within the bottom row
        selected_index_bottom += move_dir;

        if (selected_index_bottom >= menu_count_bottom) selected_index_bottom = 0;
        if (selected_index_bottom < 0) selected_index_bottom = menu_count_bottom - 1;

        var safety = 0;
        while (!bottom_items[selected_index_bottom].enabled && safety < menu_count_bottom) {
            selected_index_bottom += move_dir;
            if (selected_index_bottom >= menu_count_bottom) selected_index_bottom = 0;
            if (selected_index_bottom < 0) selected_index_bottom = menu_count_bottom - 1;
            safety++;
        }
    }
}

// -- Activation --
var activated       = false; // Whether an item was triggered this frame
var activated_row   = -1;   // Which row was activated (0 = top, 1 = bottom)
var activated_index = -1;   // Which index within that row was activated

// Keyboard activation (Enter / Space / gamepad confirm)
if (input_check_pressed("accept") || input_check_pressed("action")) {
    if (last_input_was_keyboard && input_cooldown <= 0) {
        activated       = true;
        activated_row   = active_row;
        activated_index = (active_row == 0) ? selected_index_top : selected_index_bottom;
    }
}

// Mouse / touch activation (left click)
if (mouse_check_button_pressed(mb_left) && input_cooldown <= 0) {
    if (hover_index_top != -1) {
        // Clicked on the top row
        activated           = true;
        activated_row       = 0;
        activated_index     = hover_index_top;
        last_input_was_keyboard = false;
        selected_index_top  = hover_index_top; // Sync keyboard selection to clicked item
        active_row          = 0;
    } else if (hover_index_bottom != -1) {
        // Clicked on the bottom row
        activated              = true;
        activated_row          = 1;
        activated_index        = hover_index_bottom;
        last_input_was_keyboard = false;
        selected_index_bottom  = hover_index_bottom;
        active_row             = 1;
    }
}

// -- Execute Callback --
if (activated && activated_index != -1) {
    var item_list = (activated_row == 0) ? top_items : bottom_items; // Pick the right row's array

    if (item_list[activated_index].enabled) {
        item_list[activated_index].callback(); // Fire the item's callback function
        input_cooldown = cooldown_duration;    // Prevent double-triggering
    }
}
