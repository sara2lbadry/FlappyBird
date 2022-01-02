void startScreen()
{
  image(start, 0, 0);
  image(help, 720, 10);
  
  //start modes
  fill(0, 100); 
  ellipse(400, 500, 50, 50);
  triangle(390, 490, 390, 510, 415, 500);
  
  //help button
  if (mouseX > 720 && mouseX <= 770 && mouseY <= 60 && mouseY > 10) 
  {
      helpButton();   
  }
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

  background(#978FF5);
  /*fill(0 , 60);
  rect(0,0,800,800);*/
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
  stroke(#B89FE8);
  fill(#B89FE8);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 150, 200, 80);
  noStroke();
  fill(255);
  text ("Mode", 350, 200);
  modeScreenButton(300, 150, 200, 80);

  //reset
  textSize(40);
  stroke(#B89FE8);
  fill(#B89FE8);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 300, 200, 80);
  noStroke();
  fill(255);
  text ("Reset", 350, 350);
  resetButton();

  //quit
  textSize(40);
  stroke(#B89FE8);
  fill(#B89FE8);
  strokeWeight(20);
  strokeJoin(ROUND); // Round the stroke corners
  rect(300, 450, 200, 80);
  noStroke();
  fill(255);
  text ("Quit", 350, 500);
  quitButton(300, 450, 200, 80);

  fill(255);
  textSize(20);
  text ("Use the LEFT click to click on quit.\nor reset or mode.", 5, 600);

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
  text ("Press ESC button to end the game.\nUse the LEFT click to click on back or mode.", 5, 600);

  //Start
  textSize(30);
  stroke(#B89FE8);
  fill(#B89FE8);
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
  stroke(#B89FE8);
  fill(#B89FE8);
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
    fill(#B89FE8, 150);
    rect(x, y, w, h);
    return  true;
  }
  return false;
}

void startScreenButton()
{
   isStart = true;
  if (mouseX > 350 && mouseX < 450 && mouseY < 550 && mouseY > 450) 
  {
    fill(0, 100);  //play button
    ellipse(400, 500, 60, 60);
    if (mouseButton == LEFT) 
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
  if (isMouseOver(x, y, w, h)== true && (mousePressed && mouseButton == LEFT)) {
    println("quit pressed");  
    click.play();
    isQuit =true;
  }
}

void helpButton()
{
  isStart = false;
  println("help pressed");
  fill(0,90);
  rect(420,30,300,190);
  fill(255);
  textSize(25);
  text ("Christmas Mode:", 430, 55);
  text ("Halloween Mode:", 430, 135);
  textSize(15);
  text ("Left click or press space to increase\nscore and avoid pipes.", 430, 80);
  text ("Left click or press space to eat ghosts,\nincrease score and avoid bats.", 430, 160);
  
  if(! (mouseX > 720 && mouseX <= 770 && mouseY <= 60 && mouseY > 10) )
  {
    mouseX = mouseX;
    mouseY = mouseY;
  }
}
