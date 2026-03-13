/// @description Clean up when the dialog is destroyed

// Clear the input blocking flag so the rest of the game resumes normally.
// This event fires automatically whenever this object is destroyed — whether
// by the close animation finishing, a room change, or anything else.
// It's the safety net that ensures the game never gets permanently locked up.
global.dialog_open = false;
