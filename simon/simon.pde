/*
Program: Simon
Author:  Nicholas Mullikin
Date:    1/8/14
Notes:   Clicking sometimes does not register on screen.
        Also occasionally when displaying the sequence an additional noise can be heard at the end. 
Sometimes is flashed the buttons.


*/
import arb.soundcipher.*;

SoundCipher sc = new SoundCipher(this);


char[] charSequence = new char [100];
char[] userSequence = new char [100];

color red = color (155,0,0);
color bred = color (255,0,0);
color green = color (0,155,0);
color bgreen = color (0,255,0);
color blue = color (0,0,155);
color bblue = color (0,0,255);
color yellow = color (155,155,0);
color byellow = color (255,255,0);
color white = color (255,255,255);
color purple = color (255,0,255);
color lblue = color (0,255,255);
color orange = color(255,128,0);

float oldFramecount;
char col = ' ';

int rand = (int)random(50,100);
int stage = 0;
int i=0;
int roundCount = 1;
int termCount = 0;
int g = 0;
int userCount = 0;

int play = 1;
float z;

void setup()
{
 size(400,400); 
  noStroke();
  sc.instrument(100);
  charSequence = newChar(100);
  for (int h = 0; h < userSequence.length; h++)
  {
   userSequence[h]='0'; 
  }
  textSize(11);

}
void draw()
{

  
  
if (stage == 0)
  {
  playnote(); 
  circles();
  if (frameCount-oldFramecount > 60)
  {col = ' ';}
  }

if (stage == 1)
{
//col = ' ';
  reset(userSequence);
  userCount= 0;
  if (frameCount-oldFramecount > 90)
      {  
      oldFramecount=frameCount;
      i++;
      col=charSequence[i];
      
      }
//  if (roundCount == 1)
//    {
//    col=charSequence[0];
//    }
  
  playnote(); 
  circles();
  
  if ((i)==roundCount+1)
  {
    stage=2; 
  }



}///////////////////// end of stage 1


if (stage == 2)  
{
playnote(); 
circles();
oldFramecount=frameCount;
if (frameCount-oldFramecount<60)
{
col = ' ';
}
} ///////////////// end of stage 2
 
if (stage == 3)
{
  fill(100,10);
  rect(0,0,400,400);
  textSize(64);
  fill(0);
  text("You Lose",60,200);
  textSize(32);
  text("Your score is:",80,250);
  text(roundCount,320,250);

}
 
 
if (stage ==4)
{
 z = random(4); 
 if (z<1){
   col = 'r';
 }
 else if (z<2){
   col = 'y';
 }
 else if (z<3){
   col = 'g';
 }
 else if (z<4){
   col=  'b';
 }
 circles();
}


if (col == 'w')
{
  stage = 1; 
  i = 0;
  charSequence = newChar(100);
  roundCount = 1;
}
String thing = new String(userSequence);
String thing1 = new String(charSequence);
println("stage: "+stage+" |i: "+i+" |roundCount: "+roundCount+" |oldFramecount: "+oldFramecount+" |Framecount: "+frameCount+" |userCount "+userCount);
println(thing);
//println(thing1.substring(1));    order is here

}////////////////////////////////////////////////////////////////////////////////////////////////////////////end of draw



void mouseClicked()
{
  
int h;
for (h = 0; h < userSequence.length; h++)
print(userSequence[h]);
if ((h +1) == userSequence.length)
{
 print("\n"); 
}

if (get(mouseX,mouseY) == lblue)
{
  stage = 4; 
} 


if (get(mouseX,mouseY) == white)
{
  stage = 1; 
  i = 0;
  charSequence = newChar(100);
  roundCount = 1;
} 
if (get(mouseX,mouseY) == purple)
{
  stage = 1; 
  i = 0;
  //charSequence = newChar(100);
  roundCount = 1;
}

  for (int d = 0; d < charSequence.length; d++)
    {
    print(charSequence[d]);
    }
    
  if ((get(mouseX,mouseY) == orange) )
    {
    play*=-1;
    }
    
  if ((get(mouseX,mouseY) == white) )
    {
    col = 'w' ;
    }
  else if ((get(mouseX,mouseY) == purple) )
    {
    col = 'p' ;
    }
  else if ((get(mouseX,mouseY) == lblue) )
    {
    col = 'l' ;
    }
 
 
if (stage == 0)
  {
  oldFramecount=frameCount;
  if ((get(mouseX,mouseY) == red))
    {
    col = 'r' ;
    }
  else if ((get(mouseX,mouseY) == green) )
    {
    col = 'g' ;
    }
  else if ((get(mouseX,mouseY) == blue))
    {
    col = 'b' ;
    }
  else if ((get(mouseX,mouseY) == yellow))
    {
    col = 'y' ;
    }
  
  //println(col);
  }
  /////////////////////////////////stage 0


else if (stage == 1)
  {
  //reset(userSequence);
  }
  ////////////////////////////////stage 1
else if (stage == 2)
  {
    oldFramecount = frameCount;
    
    if ((get(mouseX,mouseY) == red))
    {
    col = 'r' ;
    userCount++;
    }
  else if ((get(mouseX,mouseY) == green) )
    {
    col = 'g' ;
    userCount++;
    }
  else if ((get(mouseX,mouseY) == blue))
    {
    col = 'b' ;
    userCount++;
    }
  else if ((get(mouseX,mouseY) == yellow))
    {
    col = 'y' ;
    userCount++;
    }
    
  
  userSequence[userCount-1] = col;
   
  if (checkChar(charSequence,userSequence,userCount) == true && userCount == roundCount)
  { 
  i = 0;
  roundCount++;
  stage = 1;
  //reset(userSequence);
  }
  else if(userCount==roundCount)
  {
    stage = 3;
    
  //reset(userSequence);
  }
  }
  ////////////////////////////////////////////stage 2
  else if(stage==3)
  {
  i=0;
  roundCount = 1;
  termCount = 0;
  g = 0;
  stage = 0;
  reset(userSequence);
  userCount = 0;
  }
  
}////////////////////////////////////////////////////////////////////////////////////////////////////////////end of mouseClicked


void playnote()
{
if (play == 1)
{
  if (col == 'r')
  {sc.playNote(0, 4, 90,50,127,2,0.5,63);}
  
  if (col == 'g')
  {sc.playNote(0, 4, 90,55,127,2,0.5,63);}
  
  if (col == 'b')
  {sc.playNote(0, 4, 90,60,127,2,0.5,63);}
  
  if (col == 'y')
  {sc.playNote(0, 4, 90,65,127,2,0.5,63);}
}
}
void flash(char col)
{
//oldFramecount=frameCount;

fill(red); 
if (col == 'r')
  {fill(bred);}
arc(200,200,400,400,0, HALF_PI);

fill(green);
if (col == 'g')
  {fill(bgreen);}
arc(200,200,400,400,HALF_PI, PI);

fill(blue);
if (col == 'b')
  {fill(bblue);}
arc(200,200,400,400, HALF_PI+PI,TWO_PI);

fill(yellow);
if (col == 'y')
  {fill(byellow);}
arc(200,200,400,400,PI, PI+HALF_PI);


}

void circles()
{
  background(150);
  fill(0);
  ellipse(200,200,420,420);
  flash(col);
  fill(0);
  ellipse(200,200,150,150);
  rect(0,190,400,20);
  rect(190,0,20,400);
  fill(purple);
  ellipse(170,230,40,40);
  fill(lblue);
  ellipse(230,230,40,40);
  fill(white);
  ellipse(200,160,40,40);
  fill(orange);
  ellipse(200,200,30,30);
  fill(0);
  textSize(11);
  text("New\nGame",185,156);
  text("Last\nGame",155,226);
  text("Some\nThing",215,226);
  textSize(7);
  text("Sound\nOff",190,196);
}

char[] newChar(int x)
{
  char[] sequence = new char [x];
  for(int i = 0; i < sequence.length; i++)
  {
   float z = random(4); 
   if (z<1){
     sequence[i] = 'r';
   }
   else if (z<2){
     sequence[i] = 'y';
   }
   else if (z<3){
     sequence[i] = 'g';
   }
   else if (z<4){
     sequence[i] = 'b';
   }
    
    
    
  }
  return sequence;
  
}
boolean checkChar(char a[], char b[], int c)
{
 for (int e = 0; e < c; e++) 
  {
   if (a[e+1]!=b[e])
  {
   return false;
  } 
  }
  return true;
}
void reset(char a[])
{
 for (int h = 0; h < a.length; h++)
  {
   a[h] = '0'; 
  } 
  
  
}
