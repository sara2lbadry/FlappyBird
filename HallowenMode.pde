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

void setGhost() {

  for (int i = creepyGhosts.size(); i< ghostNum; i++)
  {
    creepyGhosts.add(new Ghost());
  }
  for (int i = 0; i < ghostNum; i++)
  {
    Ghost ghost = creepyGhosts.get(i);
    ghost.moveGhostX(); 
    ghost.drawGhost(creepyGhost);
    ghost.moveGhostY();
    checkLife2(ghost);
  }

  for (int i = 0; i < cuteGhosts.size(); i++)
  {
    Ghost ghost = cuteGhosts.get(i);
    ghost.moveGhostX(); 
    ghost.drawGhost(cuteGhost);
    ghost.moveGhostY();
    attackCuteGhost(ghost);
  }
}
void attackCuteGhost (Ghost ghost)
{
  if ( abs(birdX - ghost.getGhostX()) <= hallowenBird.width && abs(birdY - ghost.getGhostY()) <=hallowenBird.height )
  {
    eat.play();
    score++;
    ghost.removeGhost();
    levelUp();
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

void resetGhosts ()
{
  ghostNum = 4;
  creepyGhosts.clear();
  cuteGhosts.clear();
  for (int i = 0; i < ghostNum; i++)
  {
    creepyGhosts.add(new Ghost());
    cuteGhosts.add(new Ghost());
  }
}
