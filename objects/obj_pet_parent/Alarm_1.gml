//A script to control the pet's movement when it is able to walk
if (can_walk){
target_x = random_range(20, 160); //coordinates where it's safe to walk
target_y = random_range(185, 272); //TODO: un-hardcode these
walking = true;
}
alarm[1] = 300;
