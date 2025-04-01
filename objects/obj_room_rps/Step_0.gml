if(game_on == 1){

  if (keyboard_check_pressed(ord("R"))) {
  	player_choice = 0;
  }
  
  if (keyboard_check_pressed(ord("P"))) {
  	player_choice = 1;
  }
  
  if (keyboard_check_pressed(ord("S"))) {
  	player_choice = 2;
  }
  
    if (player_choice !=-1)
    {
        computer_choice = irandom_range(0, 2);
      
      if (computer_choice == player_choice) {
        game_on = 0;
        var_result = "Draw";
      }
      else {
      var_result = (computer_choice == (player_choice +1) mod 3)?"Lose":"Win"; 
        game_on = 0;
        round_number++;
        if (var_result == "Win") player_score++;
        else if (var_result == "Lose") computer_score++;    
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
            room_goto(rm_initial);
        }
    }

