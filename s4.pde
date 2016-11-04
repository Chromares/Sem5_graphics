import peasy.*;

PeasyCam cam;



float speed = 5, fakespeed;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
boolean movecam = false, check = false, action = false;
int herox  = width/2, heroy = height/2 + 80, herorad, heroskip;
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
    herorad = radius;
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
    heroskip = skip;
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
      heroskip = 0;
      action = false;
      return;
    }
  }
}

class enemy_ball {
  int rad;
  int posx;
  int posy;
  int hp;
  boolean movement;
  int delx;
  int dely;
  enemy_ball(int radius, int xpos, int ypos) {
    rad = radius;
    posx = xpos;
    posy = ypos;
    hp = 100;
    movement = false;
  }
  void move() {        //this is weird
    if(action || movement)
      return;
    if(posx < herox)
        posx += 3;
    if(posx > herox);
        posx -= 3;
    if(posy > heroy)
      posy -= 3;
    if(posy < heroy)
      posy += 3;
    if(posx < herox)
        posx += 3;
  }
  void display() {
    translate(posx, posy, rad + 15);
    sphere(rad);
  }
  void collision(player ball) {
    int xgap, ygap;
    if(movement) {
      push();
      return;
    }
    else {
      delx = 0;
      dely = 0;
    }
    xgap = 0 > (herox - posx) ? (posx - herox) : (herox - posx);
    ygap = 0 > (heroy - posy) ? (posy - heroy) : (heroy - posy);
    if((xgap <= (herorad + rad)) && (ygap <= (herorad + rad))) {  //maybe collision
      if(action && (herorad + heroskip > 2*rad)) {
        //no collision
        return;
      }
      else if(action && (herorad + heroskip > rad)) {  //pakka collision and hit
       //write this later
        return;
      }
      else {
        delx = herox - posx;    //e = 1?
        dely = heroy - posy;    //del is important for direction
        if(xgap <= (herorad + rad)) {
          if(delx < 0)
            delx = -60;
          else if(delx > 0)
            delx = 60;
          if(delx == 0)
            delx = 0;
        }
        else
          delx = 0;
        if(ygap <= (herorad + rad)) {
          if(dely < 0)
            dely = -60;
          else if(dely > 0)
            dely = 60;
          else
            dely = 0;
        }
        else
          dely = 0;
        movement = true;
        //ball.posx += delx;
        //ball.posy += dely;
        //if(delx != 0 && dely != 0) {
        //  if(xgap > ygap)
        //    delx *= -1;
        //  else if(xgap < ygap)
        //    dely *= -1;
        //}
        println(posx, herox, delx, posy ,heroy, dely);
        return;
      }
    }
  }
  void push() {
    int xgap = 0 > (herox - posx) ? (posx - herox) : (herox - posx);
    int ygap = 0 > (heroy - posy) ? (posy - heroy) : (heroy - posy);
    println("pushing");
    if(delx != 0) {
      if(delx < 0) {
        if((xgap < ygap) && (herox < posx))
          posx -= 3;
        if((xgap > ygap) && (herox < posx))
          posx += 3;
        delx += 3;
      }
      else {
        if((xgap < ygap) && (herox > posx))
          posx += 3;
        if((xgap > ygap) && (herox > posx))
          posx -= 3;
        delx -= 3;
      }
    }
    if(dely != 0) {
      if(dely > 0) {
        if((xgap < ygap) && (heroy > posy))
          posy -= 3;
        if((xgap > ygap) && (heroy > posy))
          posy += 3;
        dely -= 3;
      }
      else {
        if((xgap < ygap) && (heroy < posy))
          posy += 3;
        if((xgap > ygap) && (heroy < posy))
          posy -= 3;
        dely += 3;
      }
    }
    if((delx == 0) && (dely == 0)) {
      movement = false;
      println("pushed");
    }  
    return;
  }
}

float x = 0, y = 0, z = 0;
int gamemode = 0;

player ball = new player(10, width/2, height/2 + 80, 100, 100);
enemy_ball balle = new enemy_ball(10, width/2, height/2 + 160);

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
  //println(x); // good azimuth between 3 and 4 for both 
  //println(y);
  rotateX(7.39);
  rotateY(0.00);
  if(movecam)
    camera(herox, heroy + 300, 190, herox, heroy, 0.0, 0.0, 1.0, 0.0);
  if(check)
      cam.lookAt(herox, heroy, 0, 0);
  box(450, 800, 30);
  pushMatrix();
  ball.display();
  ball.move();
  popMatrix();
  balle.display();
  balle.move();
  balle.collision(ball);
  //translate(50, 50, 30);    //translations stack, previous translation in display() took us to z = 15 + rad or 25. We have to adjust accordingly;
  //sphere(40);               //why those this ball move as well? because we translated to a postion herox, heroy and then we do 50, 50 relative to it. thats why
                              //how do we fix this? well, we need to somehow translate fresh. This initally worked because we did clear everything in draw before coming here
                              //pushmatrix and pop matrix, to the rescue
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