//alphabet keyboard

offX = letterXoff
offY = 0;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 16;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 22;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 4;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 17;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 19;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 24;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 20;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 8;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 14;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 15;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = letterXoff + 2*letterW/3;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 0;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 18;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 3;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 5;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 6;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 7;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 9;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 10;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 11;
offX+=letterW + letterXoff;

offY += letterH + letterYoff;
offX = 2*letterW + letterXoff;

ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 25;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 23;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 2;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 21;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 1;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 13;
offX+=letterW + letterXoff;
ins = instance_create_depth(x+offX, y+offY, 0, o_letter);
ins.myLetter = 12;
offX+=letterW + letterXoff;

with(o_letter)
{
  parrent = other.id;
  event_user(0);  
}

offX = 0;
offY = 0;



