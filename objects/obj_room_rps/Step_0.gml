if(game_on == 1){

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
            game_on = 0;
            result = "Draw";
          }
          else {
          result = (computer_choice == (player_choice +1) mod 3)?"Lose":"Win"; 
            game_on = 0;
            round_number++;
            if (result == "Win") player_score++;
            else if (result == "Lose") computer_score++;    
          } 
        }
}

if (_game_complete == 1) {
        if (player_score > computer_score) {
            global.game.living = 1;
            room_goto(rm_main);
        }
        else if (player_score < computer_score) {
            time_reset();
            var starter_pet = irandom_range(0, 2);
            
                if (starter_pet == 0) global.game.current_pet_type = "chobo";
                if (starter_pet == 1) global.game.current_pet_type = "pomba";
                if (starter_pet == 2) global.game.current_pet_type = "dodati";
            
            room_goto(rm_initial);
        }
    }

if (round_end == true && player_choice != -1){
        if (player_choice == 0) {
            round_end = false;
            player_rock = layer_sequence_create("Instances", room_width/2, 200, seq_player_rock);
        }
        if (player_choice == 1){
            round_end = false;
            player_paper = layer_sequence_create("Instances", room_width/2, 200, seq_player_paper);
        }
        if (player_choice == 2){
            round_end = false;
            player_scissors = layer_sequence_create("Instances", room_width/2, 200, seq_player_scissors);
        }       
    }
    
    if (round_end2 == true && computer_choice != -1){
        
        if (computer_choice == 0) {
            round_end2 = false;
            death_rock = layer_sequence_create("Instances", room_width/2, 200, seq_death_rock);
        }
        if (computer_choice == 1){
            round_end2 = false;
            death_paper = layer_sequence_create("Instances", room_width/2, 200, seq_death_paper);
        }
        if (computer_choice == 2){
            round_end2 = false;
            death_scissors = layer_sequence_create("Instances", room_width/2, 200, seq_death_scissors);
        }          
    }



