/// @description Execute Code
var _hor = clamp(target_x - x, -1, 1);
var _ver = clamp(target_y - y, -1, 1);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap);

if (target_x != 0 && target_y != 0){
    if (target_x > x) {
        sprite_index = spr_chimchee_walk_right;}
    else if (target_x < x) {
        sprite_index = spr_chimchee_walk_left;   }
}
else
{
    if (sprite_index == spr_chimchee_walk_left){
     sprite_index = spr_chimchee_idle_left;}
    else if (sprite_index == spr_chimchee_walk_right) {
    sprite_index = spr_chimchee_idle_right;}
}