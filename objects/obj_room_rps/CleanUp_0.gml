// Destroy only our own virtual buttons so we don't stomp on anyone else's
for (var i = 0; i < array_length(buttons); i++) {
    buttons[i].vb.destroy();
}
