class FGoomba extends FGameObject {

  float timer;
  int direction;
  int frame;
  float speed = 100;
  final int left  = -1;
  final int right = 1;
  int lives;

  FGoomba(float x, float y) {
    super();
    setPosition(x*gridSize, y*gridSize);
    direction = left;
    frame = 0;
    lives = 3;
    setGrabbable(false);
    setRotatable(false);
    setName("goomba");
  }

  void act() {
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);

    if (frameCount % 10 == 0) {
      frame++;
    }

    if (frame >= goombas.length) {
      frame = 0;
    }
    attachImage(goombas[frame]);

    if (checkForCollision("player")) {
      if (player.getY() > getY()-gridSize/2+2) {
        player.setPosition(150, 200);
        player.lives--;
      } else if (player.getY()<getY()-gridSize) {
        world.remove(Goomba);
        enemies.remove(Goomba);
        player.lives++;
      }
    }

    if (checkForCollision("brick")) {
      direction *= -1;
      setPosition(getX()+direction*5, getY());
    }
  }
}
