

void setup() {
  size(800, 800);
  init();
}

void draw() {
  //start and instructions
  if (isStart) {
    startScreen();
  }
  //Choose mode
  else if (isMode) {
    modeScreen();
  } else if (tries>0) 
  {
    setBackground();
    setBird();
    jump();  
    if (christmasMode) {
      snowFall();
      movingPipes();
    } else 
    {
      setGhost();
    }
    setScore();
    birdHearts();
  } else
  {
    endScreen();
  }
}

void resetGame(boolean mode) {
  isMode = mode;
  isLife = true;
  isQuit =false;
  tries = 3;
  score =0;
  birdX = 200;
  birdY = 200; 

  if (christmasMode)
    resetPipes();
  else  
  resetGhosts();
}


void setScore() {
  textSize(25);
  text ("Score : "+score, width-170, 40);
}

void levelUp() {
  if (christmasMode && ((score+1)%8) ==0 && pipeSpeed <= 15 ) {// score+1 in case of hit at score 0 so 0%x will be 0 so will level up at 0 score doesn't make sense
    pipeSpeed += 2;
  } else if (((score+1) % 8) ==0 && ghostNum <= 10) {
    ghostNum += 2;
  }
}
