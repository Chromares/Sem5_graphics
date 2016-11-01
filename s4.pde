import peasy.*;

PeasyCam cam;



float speed = 5, fakespeed;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean movecam = false, check = false, action = false;
int herox  = width/2, heroy = height/2 + 80;
class player {
  //let it be a ball for now;
  int rad;
  int posx;
  int posy;
  int hp;
  int magic;
  int status;
  int skip;
  player(int radius, int xpos, int ypos, int h, int m) {
    rad = radius;
    posx = xpos;
    posy = ypos;
    hp = h;
    magic = m;
    skip = 0;
    status = 0;
  }
  void move() {
    if (upPressed) {
      posy -= speed;
    }
    if (downPressed) {
      posy += speed;
    }
    if (leftPressed) {
      posx -= speed;
    }
    if (rightPressed) {
      posx += speed;
    }
    herox = posx;
    heroy = posy;
  }
  void display() {
    translate(posx, posy, rad + 15 + skip);
    sphere(rad);
  }
  void jump() {
    if(status == 0) {
      fakespeed = speed + 10;
      skip += fakespeed;
      status = 1;
      return;
    }
    if((fakespeed > 0) && (status == 1)) {
      fakespeed -= 1;
      skip += fakespeed;
    }
    if((fakespeed <= 0) && (status == 1)) {
      status = 2;
      return;
    }
    if((status == 2) && (skip > 0)) {
      skip -= fakespeed;
      fakespeed += 1;
    }  
    if((skip <= 0) && (status == 2)) {
      status = 0;
      skip = 0;
      action = false;
      return;
    }
  }
}
float x = 0, y = 0, z = 0;
int gamemode = 0;
player ball = new player(10, width/2, height/2 + 80, 100, 100);
void setup() {
  //noSmooth();    //no anti aliasing
  //size(800, 600, P3D);
  smooth();
  fullScreen(P3D, SPAN);
  x = width/2;
  y = height/2;
  z = 0;
  cam = new PeasyCam(this, width/2, height/2 + 80, 0, 600);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
}

void draw() {
  background(0);
  if(gamemode == 0)
    drawlevelzero();
  if(gamemode == 1)
    drawlevelone();
  //sphereDetail(100, 0);
}

void drawlevelzero() {
  background(236, 240, 241);
  textAlign(CENTER);
  fill(52, 73, 94);
  textSize(70);
  text("Weird game", width/2, height/2);
  textSize(15); 
  text("Click to start", width/2, height-30);
}
void drawlevelone() {
  lights();
  pushMatrix();
  translate(width/2 , height/2 + 80);
  //x = mouseX*0.001;
  //y = mouseY*0.001;
  println(x); // good azimuth between 3 and 4 for both 
  println(y);
  rotateX(7.39);
  rotateY(0.00);
  if(movecam)
    camera(herox, heroy + 300, 190, herox, heroy, 0.0, 0.0, 1.0, 0.0);
  if(check)
      cam.lookAt(herox, heroy, 0, 0);
  box(450, 800, 30);
  ball.display();
  ball.move();
  if(action)
    ball.jump();
  popMatrix();
}
void mousePressed() {
  // if we are on the initial screen when clicked, start the game 
  if (gamemode == 0) { 
    gamemode = 1;
  }
  if (gamemode == 2) {
    gamemode = 0;
  }
}
void keyPressed(KeyEvent e) {
  if(key == 'c' || key == 'C') {
    if(check)
      check = false;
    else
      check = true;
  }
  if(key == 'w' || key == 'W')
    action = true;
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = true;
      movecam = true;
    }
    else if (keyCode == DOWN) {
      downPressed = true;
    }
    else if (keyCode == LEFT) {
      leftPressed = true;
    }
    else if (keyCode == RIGHT) {
      rightPressed = true;
    }
  }
}

void keyReleased(KeyEvent e) {
  if (key == CODED) {
    if (keyCode == UP) {
      upPressed = false;
    }
    else if (keyCode == DOWN) {
      downPressed = false;
    }
    else if (keyCode == LEFT) {
      leftPressed = false;
    }
    else if (keyCode == RIGHT) {
      rightPressed = false;
    }
  }
}

//void mouseDragged() {
//    x = mouseX*0.001 - 7.39; 
//    y = mouseY*0.001 - 0.0; 
//}

//void mouseReleased() {
//  x = 0;
//  y = 0;
//}