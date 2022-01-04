import processing.sound.*;
SoundFile jingleBells, click, hit, halloweenMusic, eat;
PImage start, topPipe, botPipe, bird, background, snow, snow2, modebgDay, modeBgNight, birdDead, creepyGhost, cuteGhost, gameOver, christmasBackground, hallowenBackground;
PImage christmasBird, hallowenBird, help, stars, buttonBack,buttonHome,buttonStart, buttonNext;

PShape heart;
int[] pipeX, pipeY, snowX, snowY, heartX, heartY ;
ArrayList <Ghost> creepyGhosts, cuteGhosts ;
int i, speed = 1, g, birdFaceX, hallowenBirdFaceX, tries, gap, backgroundX, backgroundY, birdX, life, pipeW, pipeH, score, pipeSpeed, distance, currPipe, ghostNum;
boolean isLife, isMode, isQuit, christmasMode, isStart;
float angle = 0.0, y = 200.0, birdY, birdYS, hallowenBirdFaceY;
String txt;
float angleBird = 0.0, gBird =0.05;
PFont font;




void setBackground()
{ 
  background = christmasMode?  christmasBackground: hallowenBackground; //checks which mode to set the background
  background.resize(800, 800);
  image(background, backgroundX, backgroundY); //1st bg image  starting from (0,0)
  image(background, backgroundX + background.width, backgroundY);  //2nd bg image  starting from the end of the screen (bg.width,0)
  backgroundX = backgroundX - 1 ; //background speed control >> motion in x-direction
  if (backgroundX < -background.width)  //if background moved outside the screen
  {
    backgroundX = 0; //reset when first image is done
  }
}

void birdHearts() {
  if (tries == 3) {
    for (int i = 0; i < heartX.length; i++)  //draw 3 hearts at position ( heartX[i], heartY[i]) with height & width= 25
    {
      shape(heart, heartX[i], heartY[i], 25, 25);  
    }
  } else if (tries == 2) {
    for (int i = 0; i < heartX.length -1; i++)
    {
      shape(heart, heartX[i], heartY[i], 25, 25);
    }
  } else {
    for (int i = 0; i < heartX.length -2; i++)
    {
      shape(heart, heartX[i], heartY[i], 25, 25);
    }
  }
}


void setBird() {
  bird = christmasMode? christmasBird : hallowenBird;  //checks which mode to set it's bird
  image(bird, birdX, birdY);
  birdY = birdY + birdYS;  // moving bird downwards in y-direction
  birdYS += 0.8;  //speed by which bird falls (gravity)
  if (birdY + bird.height >= height) {  //prevents the bird from falling outside the window
    tries--;
  }
}

void jump() {
  if ((mousePressed && mouseButton == LEFT) || (keyPressed && key == ' ')) {
    if (birdY - bird.height/2 >= 10  ) // prevents the bird from jumping beyond the specific height
      birdYS = -10;
  }
}
