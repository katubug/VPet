if (input_check_pressed("rock")) {
        destroy_sequences();
        player_choice = 0;
        round_end = true;
        round_end2 = true;
        
    }
    if (input_check_pressed("paper")) {
        destroy_sequences();
        player_choice = 1;
        round_end = true;
        round_end2 = true;
    }
    if (input_check_pressed("scissors")) {
        destroy_sequences();
        player_choice = 2;
        round_end = true;
        round_end2 = true;
    }

    if (player_choice !=-1)
        {
            computer_choice = irandom_range(0, 2);
          
          if (computer_choice == player_choice) {
            result = "Draw";
          }
          else {
          result = (computer_choice == (player_choice +1) mod 3)?"Lose":"Win"; 
            round_number++;
            if (result == "Win") player_score++;
            else if (result == "Lose") computer_score++;    
          } 
        }

if (game_complete == 1) {
    destroy_sequences();
    input_virtual_destroy_all();
        if (player_score > computer_score) {
            var _dlg = instance_create_layer(0, 0, "Instances", obj_dialog_modal);   
            _dlg.message    = "You have won your pet back!";                                                                                              _dlg.message = "What do you want to do?";
              array_push(_dlg.buttons, { label: "YAY",   callback: function() {
                global.game.living = 1;
                global.game.limbo = 0;
                room_goto(rm_main)
                 } });
            
        }
        else if (player_score < computer_score) {
            global.game.living = 1;
            global.game.limbo = 0;
            // Reset needs and set up the new egg BEFORE time_reset() so the save it writes
            // captures health=20 and evolution_phase="egg", not the dead pet's state.
            reset_needs();
            global.game.evolution_phase = "egg"; // Start a new egg instead of skipping straight to baby

            var starter_pet = irandom_range(0, 2);

                if (starter_pet == 0) global.game.current_pet_type = "chobo";
                if (starter_pet == 1) global.game.current_pet_type = "pomba";
                if (starter_pet == 2) global.game.current_pet_type = "dodati";

            time_reset();

             var _dlg = instance_create_layer(0, 0, "Instances", obj_dialog_modal);
            _dlg.message    = "I'm sorry, you lost and your pet has gone to heaven.";                                                                                               _dlg.message = "What do you want to do?";
              array_push(_dlg.buttons, { label: "Awwww",   callback: function() {
                    room_goto(rm_main); // Go straight to rm_main; obj_pet_spawner will create the egg
                } });

        }
    }

if (round_end == true && player_choice != -1){
        if (player_choice == 0) {
            round_end = false;
            player_rock = layer_sequence_create("Instances", room_width/2, 200, seq_player_rock);
            player_choice = -1;
            // Don't check round yet - wait for animation
        }
        if (player_choice == 1){
            round_end = false;
            player_paper = layer_sequence_create("Instances", room_width/2, 200, seq_player_paper);
            player_choice = -1;
            // Don't check round yet - wait for animation
        }
        if (player_choice == 2){
            round_end = false;
            player_scissors = layer_sequence_create("Instances", room_width/2, 200, seq_player_scissors);
            player_choice = -1;
            // Don't check round yet - wait for animation
        }       
    }
    
    if (round_end2 == true && computer_choice != -1){
        
        if (computer_choice == 0) {
            round_end2 = false;
            death_rock = layer_sequence_create("Instances", room_width/2, 200, seq_death_rock);
            
            // Check if game should end AFTER starting animation
            alarm[0] = 60; // Wait 1 second for animation, then check
        }
        if (computer_choice == 1){
            round_end2 = false;
            death_paper = layer_sequence_create("Instances", room_width/2, 200, seq_death_paper);
            
            // Check if game should end AFTER starting animation
            alarm[0] = 60; // Wait 1 second for animation, then check
        }
        if (computer_choice == 2){
            round_end2 = false;
            death_scissors = layer_sequence_create("Instances", room_width/2, 200, seq_death_scissors);
            
            // Check if game should end AFTER starting animation
            alarm[0] = 60; // Wait 1 second for animation, then check
        }          
    }