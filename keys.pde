void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'o' || key == 'O') okey = true;
  if (key == 'p' || key == 'P') pkey = true;
  if (key == 't' || key == 'T') tkey = true;
  if (keyCode == ' ') spacekey = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'o' || key == 'O') okey = false;
  if (key == 'p' || key == 'P') pkey = false;
  if (key == 't' || key == 'T') tkey = false;
  if (keyCode == ' ') spacekey = false;
}
