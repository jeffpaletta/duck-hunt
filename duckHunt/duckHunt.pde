//import processing.video.*;


/* Duck Hunt Version 8*/
////////////////////////////////////////////////////////////
import gifAnimation.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import javax.swing.JOptionPane; 
import java.io.FileWriter;
import java.io.BufferedWriter;
import controlP5.*;


String[] data;
String joinedData, convertJoinedData;
String outFilename = "data.txt";
int maxLevel = 0, numUsersMore = 0, numUsersLess = 0, numUsersEqual = 0;
int dataCounter1 = 0, dataCounter2 = 0, dataCounter3 = 0, dataCounter4 = 0, dataCounter5 = 0, dataCounter6 = 0, dataCounter7 = 0, dataCounter8 = 0;

PFont font;
PFont serif;
int kids = 5;

PImage[] sbar = new PImage[25];
int scalc;


Minim minim;
AudioPlayer emptygun;
AudioPlayer targetHit1, targetHit2;
AudioPlayer gunshot1, gunshot2, gunshotburst;
AudioPlayer reload1, reload2;
AudioPlayer quack1, quack2, manshot1, manshot2, manshotquick, slowdying, childrenscream, targethit33;
AudioPlayer ambient1, ambient2, ambient3, ambient4, ambient5, ambient6, ambient7;
AudioPlayer startsound;

Gif duckLoop, bgloopStart, bgloop1, bgloop2, bgloop3, bgloop4, bgloop5, bgloop6;

PImage startScreen, background1, background2, background3, background4, background5, background6, background7, highscores;
PImage levelinfo1, levelinfo2, levelinfo3, levelinfo4, levelinfo5, levelinfo6;
PImage target1, targethit1, specialtarget1;
PImage crosshair, bullet, explosion;

int state=2, level = 1, numBullets = 6, lastClear = 0, lastReload = 0, levelFrame = 0, lives = 5, score, highscore, timeLeft;
boolean dead = false;
boolean shoot = false;
boolean specialtargethit = false;
Object[] options = {"Yes", "No"};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(1280, 720);
  noCursor();
  
  font = createFont("PressStart2P.ttf", 36);
  textFont(font);
  
  serif = createFont("Times New Roman", 24);
  
  for (int i = 0; i < sbar.length; i++){
    sbar[i] = loadImage("graphics/score/Score_" + i + ".png");
  }
  
  crosshair = loadImage("graphics/crosshair.png");
  bullet = loadImage("graphics/bullet.png");
  explosion = loadImage("graphics/explosion.png");
  startScreen = loadImage("graphics/backgrounds/start_screen.jpg");  
  background1 = loadImage("graphics/backgrounds/level1.jpg");
  background2 = loadImage("graphics/backgrounds/level2.jpg");
  background3 = loadImage("graphics/backgrounds/level3.jpg");
  background4 = loadImage("graphics/backgrounds/level4.jpg");
  background5 = loadImage("graphics/backgrounds/level5.jpg");  
  background6 = loadImage("graphics/backgrounds/level6.jpg");  
  background7 = loadImage("graphics/backgrounds/level7.jpg"); 
  highscores = loadImage("graphics/backgrounds/highscores.jpg");  
 
  targethit1 = loadImage("graphics/targets/targethit1.png");
  
  levelinfo1 = loadImage("graphics/rounds/Round01.png");
  levelinfo2 = loadImage("graphics/rounds/Round02.png");
  levelinfo3 = loadImage("graphics/rounds/Round03.png");
  levelinfo4 = loadImage("graphics/rounds/Round04.png");
  levelinfo5 = loadImage("graphics/rounds/Round05.png");
  levelinfo6 = loadImage("graphics/rounds/Round06.png");

  duckLoop = new Gif(this, "graphics/targets/duck.gif");  duckLoop.loop();
  bgloopStart = new Gif(this, "graphics/targets/bgloopStart.gif");  bgloopStart.loop();
//  bgloop1 = new Gif(this, "graphics/targets/bgloop1.gif");  bgloop1.loop();
//  bgloop2 = new Gif(this, "graphics/targets/bgloop2.gif");  bgloop2.loop();
////  bgloop3 = new Gif(this, "graphics/targets/bgloop3.gif");  bgloop3.loop();
//  bgloop4 = new Gif(this, "graphics/targets/bgloop4.gif");  bgloop4.loop();
//  bgloop5 = new Gif(this, "graphics/targets/bgloop5.gif");  bgloop5.loop();
//  bgloop6 = new Gif(this, "graphics/targets/bgloop6.gif");  bgloop6.loop();

  specialtarget1 = target1;
  target1 = duckLoop;


  minim = new Minim(this);
  emptygun = minim.loadFile("audio/emptygun.mp3");
  targetHit1 = minim.loadFile("audio/quack1.mp3");
  targetHit2 = minim.loadFile("audio/quack2.mp3");
  gunshot1 = minim.loadFile("audio/gunshot1.mp3");
  gunshot2 = minim.loadFile("audio/gunshot2.mp3");  
  reload1 = minim.loadFile("audio/reload1.mp3");
  reload2 = minim.loadFile("audio/reload2.mp3"); 
  startsound = minim.loadFile("audio/start.wav"); 
  
  
  childrenscream = minim.loadFile("audio/childrenscream.mp3");
  gunshotburst = minim.loadFile("audio/gunshotburst.mp3");
  manshot1 = minim.loadFile("audio/manshot1.mp3");
  manshot2 = minim.loadFile("audio/manshot2.mp3");
  manshotquick = minim.loadFile("audio/manshotquick.mp3");
  slowdying = minim.loadFile("audio/slowdying.mp3");
  quack1 = minim.loadFile("audio/quack1.mp3");
  quack2 = minim.loadFile("audio/quack2.mp3");
  targethit33 = minim.loadFile("audio/targethit33.mp3");
  
//  ambient1 = minim.loadFile("audio/ambient/ambient1.mp3");
//  ambient2 = minim.loadFile("audio/ambient/ambient2.mp3");
//  ambient3 = minim.loadFile("audio/ambient/ambient3.mp3");
//  ambient4 = minim.loadFile("audio/ambient/ambient4.mp3");
//  ambient5 = minim.loadFile("audio/ambient/ambient5.mp3");
//  ambient6 = minim.loadFile("audio/ambient/ambient6.mp3");
//  ambient1 = minim.loadFile("audio/ambient/ambient1.mp3");

  
///////////////////////////
//     DATA TRACKING     //
///////////////////////////

//  data = loadStrings("data.txt");
//  joinedData = join(data, " ");
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
  // if (joinedData.charAt(i) == '1') { dataCounter1++; }
  // else if (joinedData.charAt(i) == '2') { dataCounter2++; }
  // else if (joinedData.charAt(i) == '3') { dataCounter3++; }
  // else if (joinedData.charAt(i) == '4') { dataCounter4++; }
  // else if (joinedData.charAt(i) == '5') { dataCounter5++; }
  // else if (joinedData.charAt(i) == '6') { dataCounter6++; }
  // else if (joinedData.charAt(i) == '7') { dataCounter7++; }
  // else if (joinedData.charAt(i) == '8') { dataCounter8++; }
  // else {}
  //}
    noCursor();
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
  
  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  void display() {

    if (flip) { 
      pushMatrix();
      if (shot)image(targethit1, xTarget, yTarget);
      else { 
        scale(-1.0, 1.0);
        
      if (level==1) { 
      image(target1, -xTarget, yTarget);
      duckLoop.loop();
      duckLoop.play();   
    }
        else if (level==1) { image(target1, -xTarget, yTarget); }
        else if (level==2) { image(target1, -xTarget, yTarget); }
        else if (level==3) { image(target1, -xTarget, yTarget); }
        else if (level==4) { image(target1, -xTarget, yTarget); }
        else if (level==5) { image(target1, -xTarget, yTarget); }
        else if (level==6) { image(target1, -xTarget, yTarget); }
        else if (level==7) { background(0); }
        //else if (level==7) { image(target1, -xTarget, yTarget); }
        else {  }
        duckLoop.loop();
        duckLoop.play();  
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


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
  
  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
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
      image(target1, xTarget1, yTarget1);
      duckLoop.play();
      popMatrix();
      xTarget1+=vx;
    }
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////


ArrayList <Target> targets = new ArrayList<Target>();
ArrayList <specialTarget> targets1 = new ArrayList<specialTarget>();
//ArrayList<PImage> images = new ArrayList<PImage>();
//images.add(loadImage("thefile.png"));
//images.add(loadIMage("asdfasdf"));
//PImage bla = images.get(0);ad
//image(images.get(0),  123, 234 );
ArrayList <PImage> bullets = new ArrayList<PImage>(); 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void draw() {

  //println("level: " + level + "       Max Level:" + maxLevel);
  println(dataCounter1);
  scalc = score/2;

  if (level > maxLevel) {
    maxLevel = level;
  }

  if (state == 0) {
    timeLeft=(int)(60-(((frameCount-levelFrame)%1200)/60));
    if (lives<=0) {
      background(255, 0, 0);
      textSize(50);
      text("Game Over", width/2+125, height/2);
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
          derpx=1280;
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
      } else if (level==3) {
        image(background3, 0, 0);
      } else if (level==4) {
        image(background4, 0, 0);
      } else if (level==5) {
        image(background5, 0, 0);
      } else if (level==6) {
        image(background6, 0, 0);
      } else if (level==7) {
        state = 4;
        //$$
//        image(background7, 0, 0);
//        background(255,0,0)
//        textSize(
      }

      if ((frameCount-levelFrame)%1200==720) {
        targets1.add(new specialTarget(0, (int)random(50, height-50)));
      }
      if ((frameCount-levelFrame)%1200>720) {
        if (targets1.size()>0) {
          targets1.get(0).display();
          if (specialtargethit==false&&mousePressed&&dist(mouseX, mouseY, targets1.get(0).xTarget1, targets1.get(0).yTarget1)<60&&lives>0) {
            specialtargethit=true;
//            score+=level*10;
              score++;
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
        if (1280<targets.get(i).xTarget||targets.get(i).xTarget<0) {
          //lives--;
          targets.remove(i);
        }
      }
      if (score>=highscore) {
        highscore=score;
      }
      image(crosshair, mouseX-348, mouseY-205);
      if ((frameCount - levelFrame)%1200==0) {
        state = 1;
      }
      fill(255);
      textSize(30);
      textAlign(RIGHT);
//      text("score: "+score, width-10, 50);
      
//      if (
      scalc = score/2;
      image(sbar[scalc], width/2-150, 20);
      
      //text("lives: "+lives, width-10, 100);
      //text("highscore: "+highscore, width-10, 30);
      text("time: "+timeLeft, width-20, 120);
      textAlign(LEFT);
      image(bullet, 1170, 120);
      //text("Bullets: "+numBullets, 10, 590);
      for (int j = 0; j < numBullets; j++) {
        if (state==0) {
          image(bullet, j*10+1180, 120);
        }
      }
    }
  }
  if (state == 2) {
    background(0); 
    image(startScreen, 0, 0);
    image(bgloopStart, 0, 0);
    bgloopStart.play();
    duckLoop.pause();
//    textAlign(CENTER);
//    text("press 1 to begin", width/2, height/2+150);
    if (keyPressed) {
      startsound.rewind();
      startsound.play();
      frameCount = 0;
      state = 0;
    }
  }
  if (state==1) {
    background(0);
    if (level==1) {
        image(background2, 0, 0);
        image(levelinfo2, (width/2-120), (height/2-100));
      } 
      if (level==2) {
        image(background3, 0, 0);
        image(levelinfo3, (width/2-120), (height/2-100));
      } else if (level==3) {
        image(background4, 0, 0);
        image(levelinfo4, (width/2-120), (height/2-100));
      } else if (level==4) {
        image(background5, 0, 0);
        image(levelinfo5, (width/2-120), (height/2-100));
      } else if (level==5) {
        image(background6, 0, 0);
        image(levelinfo6, (width/2-120), (height/2-100));
      } else if (level==6) {
//        image(background6, 0, 0);
//        image(levelinfo6, (width/2-120), (height/2+50));
      } else {
//        state = 4;
//        image(background7, 0, 0);
//        image(levelinfo7, (width/2-120), (height/2+50));
      }
    
    
    textAlign(CENTER);
    textSize(18);
//    text("Level " + (level+1), width/2, height/2);
    text("Press 1 to Continue", width/2+5, height/2+100);
    lives = 5;
    if (keyPressed&&(frameCount-levelFrame)>=1300) {
      targets.clear();
      levelFrame = frameCount;
      //frameCount=0;
      lives = 5;
      numBullets = 6;
      level++;
      
      specialtargethit=false;
      targets1.remove(0);
      state = 0;
    }
  }
  if (level == 7) {
    state = 4;
  }
    if (state == 4) {
    background(0);
    image(highscores, 0, 0);
    textFont(serif);
    textSize(31);
    fill(0);
    pushMatrix();
    translate(0,0);
    text("Gunman kills " + score + ", including " + kids + " kids, at Mich. school", ((width/2)-338), ((height/2)-35));
//    textSize(30);
//    text(("but " + numUsersLess + "% of players put the "), (width/2 - 100), (height/2 + 80));
//    text(("gun down before you did"), (width/2 - 100), (height/2 + 110));
//    textSize(18);
//    text("press 2 to exit",(width/2 - 100), (height/2 + 310));
//    appendTextToFile(outFilename, str(maxLevel));rr
  popMatrix();

  }
}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void keyPressed() {
  if (key==' ' && (frameCount - lastClear) > 60*7) {
    targets.clear();
    lastClear = frameCount;
  }
  if (key=='r') {
    lastReload = frameCount;
    numBullets = 5;
    reload1.rewind();
    reload1.play();
  }


  if ((key=='d') || (key=='D')) {
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void keyReleased() {
  if (key=='s') {
    //javax.swing.JOptionPane.showOptionDialog(frame,"Are you sure you want to shoot?");

    int userInput = JOptionPane.showOptionDialog(frame, "Are you sure you want to shoot?", "Press A to select", 
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
        if(level==1) {
          gunshot1.rewind();
          gunshot1.play();
        }
        else if (level==2) {
          gunshot2.rewind();
          gunshot2.play();
        }
        else if (level==3) {
          gunshotburst.rewind();
          gunshotburst.play();
        }
        else if (level==4) {
          gunshot2.rewind();
          gunshot2.play();
        }
        else if (level==5) {
          gunshot2.rewind();
          gunshot2.play();
        }
        else if (level==6) {
          gunshotburst.rewind();
          gunshotburst.play();
        }
        else {
          gunshot2.rewind();
          gunshot2.play();
        }
       
      
        for (int i=0; i<targets.size(); i++) {
          if (dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)<100&&dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)>20&&lives>0) {
            score++;
            targets.get(i).murpx=targets.get(i).xTarget;
            targets.get(i).murpy=targets.get(i).yTarget;
            targets.get(i).shot=true;
              if(level==1) {
                targetHit1.rewind();
                targetHit1.play();
              }
              else if (level==2) {
                targetHit2.rewind();
                targetHit2.play();
              }
              else if (level==3) {
                manshotquick.rewind();
                manshotquick.play();
              }
              else if (level==4) {
                slowdying.rewind();
                slowdying.play();
              }
              else if (level==5) {
                manshot2.rewind();
                manshot2.play();
              }
              else if (level==6) {
                childrenscream.rewind();
                childrenscream.play();
              }
              else {
                targetHit1.rewind();
                targetHit1.play();
              }
            

           if (targets.get(i).yTarget>1280) {
              targets.remove(i);
                if(level==1) {
                targetHit1.rewind();
                targetHit1.play();
              }
              else if (level==2) {
                targetHit2.rewind();
                targetHit2.play();
              }
              else if (level==3) {
                manshotquick.rewind();
                manshotquick.play();
              }
              else if (level==4) {
                slowdying.rewind();
                slowdying.play();
              }
              else if (level==5) {
                manshot2.rewind();
                manshot2.play();
              }
              else if (level==6) {
                childrenscream.rewind();
                childrenscream.play();
              }
              else {
                targetHit1.rewind();
                targetHit1.play();
              }
                
            }
          } else if (dist(mouseX, mouseY, targets.get(i).xTarget, targets.get(i).yTarget+50)<20&&dist(mouseX, mouseY, targets.get(i).xTarget-50, targets.get(i).yTarget)>0&&lives>0) {
//            score+=level*3;
            score++;
            targets.get(i).murpx=targets.get(i).xTarget;
            targets.get(i).murpy=targets.get(i).yTarget;
            targets.get(i).shot=true;
            targets.get(i).bull=true;

            if (targets.get(i).yTarget>1280) {
              targets.remove(i);
                if(level==1) {
                targetHit1.rewind();
                targetHit1.play();
              }
              else if (level==2) {
                targetHit2.rewind();
                targetHit2.play();
              }
              else if (level==3) {
                manshotquick.rewind();
                manshotquick.play();
              }
              else if (level==4) {
                slowdying.rewind();
                slowdying.play();
              }
              else if (level==5) {
                manshot2.rewind();
                manshot2.play();
              }
              else if (level==6) {
                childrenscream.rewind();
                childrenscream.play();
              }
              else {
                targetHit1.rewind();
                targetHit1.play();
              }
            }
          }
        }
      }
      else {
        emptygun.rewind();
        emptygun.play();
      }
    } 
    if ((userInput == 1) && (frameCount - lastReload>=60)) {
      noCursor();
      state = 4;
      

      }
      //else{}
    }
    if (key=='q'){
      state = 2;
      setup();
      draw();
  }
  if (key=='m'){
//      noLoop();
    state = 4;
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}    
