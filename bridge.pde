class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super();
    setPosition(x*gridSize, y*gridSize);
    setName("bridge");
    setStatic(true);
    setGrabbable(false);
    attachImage(bridgeCenter);
  }

  void act() {
    if (checkForCollision("player")) {
      setStatic(false);
      setSensor(true);
    }
  }
}
