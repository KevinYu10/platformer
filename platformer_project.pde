import fisica.*;

color white       = #FFFFFF;
color black       = #000000;

color grass       = #00FF00;
color lava        = #ff0000;
color ice         = #00b7ef;
color trampoline  = #40ff40;
color orange      = #F0A000;
color dirt        = #ffaa00;
color spike       = #b4b4b4;
color brick       = #a5b0a5;

color trunk       = #9c5a3c;
color treeInter   = #a6e61d;
color centerTree  = #52ff52;
color leftTree    = #23f523;
color rightTree   = #13f713;

color thwomp      = #174d06;
color goomba      = #d030e3;
color hammerbro   = #0416F9;
color chest       = #e6ff08;

color centerBridge = #b66800;

int mode;
final int Game = 0;
final int Gameover = 1;
final int win = 2;
final int pause = 3;

PImage map, map2, brickImage, spikeImage, iceImage, grassImage, dirtImage, trampolineImage;
PImage thwompImage0, thwompImage1;
PImage lavaImage0, lavaImage1, lavaImage2, lavaImage3, lavaImage4, lavaImage5;
PImage[] lavaImage;
int lavaFrame = 0;
PImage trunkImage, treeIntersect, treeCenter, treeLeft, treeRight;
PImage bridgeCenter;
int gridSize;
float zoom = 1;

boolean wasPressed, mouseReleased;

PImage[] run;
PImage[] jump;
PImage[] idle;
PImage[] action;

PImage[] goombas;
PImage[] hammerbros;
PImage hammer, treasureChest;

FWorld world;

boolean wkey, dkey, akey, skey;
boolean okey, pkey, spacekey, tkey;

FPlayer player;
FGoomba Goomba;
FThwomp Thwomp;
FHammerbro Hammerbro;
ArrayList <FGameObject> terrain;
ArrayList <FGameObject> enemies;

void setup() {
  size(600, 600);
  mode = Game;
  Fisica.init(this);
  world = new FWorld(-2000, -2000, 2000, 2000);
  world.setGravity(0, 900);
  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  lavaImage = new PImage[6];
  lavaImage[0] = loadImage("lava0.png");
  lavaImage[1] = loadImage("lava1.png");
  lavaImage[2] = loadImage("lava2.png");
  lavaImage[3] = loadImage("lava3.png");
  lavaImage[4] = loadImage("lava4.png");
  lavaImage[5] = loadImage("lava5.png");

  loadImages();
  loadWorld();
  imageResize();
  loadPlayer();
  playerAction();
}

void loadImages() {
  map = loadImage("map.gif");
  map2 = loadImage("map3.gif");
  brickImage = loadImage("brick.png");
  grassImage = loadImage("grass.png");
  dirtImage = loadImage("dirt_center.png");
  iceImage = loadImage("ice.png");
  trampolineImage = loadImage("trampoline.png");
  spikeImage = loadImage("spike.png");

  trunkImage = loadImage("tree_trunk.png");
  treeIntersect = loadImage("tree_intersect.png");
  treeCenter = loadImage("treetop_center.png");
  treeLeft = loadImage("treetop_w.png");
  treeRight = loadImage("treetop_e.png");

  bridgeCenter = loadImage("bridge_center.png");

  lavaImage0 = loadImage("lava0.png");
  lavaImage1 = loadImage("lava1.png");
  lavaImage2 = loadImage("lava2.png");
  lavaImage3 = loadImage("lava3.png");
  lavaImage4 = loadImage("lava4.png");
  lavaImage5 = loadImage("lava5.png");

  thwompImage0 = loadImage("thwomp0.png");
  thwompImage1 = loadImage("thwomp1.png");

  hammer = loadImage("hammer.png");
  treasureChest = loadImage("chest.jpeg");
}

void loadWorld() {
  gridSize = 30;

  for (int y = 0; y < map.height; y++) {
    for (int x = 0; x < map.width; x++) {
      color c = map.get(x, y);
      if (c == black) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, brickImage, "stone");
        world.add(b);
      }
      if (c == brick) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, brickImage, "brick");
        world.add(b);
      }
      if (c == grass) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, grassImage, "grass");
        world.add(b);
      }
      if (c == dirt) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, dirtImage, "dirt");
        world.add(b);
      }
      if (c == ice) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, iceImage, "ice");
        b.setFriction(0);
        world.add(b);
      }
      if (c == lava) {
        FLava fl = new FLava(x, y);
        terrain.add(fl);
        world.add(fl);
      }
      if (c == trampoline) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, trampolineImage, "trampoline");
        b.setRestitution(3);
        world.add(b);
      }
      if (c == spike) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, spikeImage, "spikes");
        world.add(b);
      }
      if (c == treeInter) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, treeIntersect, "treeIntersect");
        world.add(b);
      }
      if (c == trunk) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, trunkImage, "trunk");
        b.setSensor(true);
        world.add(b);
      }
      if (c == centerTree) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, treeCenter, "rightTrees");
        world.add(b);
      }
      if (c == leftTree) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, treeLeft, "leftTrees");
        world.add(b);
      }
      if (c == rightTree) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, treeRight, "rightTrees");
        world.add(b);
      }
      if (c == centerBridge) {
        FBridge fb = new FBridge(x, y);
        terrain.add(fb);
        world.add(fb);
      }
      if (c == thwomp) {
        Thwomp = new FThwomp(x, y);
        enemies.add(Thwomp);
        world.add(Thwomp);
      }
      if (c == goomba) {
        Goomba = new FGoomba(x, y);
        enemies.add(Goomba);
        world.add(Goomba);
      }
      if (c == hammerbro) {
        Hammerbro = new FHammerbro(x, y);
        enemies.add(Hammerbro);
        world.add(Hammerbro);
      }
      if (c == chest) {
        FBox b = new FBox(gridSize, gridSize);
        buildBlock(b, x, y, treasureChest, "chest");
        world.add(b);
      }
    }
  }
}

void buildBlock(FBox b, float x, float y, PImage p, String s) {
  b.setPosition(x*gridSize, y*gridSize);
  b.setStatic(true);
  b.setGrabbable(false);
  b.attachImage(p);
  b.setFriction(5);
  b.setName(s);
}

void imageResize() {
  iceImage.resize(gridSize, gridSize);
  thwompImage0.resize(gridSize*2, gridSize*2);
  thwompImage1.resize(gridSize*2, gridSize*2);
  treasureChest.resize(gridSize, gridSize);
}


void loadPlayer() {
  player = new FPlayer();

  world.add(player);
}

void playerAction() {
  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");
  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");
  action = idle;

  goombas = new PImage[2];
  goombas[0] = loadImage("goomba0.png");
  goombas[0].resize(gridSize, gridSize);
  goombas[1] = loadImage("goomba1.png");
  goombas[1].resize(gridSize, gridSize);

  hammerbros = new PImage[2];
  hammerbros[0] = loadImage("hammerbro0.png");
  hammerbros[0].resize(gridSize, gridSize);
  hammerbros[1] = loadImage("hammerbro1.png");
  hammerbros[1].resize(gridSize, gridSize);

  for (int i = 0; i<lavaImage.length; i++) {
    lavaImage[i].resize(gridSize, gridSize);
  }
}

void draw() {
  background(white);
  if (player.lives <= 0) {
    mode = Gameover;
  }
  if (mode == Game) {
    drawWorld();
    actWorld();
  }
  if(tkey) {
    mode = pause;
  }
  if (mode == Gameover) {
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("GameOver\n you lose :(\n click to return", width/2, height/2);
  } else if (mode == win) {
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("GameOver\n you win :) \n click to return", width/2, height/2);
  } else if(mode == pause) {
    textSize(50);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("Paused\n click to return", width/2, height/2);
  }
  if (mode == win && mousePressed) {
    mode = Game;
    player.lives = 3;
    player.setPosition(150, 200);
  }
  if (mode == Gameover && mousePressed) {
    mode = Game;
    player.lives = 3;
    player.setPosition(150, 200);
  }
  if(mode == pause && mousePressed) {
    mode = Game;
  }
}

void actWorld() {
  player.act();
  for (int i=0; i<terrain.size(); i++) {
    FGameObject obj = terrain.get(i);
    obj.act();
  }
  for (int i = 0; i<enemies.size(); i++) {
    FGameObject en = enemies.get(i);
    en.act();
  }
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0);
  text(player.lives, width-20, 20);
}

void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom+width/2, -player.getY()*zoom+height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();

  if (okey) {
    zoom+=0.01;
  }
  if (pkey) {
    zoom-=0.01;
  }
}
