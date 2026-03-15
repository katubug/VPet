/// @description Re-enable game input when the popup is destroyed

// Clear the input-blocking flag so the shop (and everything else) responds
// to input again. This runs whether the player cancelled, confirmed, or the
// instance was destroyed by some other means.
global.dialog_open = false;
