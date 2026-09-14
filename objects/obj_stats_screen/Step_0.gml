/// @description Handle scroll input

var _area_top    = global.display_area_top;
var _area_bottom = global.display_area_bottom;
var _visible_h   = _area_bottom - _area_top;
var _max_scroll  = max(0, content_height - _visible_h);

// -- Mouse wheel --
if (mouse_wheel_up())   scroll_target -= scroll_speed;
if (mouse_wheel_down()) scroll_target += scroll_speed;

// -- Touch / mouse drag --
var _my = device_mouse_y_to_gui(0);

if (mouse_check_button_pressed(mb_left)) {
    // Only start a drag if the press is inside the content area
    if (_my >= _area_top && _my <= _area_bottom) {
        _drag_active       = true;
        _drag_start_y      = _my;
        _drag_start_scroll = scroll_target;
    }
}

if (_drag_active && mouse_check_button(mb_left)) {
    // Dragging finger/mouse UP should scroll content UP (increase offset)
    scroll_target = _drag_start_scroll + (_drag_start_y - _my);
}

if (mouse_check_button_released(mb_left)) {
    _drag_active = false;
}

// -- Keyboard / gamepad (continuous hold) --
if (input_check("down")) scroll_target += scroll_speed * 0.5;
if (input_check("up"))   scroll_target -= scroll_speed * 0.5;

// Clamp to valid range
scroll_target = clamp(scroll_target, 0, _max_scroll);

// Smooth interpolation toward target
scroll_y = lerp(scroll_y, scroll_target, scroll_lerp);
if (abs(scroll_y - scroll_target) < 0.5) scroll_y = scroll_target;
