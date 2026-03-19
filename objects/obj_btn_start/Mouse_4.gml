// Block the click entirely if name entry is still open -- mouse events fire before Step,
// so visibility alone can't prevent this from triggering on the same frame
if (instance_exists(obj_name_entry)) exit;

sprite_index = spr_btn_start_pressed;

if(room == rm_initial)
{
    room_goto(rm_main)
}