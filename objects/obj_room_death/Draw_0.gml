var temp_petIsDead = global.petIsDead;

if(temp_petIsDead == 1){	draw_text(x + 0, y + 0, string("Your pet has been claimed by death.") + string("Do you want to try reclaim them?"));

	instance_create_layer(x + 0, y + 40, "Instances", obj_btn_death_yes);

	instance_create_layer(x + 60, y + 40, "Instances", obj_btn_death_no);}

else{	draw_text(x + 0, y + 0, string("How on earth did you get here?") + "");}