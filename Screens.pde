void startScreen()
{
  image(start, 0, 0);
  image(help, 720, 10);

  startScreenButton();

  //help button
  if (isMouseOver(720, 10, help.width, help.height))
  {
    makeHover(720, 10, help.width, help.height, #4EC0CA, 50);
    helpButton();
  }
}

void startScreenButton()
{    
  buttonStart.resize(200, 80);

  int x = width/2 - buttonStart.width/2 ; 
  int y = 430;
  image(buttonStart, x, y);
  if (isMouseOver(x, y, buttonStart.width, buttonStart.height))
  {
    makeHover(x, y, buttonStart.width, buttonStart.height, #4EC0CA, 50);
    if ((mousePressed && mouseButton == LEFT)) {
      println("mode pressed");
      isStart = false;
      isMode = true;
      click.play();
      modeScreen();
    }
  }
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
    nightMode();
  }
}

void endScreen() {
  hit.stop();
  eat.stop();
  halloweenMusic.stop();
  jingleBells.stop();

  background(0);
  stars.resize(1000, 800);
  image(stars, -100, 0);

  gameOver.resize(500, 70);

  int initY = 220, initX = 400; // to make drawing relative to (220,400) instead of (0,0)
  int dH = 100; // horizontal margin
  int dV = 80; // vertical margin
  int x, y;  

  //rotated bird
  birdDead.resize(50, 40);
  pushMatrix();
  translate(width/2, width/2);
  rotate(angleBird);  
  image(birdDead, width/2 , 0);
  angleBird += 0.1 * gBird;
  popMatrix();



  image(gameOver, initX-gameOver.width/2, initY);  

  textSize(40);  
  fill(255);
  textAlign(CENTER);
  text ("SCORE: "+score+" ", initX, initY + gameOver.height + dV);

  x = initX -buttonHome.width/2; 
  y = initY + gameOver.height + dV +80;
  image(buttonHome, x, y);
  modeScreenButton(x, y, buttonHome.width, buttonHome.height);

  x = initX+buttonHome.width/2 + dH;
  y = initY + gameOver.height + dV +80;
  image(buttonNext, x, y);
  resetButton(x, y, buttonNext.width, buttonNext.height);

  x = initX-buttonHome.width/2 - dH - buttonBack.width;
  y = initY + gameOver.height + dV +80;
  image(buttonBack, x, y);
  quitButton(x, y, buttonBack.width, buttonBack.height);  
  textAlign(LEFT);
}

void makeHover(int x, int y, int w, int h, int colour, int opacity) {
  fill(colour, opacity);    
  rect(x, y, w, h);
}

boolean isMouseOver(int x, int y, int w, int h) {
  return (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h)? true: false;
}

void modeScreenButton(int x, int y, int w, int h) { 

  if (isMouseOver(x, y, w, h)== true) {
    makeHover(x, y, w, h, 0, 90);
    textSize(15);  
    fill(255);
    text ("HOME", x, y+buttonHome.height, w, h);
    if ((mousePressed && mouseButton == LEFT)) {
      println("mode pressed");
      click.play();
      resetGame(true);
    }
  }
}

void resetButton(int x, int y, int w, int h) {
  if (isMouseOver(x, y, w, h)== true) {
    makeHover(x, y, w, h, 0, 90);
    textSize(15);  
    fill(255);
    text ("AGAIN", x, y+buttonNext.height+5, w, h); //+5 MARGIN FROM BUTTON
    if ((mousePressed && mouseButton == LEFT))
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
}

void quitButton(int x, int y, int w, int h) {
  if (isMouseOver(x, y, w, h)== true) {
    makeHover(x, y, w, h, 0, 90);
    textSize(15);  
    fill(255);
    text ("EXIT", x, y+buttonBack.height, w, h);
    if ((mousePressed && mouseButton == LEFT)|| (keyPressed && key == DELETE))
    {
      println("quit pressed");  
      click.play();
      isQuit =true;
      exit();
    }
  }
}

void helpButton()
{
  makeHover(720, 10, help.width, help.height, #4EC0CA, 90);
  textAlign(CENTER);
  fill(0, 90);
  rect(420, 17, 300, 190);
  fill(255);
  textSize(25);
  text ("Christmas Mode", 570, 55);
  text ("Halloween Mode", 570, 135);
  textSize(15);
  text ("Press LEFT CLICK or SPACE\navoid pipes & increase score", 570, 80);
  text ("Press LEFT CLICK or SPACE\neat ghosts, avoid bats & increase score", 570, 160);
  textAlign(LEFT);
}
