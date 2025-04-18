offX = 0;
offY = 2*(letterH + letterYoff);

if((myState==0 || myState==1) && symbolic==true) ins = instance_create_depth(x+offX, y+offY, 0, o_symbols);
if(myState==2 && numeric==true) ins = instance_create_depth(x+offX, y+offY, 0, o_numeric);

with(ins) parrent = other.id;

offX+=9*(letterW + letterXoff) - letterXoff;

ins = instance_create_depth(x+offX, y+offY, 0, o_back);
with(ins) parrent = other.id;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = letterW;

if(myState==0 && numeric==true) ins = instance_create_depth(x+offX, y+offY, 0, o_numeric2);
if(myState==1 || myState==2) ins = instance_create_depth(x+offX, y+offY, 0, o_alpha);
with(ins) parrent = other.id;
offX+=2*letterW + letterXoff;

ins = instance_create_depth(x+offX, y+offY, 0, o_space);
with(ins) parrent = other.id;

offX+=4*letterW + letterW/3 + letterXoff;

ins = instance_create_depth(x+offX, y+offY, 0, o_ok);
with(ins) parrent = other.id;

with(o_k_button)
{
  image_xscale = parrent.key_x_scale;
  image_yscale = parrent.key_y_scale;
}

