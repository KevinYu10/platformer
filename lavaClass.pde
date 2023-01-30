class FLava extends FGameObject {

  int frame;

  FLava(float x, float y) {
    super();
    setPosition(x*gridSize, y*gridSize);
    setGrabbable(false);
    setStatic(true);
    setSensor(true);
    attachImage(lavaImage[0]);
    frame = 0;
    setName("lava");
  }

  void act() {
    if (frame>= lavaImage.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(lavaImage[frame]);
      frame++;
    }
  }
}
