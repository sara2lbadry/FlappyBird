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
  if (mouseX >= 175 && mouseX <= 225 && mouseY >= 375 && mouseY <= 475) 
  {
    println(mouseX + " aaa " + mouseY);
    fill(0, 100);  //play button
    ellipse(200, 400, 60, 60);
    fill(255, 150); 
    triangle(190, 390, 190, 410, 212, 400);
    if (mousePressed ) 
    {
      christmasMode = true;
      click.play();
      isMode = false; 
      jingleBells.loop();
    }
  }
}

void snowFall()
{
  for (int i = 0; i < snowY.length; i++)
  {
    pushMatrix();
    translate(snowX[i], snowY[i]);
    rotate(angle);
    angle+=0.003;

    if (i % 2 == 0)
    {
      image(snow, -snow.width/2, -snow.height/2);
    } else {      
      image(snow2, -snow2.width/2, -snow2.height/2);
    }
    popMatrix();

    snowY[i] += 3;
    if (snowY[i] > 650)
    {
      snowY[i] = 0;
    }
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

  if ((pipeX+pipeW < birdX && tries>0 && pipeX+pipeW + pipeSpeed >= birdX )) { //195<pipeX<200 possibility of existance of 
    score++;
    levelUp();
  }
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
