//numeric keyboard

offX = letterXoff
offY = 0;


ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 27;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 28;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 29;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 30;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 31;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 32;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 33;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 34;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 35;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 26;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = letterXoff + 2*letterW/3;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 45;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 62;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 42;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 63;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 52;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 53;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 41;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 36;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 47;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = 2*letterW + letterXoff;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 44;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 59;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 60;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 67;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 37;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 40;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 57;
offX+=letterW + letterXoff;

with(o_letter)
{
  parrent = other.id;
  event_user(0);
}

offX = 0;
offY = 0;



