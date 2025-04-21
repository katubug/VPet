input_virtual_debug_draw();
draw_set_valign(fa_top);
draw_set_halign(fa_center);

if (round_number >=1){
    draw_set_halign(fa_left);
    draw_text(100,50, string("Player Score: ") + string(player_score))
    draw_text(100,70, string("Death Score: ") + string(computer_score))
    draw_text(100,90, string("Round Number: ") + string(round_number))
    }

if(game_on == 1){
    draw_set_halign(fa_center);
    draw_text(x+0,y+0, string("Game Begin. Press R for Rock, P for Paper, or S for Scissors."));
    
}

if(game_on != 1){
    
    if (_game_complete == 1) {
        draw_set_halign(fa_center);
        draw_set_font(fnt_Quicksand_lrg);
        if (player_score > computer_score) draw_text(x+0,y+50, string("You have won your pet back!"));
        else if (player_score < computer_score) draw_text(x+0,y+50, string("You have unfortunately lost."));
        
    }
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
    //if (player_choice != -1){
        //if (player_choice == 0) {
            //layer_sequence_create("Instances", room_width/2, 200, seq_player_rock)
        //}
        //if (player_choice == 1) draw_sprite(spr_human_paper, 0, -70, 200)
        //if (player_choice == 2) draw_sprite(spr_human_scissors, 0, -70, 200)        
    //}
    //
    //if (computer_choice != -1){
        //if (computer_choice == 0) draw_sprite(spr_death_rock, 0, 300, 200)
        //if (computer_choice == 1) draw_sprite(spr_death_paper, 0, 300, 200)
        //if (computer_choice == 2) draw_sprite(spr_death_scissors, 0, 300, 200)        
    //}
}
