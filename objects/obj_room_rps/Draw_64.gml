if (round_number <=3) input_virtual_debug_draw();

draw_set_valign(fa_top);
draw_set_halign(fa_center);

var _gw = display_get_gui_width(); // use GUI width for Draw_64 positioning

if (round_number >=1){
    draw_set_halign(fa_left);
    draw_set_font(fnt_Quicksand);
    draw_text(25, 12, string("Player Score: ") + string(player_score))   // 100→25, 50→12
    draw_text(25, 18, string("Death Score: ") + string(computer_score))  // 100→25, 70→18
    draw_text(25, 23, string("Round Number: ") + string(round_number))   // 100→25, 90→23
    }

    if (game_complete == 1) {
        draw_set_halign(fa_center);
        draw_set_font(fnt_Quicksand_lrg);
        if (player_score > computer_score) draw_text(_gw / 2, 75, string("You have won your pet back!"));
        else if (player_score < computer_score) draw_text(_gw / 2, 75, string("You have unfortunately lost."));
        draw_set_font(fnt_Quicksand);
    }
if (!game_complete){
   if(result == "Draw")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(_gw / 2, 50, string("Draw - play another round"));
   }

   if(result == "Win")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(_gw / 2, 50, string("Win! Your score increased by 1."));
   }

   if(result == "Lose")
   {
    draw_set_halign(fa_center);
    draw_set_font(fnt_Quicksand);
   	draw_text(_gw / 2, 50, string("Lose! Death's score increased by 1."));
   }
}
