if(game_on == 1){

    if (input_check_pressed("rock")) player_choice = 0;
    if (input_check_pressed("paper")) player_choice = 1;
    if (input_check_pressed("scissors")) player_choice = 2;
  
  
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

