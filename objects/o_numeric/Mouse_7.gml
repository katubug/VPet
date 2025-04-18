event_inherited();

with(o_k_button)
{
  if(id!=other.id) instance_destroy();
}

with(parrent) 
{
  myState = 1;
  event_user(1);
  event_user(3);
}

instance_destroy();



