
if(games_on == 1){ 
    draw_text(x+0,y+0, string("Game Begin. Press R, P, or S."));
}

if(games_on != 1){
   if(var_result == "Draw")
   {
   	draw_text(0, 0, string("Draw") + "");
   }
   
   if(var_result == "Win")
   {
   	draw_text(0, 0, string("Win") + "");
   }
   
   if(var_result == "Lose")
   {
   	draw_text(0, 0, string("Lose") + "");
   }
    if (player_choice != -1){
        if (player_choice == 0) draw_sprite(spr_human_rock, 0, 0, 20)
        if (player_choice == 1) draw_sprite(spr_human_paper, 0, 0, 20)
        if (player_choice == 2) draw_sprite(spr_human_scissors, 0, 0, 20)        
    }
    
    if (computer_choice != -1){
        if (computer_choice == 0) draw_sprite(spr_death_rock, 0, 250, 20)
        if (computer_choice == 1) draw_sprite(spr_death_paper, 0, 250, 20)
        if (computer_choice == 2) draw_sprite(spr_death_scissors, 0, 250, 20)        
    }
}
