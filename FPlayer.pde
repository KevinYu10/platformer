class FPlayer extends FGameObject {

  int lives;
  int frame;
  int direction;
  final int L = -1;
  final int R = 1;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(150, 200);
    setFillColor(lava);
    setGrabbable(false);
    setRotatable(false);
    setName("player");
    lives = 3;
  }

  void act() {
    handleInput();
    collision();
    animation();
  }

  void handleInput() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    if (abs(vy)<0.1) action = idle;
    if (akey) {
      setVelocity(-200, vy);
      action = run;
      direction = L;
    }
    if (dkey) {
      setVelocity(200, vy);
      action = run;
      direction = R;
    }
    vy = getVelocityY();
    vx = getVelocityX();
    if (wkey) {
      setVelocity(vx, -400);
    }
    if (abs(vy)>0.1) action = jump;
    if (skey) {
      setVelocity(vx, 400);
    }
  }

  void collision() {
    if (checkForCollision("spikes")) {
      setPosition(150, 200);
      lives--;
    }
    if (checkForCollision("lava")) {
      setPosition(150, 200);
      lives--;
    }
    if (checkForCollision("flyingHammer")) {
      setPosition(150, 200);
      lives--;
    }
    if (checkForCollision("chest")) {
      mode = win;
    }
  }
  void animation() {
    if (frame>=action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
