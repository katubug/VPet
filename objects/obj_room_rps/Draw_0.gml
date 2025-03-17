if (round_number >=1){
    draw_text(100,50, string("Player Score: ") + string(player_score))
    draw_text(100,70, string("Death Score: ") + string(computer_score))
    draw_text(100,90, string("Round Number: ") + string(round_number))
    }

if(games_on == 1){ 
    draw_text(x+0,y+0, string("Game Begin. Press R for Rock, P for Paper, or S for Scissors."));
}

if(games_on != 1){
    
    if (_game_complete == 1) {
        if (player_score > computer_score) draw_text(x+0,y+50, string("You have won your pet back!")+ "");
        else if (player_score < computer_score) draw_text(x+0,y+50, string("You have unfortunately lost.")+ "");
        
    }
   if(var_result == "Draw")
   {
   	draw_text(0, 0, string("Draw ") + string("- play another round"));
   }
   
   if(var_result == "Win")
   {
   	draw_text(0, 0, string("Win! ") + string("Your score increased by 1."));
   }
   
   if(var_result == "Lose")
   {
   	draw_text(0, 0, string("Lose! ") + string("Death's score increased by 1."));
   }
    if (player_choice != -1){
        if (player_choice == 0) draw_sprite(spr_human_rock, 0, -70, 200)
        if (player_choice == 1) draw_sprite(spr_human_paper, 0, -70, 200)
        if (player_choice == 2) draw_sprite(spr_human_scissors, 0, -70, 200)        
    }
    
    if (computer_choice != -1){
        if (computer_choice == 0) draw_sprite(spr_death_rock, 0, 300, 200)
        if (computer_choice == 1) draw_sprite(spr_death_paper, 0, 300, 200)
        if (computer_choice == 2) draw_sprite(spr_death_scissors, 0, 300, 200)        
    }
}
