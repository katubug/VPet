if (round_number <=3) input_virtual_debug_draw();
    
draw_set_valign(fa_top);
draw_set_halign(fa_center);

if (round_number >=1){
    draw_set_halign(fa_left);
    draw_set_font(fnt_Quicksand);
    draw_text(100,50, string("Player Score: ") + string(player_score))
    draw_text(100,70, string("Death Score: ") + string(computer_score))
    draw_text(100,90, string("Round Number: ") + string(round_number))
    }

    if (game_complete == 1) {
        draw_set_halign(fa_center);
        draw_set_font(fnt_Quicksand_lrg);
        if (player_score > computer_score) draw_text(room_width/2,300, string("You have won your pet back!"));
        else if (player_score < computer_score) draw_text(room_width/2,300, string("You have unfortunately lost."));
        draw_set_font(fnt_Quicksand);
    }
if (!game_complete){
   if(result == "Draw")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(room_width/2, 200, string("Draw - play another round"));
   }
   
   if(result == "Win")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(room_width/2, 200, string("Win! Your score increased by 1."));
   }
   
   if(result == "Lose")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(room_width/2, 200, string("Lose! Death's score increased by 1."));
   }
}