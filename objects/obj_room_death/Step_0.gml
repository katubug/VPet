// Spawn the dialog on the first Step instead of Create so the UI layer is ready.
if (!dialog_spawned && global.game.living == 0) {
    dialog_spawned = true;
    var _dlg = instance_create_layer(0, 0, "Instances", obj_dialog_modal);
    _dlg.message = "Your pet has been claimed by death. Do you want to try to revive them?";
    array_push(_dlg.buttons, { label: "omg yes", callback: function() {
        global.game.limbo = 1;
        room_goto(rm_rps);
    }});
    array_push(_dlg.buttons, { label: "nah im good", callback: function() {
        global.game.living = 1;
        global.game.limbo = 0;
        time_reset();
        reset_needs();
        var starter_pet = irandom_range(0, 2);
        if (starter_pet == 0) global.game.current_pet_type = "chobo";
        if (starter_pet == 1) global.game.current_pet_type = "pomba";
        if (starter_pet == 2) global.game.current_pet_type = "dodati";
        global.game.evolution_phase = "baby";
        room_goto(rm_initial);
    }});
}
