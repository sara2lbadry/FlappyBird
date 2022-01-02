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
  modeScreenButton(400, 0, 5, 800);
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

  background(#5F9BB2);
  //game over image
  gameOver.resize(400, 400);
  image(gameOver, 200, -100);

  //dead bird image
  birdDead.resize(70, 60);
  image(birdDead, 600, 50);
  
  //rotated bird
  /*pushMatrix();
  translate(403, 90);
  rotate(angle);
  angle+=0.05;
  birdDead.resize(20, 20);
  image(birdDead, -birdDead.width/2, -birdDead.height/2);
  popMatrix();*/

  //modeScreen
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 150, 200, 80);
  noStroke();
  fill(255);
  text ("Mode", 350, 200);
  modeScreenButton(300, 150, 200, 80);

  //reset
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 300, 200, 80);
  noStroke();
  fill(255);
  text ("Reset", 350, 350);
  resetButton();

  //quit
  textSize(40);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 450, 200, 80);
  noStroke();
  fill(255);
  text ("Quit", 350, 500);
  quitButton(300, 450, 200, 80);

  fill(255);
  textSize(20);
  text ("Press DELETE button to quit.\nYou also can press space to reset and enter to go to modeScreen.", 5, 600);

  //jingleBells.stop();
}

void quitScreen()
{
  team.resize(800, 800);
  image(team, 0, 0);
  textSize(40);
  fill(255);
  text(txt, 250, y);
  y-=1;
  if (y <= -250)
  {
    y = 200;
  }
  textSize(15);
  text ("Press ESC button to end the game.\nUse the left click to click on back or mode.", 5, 600);

  //Start
  textSize(30);
  stroke(#80C2DB);
  fill(#80C2DB);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(600, 500, 100, 50);
  noStroke();
  fill(255);
  text ("Start", 610, 535);

  if (isMouseOver(600, 500, 100, 50)== true && (mousePressed && mouseButton == LEFT))
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
  rect(600, 600, 100, 50);
  noStroke();
  fill(255);
  text ("Back", 610, 635);

  if (isMouseOver(600, 600, 100, 50)== true && (mousePressed && mouseButton == LEFT))
  {
    click.play();
    isQuit =false;
    y = 200;
    endScreen();
  }
}

boolean isMouseOver(int x, int y, int w, int h) {
  if (mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h) {
    fill(0, 90);
    rect(x, y, w, h);
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
      println("startScreenButton pressed");
      isStart = false;
      click.play();
      resetGame(true);
      modeScreen();
    }
  }
}

void modeScreenButton(int x, int y, int w, int h) {
  if (isMouseOver(x, y, w, h)== true && (mousePressed && mouseButton == LEFT)) {
    println("mode pressed");
    click.play();
    resetGame(true);
  }
}

void resetButton() {
  if (isMouseOver(300, 300, 200, 80) == true && (mousePressed && mouseButton == LEFT))
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

void quitButton(int x, int y, int w, int h) {
  if (isMouseOver(x, y, w, h)== true && (mousePressed && mouseButton == LEFT)  || (keyPressed && key == DELETE)) {
    println("quit pressed");  
    click.play();
    isQuit =true;
  }
}
