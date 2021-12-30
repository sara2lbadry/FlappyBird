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
  3- Edit mode and End Screen
  4- Add Rotation
  5- Change theme to Dark mode
  
*/
import processing.sound.*;
SoundFile jingleBells , click , hit , halloweenMusic, eat;
PImage start , topPipe, botPipe, bird, background, snow, snow2, modebgDay, modeBgNight, birdDead , creepyGhost, cuteGhost, gameOver , team  ,  christmasBackground, hallowenBackground, christmasBird, hallowenBird;
PShape heart;
int[] pipeX, pipeY, snowX, snowY, heartX, heartY ;
ArrayList <Ghost> creepyGhosts , cuteGhosts ;
int i, speed = 1, g, birdFaceX, hallowenBirdFaceX, tries, gap, backgroundX, backgroundY, birdX, life, pipeW, pipeH, score, pipeSpeed , distance, currPipe,ghostNum;
boolean isLife, isMode,isQuit , christmasMode , isStart;
float angle = 0.0 , y = 200.0 , birdY, birdYS ,hallowenBirdFaceY;
String txt;
int frame;

void setup() {

  size(800, 800);
  smooth();
  noStroke();
  start = loadImage("Flappy-Bird-1.jpg");
  topPipe = loadImage("topPipe.png");
  botPipe = loadImage("bottomPipe.png");
  //background = loadImage("img.jpg");
  hallowenBackground = loadImage("img4.jpg");
  christmasBackground = loadImage("img.jpg");
  hallowenBird = loadImage("bird2.png");
  christmasBird = loadImage("birdLive.png");
  birdDead = loadImage("birdDead.png");
  creepyGhost = loadImage("bat3.png");
  cuteGhost = loadImage("cuteghost2.png");
  click = new SoundFile(this, "mixkit-quick-win-video-game-notification-269.wav");
  hit = new SoundFile(this, "hit.mp3");
  halloweenMusic = new SoundFile(this, "halloween_music.wav");
  eat = new SoundFile(this, "eat.wav");
  gameOver = loadImage("gameOver.png");
  team = loadImage("1.jpg");
  team.resize(800,800);
  String[] teamNames = loadStrings("team.txt");
  txt = join(teamNames , "\n");
  snow = loadImage("snow.png");
  snow2 = loadImage("snow2.png");
  heart = loadShape("heart-svgrepo-com.svg");
  jingleBells = new SoundFile(this, "Bobby_Helms_Jingle_Bell_Rock_Lyrics_.wav");
  modebgDay = loadImage("img.jpg");
  modeBgNight =loadImage("img4.jpg");
  modebgDay.resize(578, 800);
  modeBgNight.resize(600, 800);
  creepyGhost.resize(70, 70);
  cuteGhost.resize(50, 50);
  hallowenBird.resize(70,70);
  start.resize(800,800);
  topPipe.resize(91, 445);
  botPipe.resize(91, 445);
  birdX = 200;
  birdY = 200;
  pipeW = topPipe.width;
  pipeH = topPipe.height;
  tries =3;
  pipeSpeed = 4;
  birdFaceX = birdX + christmasBird.width;
  hallowenBirdFaceX = birdX + hallowenBird.width;
  hallowenBirdFaceY = birdY + hallowenBird.height;
  g=1;
  gap = 300;
  distance = 250;
  currPipe = -1;
  isLife = true;
  isStart = true;
  isMode = false;
  isQuit = false;
  christmasMode = true;
  pipeX = new int[4];
  pipeY = new int[pipeX.length];
  for (i=0; i< pipeX.length; i++) {
    pipeX[i] = width + distance*i; //distance between each pipe on x-axis
    pipeY[i] = (int)random(-350, 0); // height will be displayed on screen -> min = 95 (-350+ pipeH), max = 445 (pipeH)
  }
  // 4 creepy, 4 cute. total 8
  ghostNum = 4;
  frame = 0;
   
  creepyGhosts = new ArrayList();
  cuteGhosts = new ArrayList();
  
  for (int i = 0; i < ghostNum; i++)
  {
     creepyGhosts.add(new Ghost());
     cuteGhosts.add(new Ghost());
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
}

void draw() {
  //start and instructions
  if(isStart){
    startScreen();
  }
  //Choose mode
  else if (isMode) {
    modeScreen();
  } 
  else if (tries>0) 
  {
    setBackground();
    setBird();
    jump();  
    if (christmasMode){
        snowFall();
        movingPipes();
    }
    else 
    {
      setGhost();
    }
    setScore();
    birdHearts();   
  }
  else if(isQuit)
  {
    quitScreen();
  } 
  else 
  {
    endScreen();
  }
  frame++;
  
}
void startScreen()
{
  image(start, 0, 0);
  //start modes
  ellipse(400, 500, 50, 50);
  fill(0, 150); 
  triangle(390, 490, 390, 510, 415, 500);
  startScreenButton();
}

void modeScreen() {  
  image(modebgDay, 0, 0);
  image(modeBgNight, 405, 0);
  fill(0, 150); //separator
  rect(400, 0, 5, 800);
  if (mouseX < 400 && mouseX > 0 ) { // modebgDay overlay
    dayMode();
  }
  
  if (mouseX > 405 && mouseX < 800 ) { // modeBgNight overlay
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
    text ("Christmas", 70, 100);
    fill(255, 200);
    textSize(20);
    text ("Mode 1", 160, 150);
    textSize(25);
    text ("PRESS PLAY button to mode", 30, 250);
    text ("Left click or press space to\nincrease score and avoid pipes.", 20, 600);
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
        isMode = false; 
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
    text ("Halloween", 485, 100);
    fill(255, 200);
    textSize(20);
    text ("Mode 2", 565, 150);
    textSize(25);
    text ("PRESS PLAY button to mode", 435, 250);
    text ("Left click to eat ghosts,\nincrease score and avoid bats.", 425, 600);
    if (mouseX > 550 && mouseX < 650 && mouseY < 450 && mouseY > 350) {
      fill(0, 100);  //play button
      ellipse(600, 400, 60, 60);
      fill(255, 150);
      triangle(590, 390, 590, 410, 612, 400);
      if (mousePressed ) 
      {
        isMode = false;
        christmasMode = false;
        halloweenMusic.loop();
      }
    } 
}

void endScreen() {
  hit.stop();
  eat.stop();
  halloweenMusic.stop();
  jingleBells.stop();

  background(#5F9BB2);
  //game over image
  gameOver.resize(400,400);
  image(gameOver, 200, -100);
  
  //dead bird image
  birdDead.resize(70,60);
  image(birdDead, 600, 50);
  
  //modeScreen
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300,150,200,80);
  noStroke();
  fill(255);
  text ("Mode",350,200);
  modeScreenButton(300,150,200,80);
  
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
  
  fill(255);
  textSize(20);
  text ("Press DELETE button to quit.\nYou also can press space to reset and enter to go to modeScreen.",5,600);
  
  //jingleBells.stop();
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
  textSize(15);
  text ("Press ESC button to end the game.\nUse the left click to click on back or mode.",5,600);
  
  //Start
  textSize(30);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(600,500,100,50);
  noStroke();
  fill(255);
  text ("Start",610,535);
  
  if(isMouseOver(600,500,100,50)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER))
  {
    isQuit =false;
    isMode = false;
    y = 200;
    isStart = true;
    startScreen();
  }
  
  //back
  textSize(30);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(600,600,100,50);
  noStroke();
  fill(255);
  text ("Back",610,635);
  
  if(isMouseOver(600,600,100,50)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER))
  {
    click.play();
    isQuit =false;
    y = 200;
    endScreen();
  }
}

boolean isMouseOver(int x, int y, int w, int h){
  if(mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h){
    fill(0,90);
    rect(x , y , w, h);
    return  true;
  }
  return false;
}

void startScreenButton()
{
  if (mouseX > 350 && mouseX < 450 && mouseY < 550 && mouseY > 450) 
    {
      fill(0, 100);  //play button
      ellipse(400, 500, 60, 60);
      if (mousePressed ) 
      {
        println("mode pressed");
        isStart = false;
        isMode = true;
        click.play();
        modeScreen();
      }
    }
}

void modeScreenButton(int x, int y, int w, int h){
  if(isMouseOver(x, y , w , h)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ENTER)){
    println("mode pressed");
    click.play();
    resetGame(true);
  } 
}

void resetButton(){
  if(isMouseOver(300,300,200,80) == true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == ' '))
  {
    println("reset pressed");
    click.play();
    if (christmasMode)
      jingleBells.loop();
    else
      halloweenMusic.loop();
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

void resetGame(boolean mode) {
  isMode = mode;
  isLife = true;
  tries = 3;
  score =0;
  birdX = 200;
  birdY = 200; 
 
  if (christmasMode)
    resetPipes();
  else  
    resetGhosts();
  
}

void resetPipes()
{
  currPipe = -1;
  pipeSpeed = 4;

  for (i=0; i< pipeX.length; i++) {
    pipeX[i] = width + distance*i;
    pipeY[i] = (int)random(-350, 0);
  }
}

void resetGhosts ()
{
  ghostNum = 4;
  creepyGhosts.clear();
  cuteGhosts.clear();
  for(int i = 0 ; i < ghostNum ; i++)
  {
    creepyGhosts.add(new Ghost());
    cuteGhosts.add(new Ghost());
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
  bird = christmasMode? christmasBird : hallowenBird;
  image(bird, birdX, birdY);
  birdY = birdY + birdYS;
  birdYS += 0.8;
  if (birdY + bird.height >= height) {
    tries--;
  }
  
}

void jump() {
  if ((mousePressed && mouseButton == LEFT) || (keyPressed && key == ' ')) {
    if (birdY - bird.height/2 >= 10  )
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

void setGhost(){
  
  for(int i = creepyGhosts.size() ; i< ghostNum ; i++)
  {
    creepyGhosts.add(new Ghost());
  }
  for (int i = 0; i < ghostNum ; i++)
  {
    Ghost ghost = creepyGhosts.get(i);
    ghost.moveGhostX(); 
    ghost.draw(creepyGhost);
    ghost.moveGhostY();
    checkLife2(ghost);
  }
  
  for (int i = 0; i < cuteGhosts.size(); i++)
  {
    Ghost ghost = cuteGhosts.get(i);
    ghost.moveGhostX(); 
    ghost.draw(cuteGhost);
    ghost.moveGhostY();
    attackCuteGhost(ghost);
  }
  
}

void checkLife2 (Ghost ghost)
{
   if ( ghost.isAttacker() && hallowenBirdFaceX >= ghost.getGhostX() && hallowenBirdFaceX <=ghost.getGhostX() + creepyGhost.width && abs(birdY - ghost.getGhostY()) <=hallowenBird.height )
       {
         tries--;
         hit.play();
         ghost.setAttacker(false);
       }
}

 void attackCuteGhost (Ghost ghost)
  {
     if ( abs(birdX - ghost.getGhostX()) <= hallowenBird.width && abs(birdY - ghost.getGhostY()) <=hallowenBird.height )
       {
         eat.play();
         score++;
         ghost.remove();
         levelUp();
       }
  }


void setScore() {
  textSize(25);
  text ("Score : "+score, width-170, 40);
}

void levelUp() {
  if (christmasMode && (score%8) ==0 && pipeSpeed <= 15 ) {// score+1 in case of hit at score 0 so 0%x will be 0 so will level up at 0 score doesn't make sense
    pipeSpeed += 2;
  }
 else if ((score % 8) ==0 && ghostNum <= 10){
      ghostNum += 2;  
  }
    
}
