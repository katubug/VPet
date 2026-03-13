if(global.game.living == 0)
{
    var _dlg = instance_create_layer(0, 0, "UI", obj_dialog_modal);
    _dlg.message    = "Your pet has been claimed by death. Do you want to try to revive them?";
    _dlg.on_confirm = function() {
        global.game.limbo = 1;
        room_goto(rm_rps)
        };
    _dlg.on_cancel  = function() { 
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
    };
}

else
{
	draw_text(x + 0, y + 0, string("How on earth did you get here?"));
}