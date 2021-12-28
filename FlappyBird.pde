
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
import processing.sound.*;
SoundFile jingleBells , click , hit;
PImage topPipe, botPipe, bird, background, snow, snow2, startbgDay, startBgNight, birdDead , ghost, gameOver , team  ,  christmasBackground, hallowenBackground ;
PShape heart;
int[] pipeX, pipeY, snowX, snowY, heartX, heartY, ghostX, ghostY;
int i, speed = 1, g, birdFaceX, birdLegY, tries, gap, backgroundX, backgroundY, birdX, birdY, birdYS, life, pipeW, pipeH, score, pipeSpeed, distance, currPipe,ghostNum;
boolean isLife, isStart,isQuit , christmasMode;
float angle = 0.0 , y = 200.0;
String txt;

void setup() {
  size(800, 800);
  smooth();
  topPipe = loadImage("topPipe.png");
  botPipe = loadImage("bottomPipe.png");
  //background = loadImage("img.jpg");
  hallowenBackground = loadImage("img4.jpg");
  christmasBackground = loadImage("img.jpg");
  bird = loadImage("birdLive.png");
  birdDead = loadImage("birdDead.png");
  ghost = loadImage("ghost1.png");
  click = new SoundFile(this, "mixkit-quick-win-video-game-notification-269.wav");
  hit = new SoundFile(this, "hit.mp3");
  gameOver = loadImage("gameOver.png");
  team = loadImage("1.jpg");
  team.resize(800,800);
  String[] teamNames = loadStrings("team.txt");
  txt = join(teamNames , "\n");
  snow = loadImage("snow.png");
  snow2 = loadImage("snow2.png");
  heart = loadShape("heart-svgrepo-com.svg");
  jingleBells = new SoundFile(this, "Bobby_Helms_Jingle_Bell_Rock_Lyrics_.wav");
  startbgDay = loadImage("christmas.png");
  startBgNight =loadImage("hallowen.jpg");
  startbgDay.resize(578, 800);
  startBgNight.resize(600, 800);
 // background.resize(800, 800);
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
  isQuit = false;
  christmasMode = true;
  pipeX = new int[4];
  pipeY = new int[pipeX.length];
  for (i=0; i< pipeX.length; i++) {
    pipeX[i] = width + distance*i; //distance between each pipe on x-axis
    pipeY[i] = (int)random(-350, 0); // height will be displayed on screen -> min = 95 (-350+ pipeH), max = 445 (pipeH)
  }
  ghostNum = 10;

  ghostX = new int[ghostNum];
  ghostY = new int[ghostNum];
  for (int i = 0; i < ghostX.length; i++)
  {
    ghostX[i] = (int)random(width);
    ghostY[i] = (int)random( height);
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
    setBird();
    jump();
    setScore();
    birdHearts();
    
    if (christmasMode){
        snowFall();
        movingPipes();
    }
    else 
      setGhost();

  }
  else if(isQuit)
  {
    quitScreen();
  } 
  else 
  {
    endScreen();
  }
  
}

void startScreen() {  
  image(startbgDay, 0, 0);
  image(startBgNight, 405, 0);
  fill(0, 150); //separator
  rect(400, 0, 5, 800);
  if (mouseX < 400 && mouseX > 0 ) { // startbgDay overlay
    dayMode();
  }
  
  if (mouseX > 405 && mouseX < 800 ) { // startBgNight overlay
   nightMode();} 
 }

void dayMode()
{
  fill(0, 90); 
    rect(0, 0, 400, 800);
    fill(0, 100);  //play button
    ellipse(200, 400, 50, 50);
    fill(255, 150); 
    triangle(190, 390, 190, 410, 212, 400);
    fill(255, 200); //mode instructions
    textSize(50);
    text ("Christmas", 70, 200);
    fill(255, 200);
    textSize(20);
    text ("Mode 1", 160, 250);
    textSize(25);
    text ("PRESS PLAY button to START", 30, 350);
    if (mouseX > 150 && mouseX < 250 && mouseY < 450 && mouseY > 350) 
    {
      fill(0, 100);  //play button
      ellipse(200, 400, 60, 60);
      fill(255, 150); 
      triangle(190, 390, 190, 410, 212, 400);
      if (mousePressed ) 
      {
        christmasMode = true;
        click.play();
        isStart = false; 
        jingleBells.play();
      }
    }
}

void nightMode ()
{
    fill(0, 90); 
    rect(405, 0, 395, 800);
    fill(0, 100);  //play button
    ellipse(600, 400, 50, 50);
    fill(255, 150);
    triangle(590, 390, 590, 410, 612, 400);
    fill(255, 200); //mode instructions
    textSize(50);
    text ("Hallowen", 485, 200);
    fill(255, 200);
    textSize(20);
    text ("Mode 2", 565, 250);
    textSize(25);
    text ("PRESS PLAY button to START", 435, 350);
    if (mouseX > 550 && mouseX < 650 && mouseY < 450 && mouseY > 350) {
      fill(0, 100);  //play button
      ellipse(600, 400, 60, 60);
      fill(255, 150);
      triangle(590, 390, 590, 410, 612, 400);
       if (mousePressed ) 
      {
        isStart = false;
        christmasMode = false;
      }
    }
  
}

void endScreen() {
  hit.stop();
  background(#5F9BB2);
  jingleBells.stop();
  
  //game over image
  gameOver.resize(400,400);
  image(gameOver, 200, -100);
  
  //dead bird image
  birdDead.resize(70,60);
  image(birdDead, 600, 50);
  
  //homeScreen
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300,150,200,80);
  noStroke();
  fill(255);
  text ("Home",350,200);
  homeScreenButton(300,150,200,80);
  
  //reset
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300,300,200,80);
  noStroke();
  fill(255);
  text ("Reset",350,350);
  resetButton();
  
  textSize(20);
  text ("Press DELETE button to quit.\nYou also can press space to reset and enter to go to homeScreen.",5,600);
  
  //quit
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300,450,200,80);
  noStroke();
  fill(255);
  text ("Quit",350,500);
  quitButton(300,450,200,80);
  
  //jingleBells.stop();
}

void setGhost(){
  for (int i = 0; i < ghostX.length; i++)
  {
    image(ghost, ghostX[i], ghostY[i]);
    ghostX[i] -= 5; 
    if(ghostX[i] < -60){
      ghostX[i] = width-10;
    }
  }
  
}

void quitScreen()
{
  team.resize(800,800);
  image(team, 0, 0);
  textSize(40);
  fill(255);
  text(txt , 250 , y);
  y-=1;
  if(y <= -250)
  {
    y = 200;
  }
  textSize(10);
  text ("Press ESC button to end the game.\nUse the left click to click on back.\nUse it also to click on home.",5,600);
  
  //Home
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(600,500,100,50);
  noStroke();
  fill(255);
  text ("Home",595,535);
  
  if(isMouseOver(600,500,100,50)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER))
  {
    isQuit =false;
    y = 200;
    homeScreenButton(600,500,100,50);
  }
  
  //back
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(600,600,100,50);
  noStroke();
  fill(255);
  text ("Back",595,635);
  
  if(isMouseOver(600,600,100,50)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER))
  {
    click.play();
    isQuit =false;
    y = 200;
    endScreen();
    //homeScreenButton(600,600,100,50);
  }
}

boolean isMouseOver(int x, int y, int w, int h){
  if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
    return  true;
  }
  return false;
}

void homeScreenButton(int x, int y, int w, int h){
  if(isMouseOver(x, y , w , h)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER)){
    println("home pressed");
    click.play();
    resetGame(true);
  } 
}
void resetButton(){
  if(isMouseOver(300,300,200,80) == true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ' '))
  {
    println("reset pressed");
    click.play();
    jingleBells.play();
    resetGame(false);
  } 
}
void quitButton(int x, int y, int w, int h){
  if(isMouseOver(x, y , w , h)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == DELETE)){
    println("quit pressed");  
    click.play();
    isQuit =true;
  } 
}

void resetGame(boolean start) {
  isStart = start;
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
  background = christmasMode?  christmasBackground: hallowenBackground; 
  background.resize(800,800);
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
  } 
  else if (tries == 2) {
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
      pushMatrix();
      rotate(angle);
      angle+=0.2;
      image(snow, snowX[i], snowY[i]);
      popMatrix();
    } else {
      pushMatrix();
      rotate(angle);
      angle+=0.2;
      image(snow2, snowX[i], snowY[i]);
      popMatrix();
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
        hit.play();
        currPipe=i;
        isLife = false;
      }
    }
  }  

  if ((pipeX+pipeW < birdX && pipeX+pipeW >= birdX - pipeSpeed) && tries>0) { //195<pipeX<200 possibility of existance of 
    score++;
    levelUp();
  }
}


void setScore() {
  textSize(25);
  text ("Score : "+score, width-170, 40);
}

void levelUp() {
  if ((score%8) ==0) {// score+1 in case of hit at score 0 so 0%x will be 0 so will level up at 0 score doesn't make sense
    pipeSpeed +=2;
  }
}
