class Ghost {
 
 private int ghostX = (int)random(width , width +width/2) , ghostY = (int)random(height);
 private boolean ghostAttack = true; 
 private int yChange ;  
 
 Ghost()
 {
   yChange = (int)random(-2,2);
 }
 
 void moveGhostX ()
 {
   this.ghostX -= 6;
   handleOutOfScreenGhost();
 }
 
 void handleOutOfScreenGhost ()
 {
     if( this.ghostX < -80 ){
      this.ghostX = width;
      this.ghostY = (int) random(height);
      setAttacker(true);
   }
 }
 
 void moveGhostY ()
 {
   this.ghostY += yChange;
 }
 
 int getGhostX ()
 {
   return this.ghostX;
 }
 
 int getGhostY ()
 {
   return this.ghostY;
 }
 
 void setAttacker (boolean isAttacker)
 {
   this.ghostAttack = isAttacker;
 }
 
 boolean isAttacker ()
 {
   return this.ghostAttack;
 }
 
 void drawGhost (PImage image)
 {
   image(image , this.ghostX,this.ghostY);
 }
   
 void removeGhost ()
 {
    this.ghostX = -90;
    handleOutOfScreenGhost();
 }
 
}
