
/*

- Flappy Bird Part 1 (Christmas Mode)
- Team Member 
  1- Muhammad Gamal
  2- Manar Essam
  3- Sara Muhammad El-Sayed
  4- Eman Muhammad
  5- Mina Ashraf
  
- Future Work (Part2)
  1- Add Hallowen Mode
  2- Add Soundtrack
  3- Edit Start and End Screen
  4- Add Rotation
  5- Change theme to Dark mode
  
*/

PImage topPipe, botPipe, bird, background, snow, snow2;
PShape heart;
int[] pipeX, pipeY, snowX, snowY, heartX, heartY;
int i, speed = 1, g, birdFaceX, birdLegY, tries, gap, backgroundX, backgroundY, birdX, birdY, birdYS, life, pipeW, pipeH, score, pipeSpeed, distance, currPipe;
boolean isLife, isStart;

void setup() {
  size(800, 800);
  topPipe = loadImage("topPipe.png");
  botPipe = loadImage("bottomPipe.png");
  background = loadImage("img.jpg");
  bird = loadImage("bird.png");  
  snow = loadImage("snow.png");
  snow2 = loadImage("snow2.png");
  heart = loadShape("heart-svgrepo-com.svg");
  background.resize(800, 800);
  topPipe.resize(91, 445);
  botPipe.resize(91, 445);
  birdX = 200;
  birdY = 200;
  pipeW = topPipe.width;
  pipeH = topPipe.height;
  tries =3;
  pipeSpeed = 4;
  birdFaceX = birdX + bird.width;
  birdLegY = birdY + bird.height;
  g=1;
  gap = 300;
  distance = 250;
  currPipe = -1;
  isLife = true;
  isStart = true;
  pipeX = new int[4];
  pipeY = new int[pipeX.length];
  for (i=0; i< pipeX.length; i++) {
    pipeX[i] = width + distance*i; //distance between each pipe on x-axis
    pipeY[i] = (int)random(-350, 0); // height will be displayed on screen -> min = 95 (-350+ pipeH), max = 445 (pipeH)
  }

  snowY = new int [30];
  snowX = new int [snowY.length];
  for (int i = 0; i < snowY.length; i++)
  {
    snowX[i] = (int)random(-10, width+10);
    snowY[i] = (int)random(-10, height);
  }
  heartX = new int[3];
  heartY = new int[heartX.length];
  for (int i = 0; i < heartX.length; i++)
  {
    heartX[i] = 25+ 30*i;
    heartY[i] = 25;
  }
  //print("height"+heart.width + "width"+heart.height);
}
void draw() {

  if (isStart) {
    startScreen();
  } else if (tries>0) 
  {
    setBackground();
    snowFall();
    setBird();
    jump();
    movingPipes();
    setScore();
    birdHearts();
  } else 
  {
    endScreen();
  }
}

void startScreen() {  
  background(0, 255, 0);    
  fill(255);
  textSize(90);
  text ("START", 250, 400);
  textSize(20);
  text ("PRESS LEFT CLICK TO CONTINUE", 235, 450);
  if (mousePressed && mouseButton == LEFT) {
    isStart = false;
  }
}

void endScreen() {
  background(255, 0, 0);
  fill(0);
  textSize(90);
  text ("LOSER", 250, 400);
  textSize(25);
  text ("Score : "+score, 325,450);
  textSize(20);
  text ("PRESS RIGHT CLICK TO CONTINUE", 220, 500);  
  if (mousePressed && mouseButton == RIGHT) {      
    resetGame();
  }
}

void resetGame() {
  isStart = true;
  isLife = true;
  tries = 3;
  score =0;
  currPipe = -1;
  pipeSpeed = 4;
  birdX = 200;
  birdY = 200;            
  for (i=0; i< pipeX.length; i++) {
    pipeX[i] = width + distance*i;
    pipeY[i] = (int)random(-350, 0);
  }
}
void setBackground()
{
  image(background, backgroundX, backgroundY);
  image(background, backgroundX + background.width, backgroundY);
  backgroundX = backgroundX - 1 ; //background speed control
  if (backgroundX < -background.width)
  {
    backgroundX = 0; //reset when first image is done
  }
}

void birdHearts() {
  if (tries == 3) {
    for (int i = 0; i < heartX.length; i++)
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

void snowFall()
{
  for (int i = 0; i < snowY.length; i++)
  {
    if (i % 2 == 0)
    {
      image(snow, snowX[i], snowY[i]);
    } else {
      image(snow2, snowX[i], snowY[i]);
    }
    snowY[i] += 3;
    if (snowY[i] > 650)
    {
      snowY[i] = 0;
    }
  }
}
void setBird() {
  image(bird, birdX, birdY);
  birdY = birdY + birdYS;
  birdYS = birdYS + g;
  if (birdY>= height || birdY < 0) {
    //isLife = false;
    tries--;
  }
}

void jump() {
  if ((mousePressed && mouseButton == LEFT) || (keyPressed && key == ' ')) {
    birdYS = -10;
  }
}

void movingPipes() {
  for (i=0; i< pipeX.length; i++) {
    image(topPipe, pipeX[i], pipeY[i]);
    image(botPipe, pipeX[i], pipeY[i]+ gap + pipeH);    
    pipeX[i] -= pipeSpeed;
    if (pipeX[i] < -(distance-((pipeX.length-1)*distance + pipeW - width)))
    { //0d+w  1d+w  2d+w  3d+w  -> 0:91  250:342  500:591    
      pipeX[i] = width;
      currPipe = -1;
    }     
    checkLife(pipeX[i], pipeY[i], i);
  }
}

void checkLife(int pipeX, int pipeY, int i) {

  if ((birdFaceX >= pipeX && birdFaceX <= pipeX + pipeW) || (birdX >= pipeX && birdX <= pipeX + pipeW))
  {     
    if (birdY <= pipeY + pipeH    ||  birdY >= pipeY + pipeH + gap - bird.height )
    {
      if (currPipe != i) {        
        tries--;  
        currPipe=i;
        isLife = false;
      }
    }
  }  

  if ((pipeX+pipeW < birdX && pipeX+pipeW >= birdX - pipeSpeed) && tries>0) { //195<pipeX<200 possibility of existance of 
    if (isLife) {
      score++;
    } 
    isLife = true;
    
    if ((score+1)%8==0) {// score+1 in case of hit at score 0 so 0%x will be 0 so will level up at 0 score doesn't make sense
      levelUp();
    }
  }
}


void setScore() {
  textSize(25);
  text ("Score : "+score, width-170, 40);
}

void levelUp() {
  pipeSpeed *=1.5;
}
