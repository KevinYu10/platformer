class FHammerbro extends FGameObject {

  int frame;
  int direction;
  float speed;
  boolean turn;
  int lives;
  final int left = -1;
  final int right = 1;

  FHammerbro(float x, float y) {
    super();
    setPosition(x*gridSize, y*gridSize);
    frame = 0;
    setGrabbable(false);
    setRotatable(false);
    direction = right;
    speed = 80;
    lives = 3;
    turn = false;
  }

  void act() {
    if (frame >= hammerbros.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == right) attachImage(hammerbros[frame]);
      if (direction == left) attachImage(reverseImage(hammerbros[frame]));
      frame++;
    }

    float vy = getVelocityY();
    setVelocity(speed*direction, vy);

    if (checkForCollision("brick")) {
      turn = true;
      direction *= -1;
      setPosition(getX()+direction*5, getY());
    } else {
      turn = false;
    }

    if (turn) {
      FBox b = new FBox(gridSize, gridSize);
      b.attachImage(hammer);
      b.setPosition(getX(), getY());
      b.setSensor(true);
      b.setVelocity(b.getVelocityX(), -500);
      b.setAngularVelocity(200);
      b.setGrabbable(false);
      b.setName("flyingHammer");
      world.add(b);
    }
    if (checkForCollision("player")) {
      if (player.getY() > getY()-gridSize/2) {
        player.setPosition(150, 200);
        player.lives--;
      } else if (player.getY()<getY()-gridSize) {
        world.remove(this);
        enemies.remove(this);
      }
    }
  }
}
