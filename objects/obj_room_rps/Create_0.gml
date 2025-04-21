player_choice = -1;
computer_choice = -1;
player_score = 0;
computer_score = 0;
round_number = 1;
game_on = 0;
result = 0;
_game_complete = 0;
round_end = false;
round_end2 = false;

button_width = 100;
button_height = 50;
button_y = 460
rock_button_x = 50;
paper_button_x = rock_button_x + button_width + 20;
scissors_button_x = paper_button_x + button_width + 20;

player_rock = undefined;
player_scissors = undefined;
player_paper = undefined;

death_rock = undefined;
death_scissors = undefined;
death_paper = undefined;

vb_rock = input_virtual_create()
    .rectangle(rock_button_x, button_y, rock_button_x + button_width, button_y + button_height)
    .button("rock");

vb_paper = input_virtual_create()
    .rectangle(paper_button_x, button_y, paper_button_x + button_width, button_y + button_height)
    .button("paper");

vb_scissors = input_virtual_create()
    .rectangle(scissors_button_x, button_y, scissors_button_x + button_width, button_y + button_height)
    .button("scissors");

destroy_sequences = function(){
    if (layer_sequence_exists("Instances", player_rock) == true) {
            layer_sequence_destroy(player_rock);
          }
    if (layer_sequence_exists("Instances", player_paper) == true) {
            layer_sequence_destroy(player_paper);
          }
    if (layer_sequence_exists("Instances", player_scissors) == true) {
            layer_sequence_destroy(player_scissors);
          }
    if (layer_sequence_exists("Instances", death_rock) == true) {
            layer_sequence_destroy(death_rock);
          }
    if (layer_sequence_exists("Instances", death_paper) == true) {
            layer_sequence_destroy(death_paper);
          }
    if (layer_sequence_exists("Instances", death_scissors) == true) {
            layer_sequence_destroy(death_scissors);
          }
}