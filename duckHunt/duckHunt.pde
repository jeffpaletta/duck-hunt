/* Duck Hunt Version 8*/
////////////////////////////////////////////////////////////

//import processing.sound.*;

import ddf.minim.*;
//import ddf.minim.analysis.*;
//import ddf.minim.effects.*;
//import ddf.minim.signals.*;
//import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import javax.swing.JOptionPane; 

import java.io.FileWriter;
import java.io.BufferedWriter;


String[] data;
String joinedData;

// $
String outFilename = "data.txt";

PFont font;

int maxLevel = 0;

int numUsersMore;
int numUsersLess;
int numUsersEqual;

int convertJoinedData;

int dataCounter1; 
int dataCounter2; 
int dataCounter3; 
int dataCounter4; 
int dataCounter5; 
int dataCounter6; 
int dataCounter7; 
int dataCounter8; 

PImage background0;
PImage background1;
PImage background2;
PImage background3;
PImage background4;
PImage background5;
PImage background6;
PImage background7;

//SoundFile gunshot;
//SoundFile targetHit1;

Minim minim;
Delay delay;
AudioPlayer gunshot;
AudioPlayer targetHit1;
AudioPlayer gunReload;

PImage target1;
PImage target2;
PImage target3;
PImage target4;
PImage target5;
PImage target6;
PImage target7;

PImage targethit1;
PImage targethit2;
PImage targethit3;
PImage targethit4;
PImage targethit5;
PImage targethit6;
PImage targethit7;


PImage shotgun;
PImage bullet;
PImage specialtarget1;
PImage duckhuntingbeginningscreen;
PImage explosion;
int state=2, level = 1, numBullets = 5, lastClear = 0, lastReload = 0, levelFrame = 0, lives = 5, score, highscore, timeLeft;
boolean dead = false;
boolean shoot = false;
boolean specialtargethit = false;
Object[] options = {"Yes", "No"};




///////////////////////////////////////////////////////////////////////////////////////////////


void setup() {

  size(1920, 1080);
  noCursor();
  
  
  background0 = loadImage("welcome.jpg");
  background1 = loadImage("bg1.jpg");
  background2 = loadImage("bg2.jpg");
  background3 = loadImage("bg3.jpg");
  background4 = loadImage("bg4.jpg");
  background5 = loadImage("bg5.jpg");  
  background6 = loadImage("bg6.jpg");  
  background7 = loadImage("bg7.jpg");  


  target1 = loadImage("target1.png");
  target2 = loadImage("target2.png");
  target3 = loadImage("target3.png");
  target4 = loadImage("target4.png");
  target5 = loadImage("target5.png");
  target6 = loadImage("target6.png");
  target7 = loadImage("target7.png");

  targethit1 = loadImage("targethit1.png");
  targethit2 = loadImage("targethit2.png");
  targethit3 = loadImage("targethit3.png");
  targethit4 = loadImage("targethit4.png");
  targethit5 = loadImage("targethit5.png");
  targethit6 = loadImage("targethit6.png");
  targethit7 = loadImage("targethit7.png");

  //specialtarget1 = loadImage("student.png");
  specialtarget1 = target1;

  shotgun = loadImage("crosshair.png");
  bullet = loadImage("bullet.png");
  duckhuntingbeginningscreen = loadImage("duckhuntingbeginningscreen.jpg");
  explosion = loadImage("explosion.png");

  //gunshot = new SoundFile(this, "gunshot.mp3");
  //targetHit1 = new SoundFile(this, "targetHit1.mp3");

  minim = new Minim(this);
  delay = new Delay(1, 1);

  gunshot = minim.loadFile("gunshot.mp3");
  targetHit1 = minim.loadFile("targetHit1.mp3");
  gunReload = minim.loadFile("reload.wav");

  
    
  
  data = loadStrings("data.txt");
  joinedData = join(data, " ");
  //convertJoinedData = Integer.parseInt(joinedData);
  
  dataCounter1 = 0; 
  dataCounter2 = 0; 
  dataCounter3 = 0; 
  dataCounter4 = 0; 
  dataCounter5 = 0; 
  dataCounter6 = 0; 
  dataCounter7 = 0; 
  dataCounter8 = 0;
  
  numUsersMore = 0;
  numUsersLess = 0;
  numUsersEqual = 0;
  
  //for (int i = 0; i < joinedData.length(); i++) {
  //  if (joinedData.charAt(i) == '1') { dataCounter1++; }
  //  else if (joinedData.charAt(i) == '2') { dataCounter2++; }
  //  else if (joinedData.charAt(i) == '3') { dataCounter3++; }
  //  else if (joinedData.charAt(i) == '4') { dataCounter4++; }
  //  else if (joinedData.charAt(i) == '5') { dataCounter5++; }
  //  else if (joinedData.charAt(i) == '6') { dataCounter6++; }
  //  else if (joinedData.charAt(i) == '7') { dataCounter7++; }
  //  else if (joinedData.charAt(i) == '8') { dataCounter8++; }
  //  else {}
  //}
  
    for (int i = 0; i < convertJoinedData.length(); i++) {
    if (convertJoinedData.charAt(i) == maxLevel) { numUsersEqual++; }
    else if (convertJoinedData.charAt(i) > maxLevel) { numUsersMore++; }
    else if (convertJoinedData.charAt(i) < maxLevel) { numUsersLess++; }
    //else if (joinedData.charAt(i) == '3') { dataCounter3++; }
    //else if (joinedData.charAt(i) == '4') { dataCounter4++; }
    //else if (joinedData.charAt(i) == '5') { dataCounter5++; }
    //else if (joinedData.charAt(i) == '6') { dataCounter6++; }
    //else if (joinedData.charAt(i) == '7') { dataCounter7++; }
    //else if (joinedData.charAt(i) == '8') { dataCounter8++; }
    else {}
  }
    noCursor();

}


///////////////////////////////////////////////////////////////////////////////////////////////


class Target {
  boolean flip = false;
  boolean bull = false;
  boolean shot = false;
  float vx;
  float xTarget, yTarget;
  float murpx, murpy;
  int count = 0;
  Target(int x, int y, boolean toflip) {
    flip = toflip;
    xTarget = x;
    vx=level;
    yTarget = y;
  }
  
  
  void display() {

    if (flip) { 
      pushMatrix();
      if (shot)image(targethit1, xTarget, yTarget);
      else { 
        scale(-1.0, 1.0);
        image(target1, -xTarget, yTarget);
        scale(-1.0, 1.0);
      }
      popMatrix();
      xTarget-=vx;
    } else {
      pushMatrix();
      if (shot)image(targethit1, xTarget, yTarget);
      else image(target1, xTarget, yTarget);
      popMatrix();
      xTarget+=vx;
    }
    if (shot)yTarget+=15;

    if (shot&&count<20) {
      count++;
      vx=0;
      image(explosion, murpx, murpy);
    }
  }
}


class specialTarget {
  boolean flip = false;
  boolean shot = false;
  float vx;
  float xTarget1, yTarget1;
  specialTarget(int x, int y) {
    xTarget1 = x;
    vx=level*2;
    yTarget1 = y;
  }
  
  
  void display() {
    if (shot) {
      yTarget1+=15;
      vx=0;
    }
    if (flip) { 
      pushMatrix();
      scale(-1.0, 1.0);
      image(specialtarget1, -xTarget1, yTarget1);
      popMatrix();
      xTarget1-=vx;
    } else {
      pushMatrix();
      image(specialtarget1, xTarget1, yTarget1);
      popMatrix();
      xTarget1+=vx;
    }
  }
}


ArrayList <Target> targets = new ArrayList<Target>();
ArrayList <specialTarget> targets1 = new ArrayList<specialTarget>();
//ArrayList<PImage> images = new ArrayList<PImage>();
//images.add(loadImage("thefile.png"));
//images.add(loadIMage("asdfasdf"));
//PImage bla = images.get(0);ad
//image(images.get(0),  123, 234 );
ArrayList <PImage> bullets = new ArrayList<PImage>(); 



///////////////////////////////////////////////////////////////////////////////////////////////


void draw() {

  //println("level: " + level + "       Max Level:" + maxLevel);
  
  
  
  println(dataCounter1);
  
  
  
  
  
  
  if (level > maxLevel) {
    maxLevel = level;
  }

  if (state == 0) {
    timeLeft=(int)(60-(((frameCount-levelFrame)%1200)/60));
    if (lives<=0) {
      background(255, 0, 0);
      textSize(50);
      text("you lose?", width/2+125, height/2);
      lives=0;
      if (keyPressed) {
        targets.clear();
        score = 0;
        lives = 5;
        numBullets = 6;
        level = 1;
        levelFrame=0;
        lastReload = 0;
        lastClear = 0;
        frameCount = 0;
        specialtargethit= false;
        targets1.get(0).vx=level*2;
        //println(maxLevel);
      }
    } else {
      if (frameCount%(120-(10*level))==0) {
        int derpx;
        int derpy = (int)random(0, 500);
        boolean derpsplit;
        if (random(0, 2)>1) {
          derpx=1920;
          derpsplit = true;
        } else {
          derpx=0;
          derpsplit = false;
        }
        targets.add(new Target(derpx, derpy, derpsplit));
      }
      if (level==1) {
        image(background1, 0, 0);
      } else if (level==2) {
        image(background2, 0, 0);
        targethit1 = targethit2;
        target1 = target2;
        specialtarget1 = target2;
      } else if (level==3) {
        image(background3, 0, 0);
        target1 = target3;
        targethit1 = targethit3;
        specialtarget1 = target3;
      } else if (level==4) {
        image(background4, 0, 0);
        target1 = target4;
        targethit1 = targethit4;
        specialtarget1 = target4;
      } else if (level==5) {
        image(background5, 0, 0);
        target1 = target5;
        targethit1 = targethit5;
        specialtarget1 = target5;
      } else if (level==6) {
        image(background6, 0, 0);
        target1 = target6;
        targethit1 = targethit6;
        specialtarget1 = target6;
      } else {
        image(background7, 0, 0);
        target1 = target7;
        targethit1 = targethit7;
        specialtarget1 = target7;
      }

      if ((frameCount-levelFrame)%1200==1080) {
        targets1.add(new specialTarget(0, (int)random(50, height-50)));
      }
      if ((frameCount-levelFrame)%1200>1080) {
        if (targets1.size()>0) {
          targets1.get(0).display();
          if (specialtargethit==false&&mousePressed&&dist(mouseX, mouseY, targets1.get(0).xTarget1, targets1.get(0).yTarget1)<60&&lives>0) {
            specialtargethit=true;
            score+=level*10;
            targets1.get(0).shot=true;
          }
        }
      }
      for (int i=0; i<targets.size(); i++) {
        targets.get(i).display();
        if (targets.get(i).bull) {
          fill(0);
          text("Bullseye!", targets.get(i).xTarget, targets.get(i).yTarget);
        }
        if (1920<targets.get(i).xTarget||targets.get(i).xTarget<0) {
          //lives--;
          targets.remove(i);
        }
      }
      if (score>=highscore) {
        highscore=score;
      }
      image(shotgun, mouseX-348, mouseY-205);
      if ((frameCount - levelFrame)%1200==0) {
        state = 1;
      }
      fill(255);
      textSize(24);
      textAlign(RIGHT);
      text("score: "+score, width-10, 50);
      text("lives: "+lives, width-10, 70);
      //text("highscore: "+highscore, width-10, 30);
      text("Time Left: "+timeLeft, width-10, 90);
      textAlign(LEFT);
      image(bullet, 0, 540);
      //text("Bullets: "+numBullets, 10, 590);
      for (int j = 0; j < numBullets; j++) {
        if (state==0) {
          image(bullet, j*10+10, 540);
        }
      }
    }
  }
  if (state == 2) {
    background(0); 
    image(duckhuntingbeginningscreen, width/2-210, 50); 
    textAlign(CENTER);
    text("Intro page \n press enter to begin", width/2, height/2+150);
    if (keyPressed) {
      frameCount = 0;
      state = 0;
    }
  }
  if (state==1) {
    background(0);
    textAlign(CENTER);
    textSize(50);
    text("Stage " + (level+1), width/2, height/2);
    text("Press Enter to Continue", width/2, height/2+50);
    lives = 5;
    if (keyPressed&&(frameCount-levelFrame)>=1300) {
      targets.clear();
      levelFrame = frameCount;
      //frameCount=0;
      lives = 5;
      numBullets = 5;
      level++;
      specialtargethit=false;
      targets1.remove(0);
      state = 0;
    }
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////



void keyPressed() {
  if (key==' ' && (frameCount - lastClear) > 60*7) {
    targets.clear();
    lastClear = frameCount;
  }
  if (key=='r') {
    lastReload = frameCount;
    numBullets = 5;
    gunReload.rewind();
    gunReload.play();
  }


  if ((key=='d') || (key=='D')) {
  }
}



///////////////////////////////////////////////////////////////////////////////////////////////



void keyReleased() {
  if (key=='s') {
    //javax.swing.JOptionPane.showOptionDialog(frame,"Are you sure you want to shoot?");

    int userInput = JOptionPane.showOptionDialog(frame, "Are you sure you want to shoot?", " ", 
      JOptionPane.YES_NO_CANCEL_OPTION, 
      JOptionPane.QUESTION_MESSAGE, 
      null, 
      options, 
      null);
    //println(userInput);

    if ((userInput == 0) && (frameCount - lastReload>=60)) {
      noCursor();
      if (numBullets > 0) {
        numBullets--;
        gunshot.rewind();
        gunshot.play();
        for (int i=0; i<targets.size(); i++) {
          if (dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)<100&&dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)>20&&lives>0) {
            score+=level;
            targets.get(i).murpx=targets.get(i).xTarget;
            targets.get(i).murpy=targets.get(i).yTarget;
            targets.get(i).shot=true;
            targetHit1.rewind();
            targetHit1.play();


            if (targets.get(i).yTarget>1920) {
              targets.remove(i);
              targetHit1.rewind();
              targetHit1.play();
            }
          } else if (dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)<20&&dist(mouseX, mouseY, targets.get(i).xTarget-50, targets.get(i).yTarget)>0&&lives>0) {
            score+=level*3;
            targets.get(i).murpx=targets.get(i).xTarget;
            targets.get(i).murpy=targets.get(i).yTarget;
            targets.get(i).shot=true;
            targets.get(i).bull=true;

            if (targets.get(i).yTarget>1920) {
              targets.remove(i);
              targetHit1.rewind();
              targetHit1.play();
            }
          }
        }
      }
    } else {
      noCursor();
      state = 4;
      background(0);
      textSize(50);
      text(("you scored " + score + " points"), (width/2 - 100), height/2);
      textSize(30);
      text(("but " + numUsersLess + "% of players put the "), (width/2 - 100), (height/2 + 80));
      text(("gun down before you did"), (width/2 - 100), (height/2 + 110));
      textSize(18);
      text("press A to exit",(width/2 - 100), (height/2 + 310));
      appendTextToFile(outFilename, str(maxLevel));

      }
    }
    if (key=='q'){
      state = 2;
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////



void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

// Creates a new file including all subfolders
void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}    
