void startScreen()
{
  image(start, 0, 0);
  image(help, 720, 10);

  startScreenButton();
  //start modes
  //fill(0, 100); 
  //ellipse(400, 500, 50, 50);
  //triangle(390, 490, 390, 510, 415, 500);

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
  //if (mouseX > 350 && mouseX < 450 && mouseY < 550 && mouseY > 450) 
  //{
  //  fill(0, 100);  //play button
  //  ellipse(400, 500, 60, 60);
  //  if (mousePressed) 
  //  {
  //    println("mode pressed");
  //    isStart = false;
  //    isMode = true;
  //    click.play();
  //    modeScreen();
  //  }
  //}
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


//void endScreen2() {
//  hit.stop();
//  eat.stop();
//  halloweenMusic.stop();
//  jingleBells.stop();

//  background(#978FF5);
//  /*fill(0 , 60);
//   rect(0,0,800,800);*/
//  //game over image
//  gameOver.resize(400, 400);
//  image(gameOver, 200, -100);

//  //dead bird image
//  //birdDead.resize(70, 60);
//  //image(birdDead, 600, 50);

//  //rotated bird
//  for (int i=0; i< xx.length; i++) {
//    pushMatrix();
//    translate(xx[i], yy[i]);
//    rotate(angleBird);
//    background(0);
//    birdDead.resize(50, 40);
//    if (xx[i] < -50 ) {
//      xx[i] = width/2;
//    }
//    image(birdDead, xx[i], yy[i]);
//    // the gBird to slow down the bird rotation
//    angleBird += 0.01 * gBird;
//    popMatrix();
//  }

//  /* pushMatrix();
//   translate(403, 90);
//   rotate(angle);
//   angle+=0.03;
//   birdDead.resize(20, 20);
//   image(birdDead, -birdDead.width/2, -birdDead.height/2);
//   popMatrix();
//   */

//  //modeScreen
//  textSize(40);
//  stroke(#B89FE8);
//  fill(#B89FE8);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 150, 200, 80);
//  noStroke();
//  fill(255);
//  //textAlign(CENTER);
//  text ("Mode", width/2, 200);
//  modeScreenButton(300, 150, 200, 80);

//  //reset
//  textSize(40);
//  stroke(#B89FE8);
//  fill(#B89FE8);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 300, 200, 80);
//  noStroke();
//  fill(255);
//  text ("Reset", width/2, 350);
//  resetButton(300, 300, 200, 80);

//  //quit
//  textSize(40);
//  stroke(#B89FE8);
//  fill(#B89FE8);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 450, 200, 80);
//  noStroke();
//  fill(255);
//  text ("Quit", width/2, 500);
//  quitButton(300, 450, 200, 80);

//  fill(255);
//  textSize(20);
//  textFont(font);
//  textAlign(CENTER);
//  text ("Use the LEFT click to click on quit.\nor reset or mode.", 400, 650);

//  //jingleBells.stop();
//}

//void quitScreen()
//{
//  team.resize(800, 800);
//  image(team, 0, 0);
//  textSize(40);
//  fill(255);
//  text(txt, 250, y);
//  y-=1;
//  if (y <= -250)
//  {
//    y = 200;
//  }
//  textSize(15);
//  text ("Press ESC button to end the game.\nUse the left click to click on back or mode.", 5, 600);

//  //Start
//  textSize(30);
//  stroke(#80C2DB);
//  fill(#80C2DB);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(600, 500, 100, 50);
//  noStroke();
//  fill(255);
//  text ("Start", 610, 535);

//  if (isMouseOver(600, 500, 100, 50)== true && (mousePressed && mouseButton == LEFT))
//  {
//    isQuit =false;
//    isMode = false;
//    y = 200;
//    isStart = true;
//    startScreen();
//  }

//  //back
//  textSize(30);
//  stroke(#80C2DB);
//  fill(#80C2DB);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(600, 600, 100, 50);
//  noStroke();
//  fill(255);
//  text ("Back", 610, 635);


//  if (isMouseOver(600, 600, 100, 50)== true && (mousePressed && mouseButton == LEFT))
//  {
//    click.play();
//    isQuit =false;
//    y = 200;
//    endScreen();
//  }
//}

//void endScreen() {
//  hit.stop();
//  eat.stop();
//  halloweenMusic.stop();
//  jingleBells.stop();

//  background(#5F9BB2);
//  //game over image
//  gameOver.resize(400, 400);
//  image(gameOver, 200, -100);

//  ////dead bird image
//  birdDead.resize(70, 60);
//  image(birdDead, 600, 50);

//  //rotated bird
//  /*pushMatrix();
//  translate(403, 90);
//  rotate(angle);
//  angle+=0.05;
//  birdDead.resize(20, 20);
//  image(birdDead, -birdDead.width/2, -birdDead.height/2);
//  popMatrix();*/

//  //modeScreen
//  textSize(40);
//  stroke(#80C2DB);
//  fill(#80C2DB);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 150, 200, 80);
//  noStroke();
//  fill(255);
//  text ("Mode", 350, 200);
//  modeScreenButton(300, 150, 200, 80);

//  //reset
//  textSize(40);
//  stroke(#80C2DB);
//  fill(#80C2DB);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 300, 200, 80);
//  noStroke();
//  fill(255);
//  text ("Reset", 350, 350);
//  resetButton();

//  //quit
//  textSize(40);
//  stroke(#80C2DB);
//  fill(#80C2DB);
//  strokeWeight(20);
//  strokeJoin(ROUND); // Round the stroke corners
//  rect(300, 450, 200, 80);
//  noStroke();
//  fill(255);
//  text ("Quit", 350, 500);
//  quitButton(300, 450, 200, 80);

//  fill(255);
//  textSize(20);
//  text ("Press DELETE button to quit.\nYou also can press space to reset and enter to go to modeScreen.", 5, 600);

//  //jingleBells.stop();
//}
