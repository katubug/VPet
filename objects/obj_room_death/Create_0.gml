// Flag so we only spawn the dialog once, on the first Step (not Create).
// Spawning in Create can fail because the UI layer may not be ready yet during room init.
dialog_spawned = false;
