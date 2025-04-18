//symbolic keyboard

offX = letterXoff
offY = 0;


ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 50;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 51;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 48;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 49;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 43;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 55;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 58;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 64;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 56;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0,o_letter);
ins.myLetter = 61;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = letterXoff + 2*letterW/3;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 45;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 39;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 54;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 65;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 46;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 66;
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

