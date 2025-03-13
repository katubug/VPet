
if(games_on == 1){ 
    draw_text(x+0,y+0, string("Game Begin. Press R, P, or S."));
}

if(games_on != 1)
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
