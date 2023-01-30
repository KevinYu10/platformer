class Button {

  //instance variables
  float x, y, w, h;  //x, y is the center
  boolean clicked;
  color highlight, normal;
  String text;
  PImage img;

  //constructor
  Button(String t, float _x, float _y, float _w, float _h, color norm, color high) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    highlight = high;
    normal = norm;
    clicked = false;
    text = t;
  }

  Button(PImage pic, float _x, float _y, float _w, float _h, color norm, color high) {
    this("", _x, _y, _w, _h, norm, high);
    img = pic;
  }

  //Behaviour Functions
  void show() {
    drawBody();
    drawLabel();
    checkForClick();
  }

  void drawBody() {

    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      fill(highlight);
    } else {
      fill(normal);
    }
    stroke(0);
    strokeWeight(4);
    rect(player.getX(), player.getY(), w, h, 30);
  }


  void drawLabel() {
    textAlign(CENTER, CENTER);
    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      fill(normal);
    } else {
      fill(highlight);
    }
    if (img == null) {
      textSize(w/4);
      textLeading(30);
      text(text, x, y);
    } else {
      image(img, x, y, w-20, h-20);
    }
  }

  void checkForClick() {
    if (mouseReleased && mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      clicked  = true;
    } else {
      clicked = false;
    }
  }
}
