//A script to control the pet's movement when it is able to walk
if (can_walk){
target_x = random_range(xstart - 50, xstart + 50);
target_y = random_range(ystart - 50, ystart + 50);
walking = true;
}
alarm[1] = 300;
