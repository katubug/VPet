if(games_on == 1){

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
        games_on = 0;
        var_result = "Draw";
      }
      else {
      var_result = (computer_choice == (player_choice +1) mod 3)?"Lose":"Win"; 
        games_on = 0;
        round_number++;
        if (var_result == "Win") player_score++;
        else if (var_result == "Lose") computer_score++;    
      } 
    }
}