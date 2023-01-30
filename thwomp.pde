class FThwomp extends FGameObject {


  FThwomp(float x, float y) {
    super(gridSize*2, gridSize*2);
    setPosition(x*gridSize+gridSize/2, y*gridSize+gridSize/2);
    attachImage(thwompImage0);
    setStatic(true);
    setGrabbable(false);
    setRotatable(false);
    setFriction(5);
  }

  void act() {
    if (player.getY() > getY()) {
      if (player.getX()+gridSize/2 > getX()-gridSize-2 && player.getX()-gridSize/2 < getX()+gridSize+2) {
        attachImage(thwompImage1);
        setStatic(false);
      }
    }
    if (checkForCollision("player")) {
      if (player.getY()>= getY()+gridSize) {
        player.lives--;
        player.setPosition(150, 200);
      }
    }
  }
}
