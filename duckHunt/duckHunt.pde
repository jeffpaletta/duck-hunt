/* Duck Hunt Prototype 1 */

class MovingSprite
{
   float x, y ;
   float xVel, yVel ;
   PImage theImage;
   float msWidth, msHeight ;
   boolean isHidden ;

   MovingSprite(float inX, float inY)
   {
     xVel = random(10) ;
     yVel = random(10) ;
     theImage = loadImage("duck50.png");
     x = inX ;
     y = inY ;
     isHidden = false ;
   }
   
   void setIsHidden(boolean inValue) { isHidden = inValue;}
   // getter
   float getX() { return (x) ;}
   float getY() { return (y) ; }
   boolean getIsHidden() { return isHidden ;}  // return true if hidden
   boolean isVisible() {  return !isHidden ;}
   
   void updateLocation()
   {
     x = x + xVel ;
     y = y + yVel ;
     if ( (x <=0) ||  ( (x+50) >= width)   )
       xVel = xVel * -1 ;
     if (  (y <= 0) || ( (y+50) >= height)  )
       yVel = yVel * -1 ;
   }
   void drawSprite()
   {
     if (!isHidden)
       image(theImage,x,y) ;
   }
   boolean containsPoint(float inPx, float inPy)
   {
      if ( (inPx > x) && (inPx < (x + 50) ) && (inPy > y) && (inPy < (y+50) ) )
        return (true) ; 
      else
        return(false) ;
   }
}

MovingSprite[] ducks;
int NUMDUCKS=10;
int numNotHidden ;
String output1 = "YOU WIN!";
String output2 = "You lose.";

Timer timer ;

void setup()
{
  size(800,800) ;
  timer = new Timer(10,60,60) ;
  timer.start() ;
  numNotHidden = 10 ;
  ducks = new MovingSprite[NUMDUCKS];
  for(int i=0;i<NUMDUCKS;i++)
  {
    ducks[i]=new MovingSprite(random(700), 700);
  }
}

void draw()
{
  if((timer.currentTime()>0)&&(numNotHidden>0))
  {
    background(0,0,255) ;
    timer.DisplayTime() ;
    fill(0,255,0);
     rect(0,600,800,200);
     for(int i=0;i<NUMDUCKS;i++)
     {
      ducks[i].updateLocation() ;
      ducks[i].drawSprite() ;
     }
  }
  if((timer.currentTime()>0)&&(numNotHidden==0))
  {
    background(0);
    fill(0,0,255);
    text(output1,300,400) ;
  }
  if((timer.currentTime()<=0)&&(numNotHidden>0))
  {
    background(0);
    fill(255,0,0);
    text(output2,300,400) ;
  }
}


void mousePressed()
{
  for(int i=0;i<NUMDUCKS;i++)
  {
  if (  ducks[i].isVisible()  && ducks[i].containsPoint(mouseX,mouseY) )
  {
    ducks[i].setIsHidden(true) ;
    numNotHidden -= 1 ;
  }
  }
  println(numNotHidden) ;
  if (numNotHidden == 0)
    println("rip") ;
}
