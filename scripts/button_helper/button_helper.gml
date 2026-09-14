/// @description Reusable helpers for drawing colored buttons with nine-sliced sprites.
/// Requires nine-slice to be enabled on each spr_btn_base_* sprite in the IDE.

// ── BUTTON COLOR ENUM ────────────────────────────────────────────────────────
// Maps each color name to a constant. Pass these to draw_button() as _color.
// To add a new color: add an enum entry here AND a case in btn_get_sprite().
enum BTN_COLOR {
	BLUE,    // spr_btn_base_blue
	CYAN,    // spr_btn_base_cyan
	DKBLUE,  // spr_btn_base_dkblue
	PINK,    // spr_btn_base_pink
	YELLOW   // spr_btn_base_yellow
}


/// @function btn_get_sprite(_color)
/// @description Returns the sprite asset for a given BTN_COLOR enum value.
/// @param {real} _color  A BTN_COLOR enum value (e.g. BTN_COLOR.BLUE)
/// @returns {Asset.GMSprite} The matching spr_btn_base_* sprite
function btn_get_sprite(_color) {
	switch (_color) {
		case BTN_COLOR.BLUE:   return spr_btn_base_blue;   // light blue button
		case BTN_COLOR.CYAN:   return spr_btn_base_cyan;   // cyan/teal button
		case BTN_COLOR.DKBLUE: return spr_btn_base_dkblue; // dark blue button
		case BTN_COLOR.PINK:   return spr_btn_base_pink;   // pink button
		case BTN_COLOR.YELLOW: return spr_btn_base_yellow;  // yellow button
		default:               return spr_btn_base_blue;   // fallback to blue
	}
}


/// @function draw_button(_x, _y, _w, _h, _label, _color, [_hover])
/// @description Draws a nine-sliced colored button with a centered text label.
///              Call this from a Draw GUI event — all coordinates are GUI-space.
/// @param {real}   _x      Left edge x position
/// @param {real}   _y      Top edge y position
/// @param {real}   _w      Button width in pixels
/// @param {real}   _h      Button height in pixels
/// @param {string} _label  Text to display centered on the button
/// @param {real}   _color  A BTN_COLOR enum value
/// @param {bool}   [_hover]  true = draw with hover highlight (default: false)
function draw_button(_x, _y, _w, _h, _label, _color, _hover = false) {
	var _spr = btn_get_sprite(_color); // look up the sprite for this color

	// ── BUTTON BACKGROUND ────────────────────────────────────────────────────
	// Normal state: full color, slight transparency so hover stands out.
	// Hover state: full opacity + subtle white overlay for a brightening effect.
	// Adjust 0.85 (normal alpha) to taste — lower = more visible hover contrast.
	var _alpha = _hover ? 1.0 : 0.85;
	draw_set(c_white, _alpha);
	draw_sprite_stretched(         // nine-slice stretches corners properly
		_spr, 0,                   // sprite asset, sub-image 0
		_x, _y,                    // top-left corner in GUI space
		_w, _h                     // stretched width and height
	);

	// ── HOVER OVERLAY ────────────────────────────────────────────────────────
	// Draw a semi-transparent white version on top to brighten the button.
	// Remove or adjust 0.15 to control how strong the brightening is.
	if (_hover) {
		draw_set(c_white, 0.15);
		draw_sprite_stretched(_spr, 0, _x, _y, _w, _h);
	}

	// ── LABEL TEXT ───────────────────────────────────────────────────────────
	// Centered in the button using fnt_Kubasta (the project's standard UI font).
	// Change the font here if a specific button style needs a different face.
	draw_set(c_white, 1);
	draw_set_font(fnt_Kubasta);
	text_align(fa_center, fa_middle);
	draw_text(
		_x + _w / 2,              // horizontal center of the button
		_y + _h / 2,              // vertical center of the button
		_label
	);

	// ── CLEANUP ──────────────────────────────────────────────────────────────
	// Reset draw state so nothing leaks into whatever draws next.
	draw_reset();
	text_align(fa_left, fa_top);
}


/// @function point_in_button(_mx, _my, _x, _y, _w, _h)
/// @description Checks whether a GUI-space point is inside a button's rectangle.
///              Saves repeating point_in_rectangle boilerplate everywhere.
/// @param {real} _mx  Point x (e.g. device_mouse_x_to_gui(0))
/// @param {real} _my  Point y (e.g. device_mouse_y_to_gui(0))
/// @param {real} _x   Button left edge
/// @param {real} _y   Button top edge
/// @param {real} _w   Button width
/// @param {real} _h   Button height
/// @returns {bool} true if the point is inside the button rect
function point_in_button(_mx, _my, _x, _y, _w, _h) {
	return point_in_rectangle(
		_mx, _my,                  // the point to test
		_x, _y,                    // top-left corner of the button
		_x + _w, _y + _h          // bottom-right corner of the button
	);
}