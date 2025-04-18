/// @description create_keyboard(x, y, id, callback, numeric_on, symbolic_on, key_x_scale, key_y_scale, key_x_off, key_y_off)
/// @param x
/// @param  y
/// @param  id
/// @param  callback
/// @param  numeric_on
/// @param  symbolic_on
/// @param  key_x_scale
/// @param  key_y_scale
/// @param  key_x_off
/// @param  key_y_off
function create_keyboard(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9) {

	destroy_keyboard();

	ins = instance_create_depth(argument0, argument1, 0, o_keyboard);
	ins.kparrent = argument2; //text field id must have inner variable myTXT
	ins.callback = argument3; //call back script after pressing OK can be   noone
	ins.numeric = argument4;
	ins.symbolic = argument5;
	ins.key_x_scale = argument6;
	ins.key_y_scale = argument7;
	ins.letterW = 60*argument6;
	ins.letterH = 80*argument7;
	ins.letterXoff = argument8*argument6;
	ins.letterYoff = argument9*argument7;
	ins.myState = 0;

	with(ins) event_user(0);
	with(ins) event_user(3);




}
