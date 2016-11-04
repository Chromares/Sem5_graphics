import peasy.*;

PeasyCam cam;

int r = 1;


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
int gamemode = 1;
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
 // println(x); // good azimuth between 3 and 4 for both 
 // println(y);
  rotateX(7.39);
  rotateY(0.00);
  if(movecam)
    camera(herox, heroy + 300, 190, herox, heroy, 0.0, 0.0, 1.0, 0.0);
  if(check)
      cam.lookAt(herox, heroy, 0, 0);
  box(450, 20000, 30);
  
 /* if(ball.posy % 900 == 0) {
   // r = int(random(6));
   r++;
   if(r == 7){
     r = 1;
   }
  }
  println(r);
    switch(r){
      case 1 : obstacle1(ball.posy);  break;
      case 2 : obstacle2(ball.posy);  break;
      case 3 : obstacle3(ball.posy);  break;
      case 4 : obstacle4(ball.posy);  break;
      case 5 : obstacle5(ball.posy);  break;
      case 6 : obstacle6(ball.posy);  break;
      default : break;
    }*/
    obstacle1(0, ball.skip, ball.rad);
    obstacle2(900-300, ball.skip, ball.rad);
    obstacle3(1800-300, ball.skip, ball.rad);
    obstacle4(3000-300, ball.skip, ball.rad);    
    obstacle5(5000-300, ball.skip, ball.rad);
    obstacle6(6000-300, ball.skip, ball.rad);      //6000-300
    
   println(herox + " " + heroy);
  
  ball.display();
  ball.move();
  if(action)
    ball.jump();
  popMatrix();
}
void obstacle1(int y, int s, int r){
  pushMatrix();
  translate(0, -100-y);
  box(450, 50, 80);  
  popMatrix();
  if(heroy <= -65 && heroy >= -65-50 && s < r + 40){
    gamemode = 0;
  }
}
void obstacle2(int y, int s, int r){
  pushMatrix();
  translate(0, -100-y);
  
  pushMatrix();
  translate(-100, 0);
  box(150, 50, 80);
  popMatrix();
  
  pushMatrix();
  translate(100, 0);
  box(150, 50, 80);
  popMatrix();
  
  popMatrix();
  if((herox >= -185 && herox <= -15) || (herox >= 15 && herox <= 185)){
    if(heroy <= -665 && heroy >= -665-50 && s < r + 40){
      gamemode = 0;
    }
  }
}
void obstacle3(int y, int s, int r){
  pushMatrix();
  translate(0, -100-y);
  
  pushMatrix();
  translate(-100, 0, 80 + 15);
  sphere(80);
  popMatrix();
  
  pushMatrix();
  translate(100, 0, 80 + 15);
  sphere(80);
  popMatrix();
  
  popMatrix();
  if((herox >= -155 && herox <= -50) || (herox >= 50 && herox <= 155)){
    if(heroy <= -1545 && heroy >= -1545-80){
      gamemode = 0;
    }
  }
}
void obstacle4(int y, int s, int r){
  pushMatrix();
  translate(0, -100-y);
  
  pushMatrix();
  translate(-100, 0);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(100, -250);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(-100, -500);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(100, -750);
  sphere(100);
  popMatrix();
  
   pushMatrix();
  translate(-100, -1000);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(100, -1250);
  sphere(100);
  popMatrix();
  
   pushMatrix();
  translate(-100, -1500);
  sphere(100);
  popMatrix();
  
  pushMatrix();
  translate(100, -1750);
  sphere(100);
  popMatrix();
  
  popMatrix();
  if(herox >= -205 && herox <= 5){
    if((heroy <= -2695 && heroy >= -2905)){
      gamemode = 0;
      if((herox >= -60 && heroy >= -2705) || (herox >= -30 && heroy >= -2725) || (herox >= -10 && heroy >= -2750)){
        gamemode = 1;
      }
      else if((herox >= -60 && heroy <= -2895) || (herox >= -30 && heroy <= -2875) || (herox >= -10 && heroy <= -2850)){
        gamemode = 1;
      }
    }
     else if((heroy <= -2695-500 && heroy >= -2905-500)){
      gamemode = 0;
      if((herox >= -60 && heroy >= -2705-500) || (herox >= -30 && heroy >= -2725-500) || (herox >= -10 && heroy >= -2750-500)){
        gamemode = 1;
      }
      else if((herox >= -60 && heroy <= -2895-500) || (herox >= -30 && heroy <= -2875-500) || (herox >= -10 && heroy <= -2850-500)){
        gamemode = 1;
      }
    }
     else if((heroy <= -2695-1000 && heroy >= -2905-1000)){
      gamemode = 0;
      if((herox >= -60 && heroy >= -2705-1000) || (herox >= -30 && heroy >= -2725-1000) || (herox >= -10 && heroy >= -2750-1000)){
        gamemode = 1;
      }
      else if((herox >= -60 && heroy <= -2895-1000) || (herox >= -30 && heroy <= -2875-1000) || (herox >= -10 && heroy <= -2850-1000)){
        gamemode = 1;
      }
    }
    else if((heroy <= -2695-1500 && heroy >= -2905-1500)){
      gamemode = 0;
      if((herox >= -60 && heroy >= -2705-1500) || (herox >= -30 && heroy >= -2725-1500) || (herox >= -10 && heroy >= -2750-1500)){
        gamemode = 1;
      }
      else if((herox >= -60 && heroy <= -2895-1500) || (herox >= -30 && heroy <= -2875-1500) || (herox >= -10 && heroy <= -2850-1500)){
        gamemode = 1;
      }
    }
  }
  else if((herox >= -5 && herox <= 205)){
    if((heroy <= -2695-250 && heroy >= -2905-250)){
      gamemode = 0;
      if((herox <= 60 && heroy >= -2705-250) || (herox <= 30 && heroy >= -2725-250) || (herox <= 10 && heroy >= -2750-250)){
        gamemode = 1;
      }
      else if((herox <= 60 && heroy <= -2895-250) || (herox <= 30 && heroy <= -2875-250) || (herox <= 10 && heroy <= -2850-250)){
        gamemode = 1;
      }
    }
   
    else if((heroy <= -2695-750 && heroy >= -2905-750)){
      gamemode = 0;
      if((herox <= 60 && heroy >= -2705-750) || (herox <= 30 && heroy >= -2725-750) || (herox <= 10 && heroy >= -2750-750)){
        gamemode = 1;
      }
      else if((herox <= 60 && heroy <= -2895-750) || (herox <= 30 && heroy <= -2875-750) || (herox <= 10 && heroy <= -2850-750)){
        gamemode = 1;
      }
    }
   
    else if((heroy <= -2695-1250 && heroy >= -2905-1250)){
      gamemode = 0;
      if((herox <= 60 && heroy >= -2705-1250) || (herox <= 30 && heroy >= -2725-1250) || (herox <= 10 && heroy >= -2750-1250)){
        gamemode = 1;
      }
      else if((herox <= 60 && heroy <= -2895-1250) || (herox <= 30 && heroy <= -2875-1250) || (herox <= 10 && heroy <= -2850-1250)){
        gamemode = 1;
      }
    }
    
    else if((heroy <= -2695-1750 && heroy >= -2905-1750)){
      gamemode = 0;
      if((herox <= 60 && heroy >= -2705-1750) || (herox <= 30 && heroy >= -2725-1750) || (herox <= 10 && heroy >= -2750-1750)){
        gamemode = 1;
      }
      else if((herox <= 60 && heroy <= -2895-1750) || (herox <= 30 && heroy <= -2875-1750) || (herox <= 10 && heroy <= -2850-1750)){
        gamemode = 1;
      }
    }
  }
}
void obstacle5(int y, int s, int r){
  pushMatrix();
  translate(0, -500-y);
  
  translate(-200, 0);
  box(50, 500, 80);
  translate(200, 0);
  
  translate(-100, 0);
  box(50, 500, 80);
  translate(100, 0);
  
 // translate(-200, 0);
  box(50, 500, 80);
 // translate(200, 0);
  
  translate(100, 0);
  box(50, 500, 80);
  translate(-100, 0);
  
  translate(200, 0);
  box(50, 500, 80);
  translate(-200, 0);
  
  popMatrix();
  if(heroy <= -4940 && heroy >= -4940-500 && s < r + 40){
    if(herox < -165 || (herox > -135 && herox < -65) || (herox > -135+100 && herox < -65+100) || (herox > -135+200 && herox < -65+200) || herox > -135+300){
      gamemode = 0;
    }
  }
}
void obstacle6(int y, int s, int r){
  pushMatrix();
  translate(0, -400-y);
  
  translate(-140, 0);
  box(70, 400, 80);
  translate(140, 0);
  
  translate(140, 0);
  box(70, 400, 80);
  translate(-140, 0);
  
  translate(0, -150);
  box(70, 400, 80);
  translate(0, 150);
  
  translate(0, -550);
  box(300, 50, 80);
  translate(0, 500);
  
  translate(0, -800);
    translate(150, 0);
    box(150, 150, 80);
    translate(-150, 0);
    
    translate(-150, 0);
    box(150, 150, 80);
    translate(150, 0);
  translate(0, 800);
  
  popMatrix();
  if(heroy < -190-5700 && heroy > -340-5700){
    if((herox < -95 && herox > -95-70) || (herox > 95 && herox < 95+70) && s < r + 40){
      gamemode = 0;
    }
  }
  else if(heroy < -340-5700 && heroy > -340-400-5700 && herox > -45 && herox < -45+70 && s < r + 40){
    gamemode = 0;
  }
  else if(heroy < -915-5700 && heroy > -915-50-5700 && herox > -160 && herox < -160+300 && s < r + 40){
    gamemode = 0;
  }
  else if(heroy < -1165-5700 && heroy > -1165-150-5700 && (herox < -65 || herox > 65) && s < r + 40){
    gamemode = 0;
  }
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