class FGameObject extends FBox {

  FGameObject() {
    super(gridSize, gridSize);
  }

  FGameObject(int w, int h) {
    super(w, h);
  }

  void act() {
  }

  boolean checkForCollision(String t) {
    ArrayList<FContact> contacts = getContacts();
    for (int i=0; i<contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(t)) {
        return true;
      }
    }
    return false;
  }
}
