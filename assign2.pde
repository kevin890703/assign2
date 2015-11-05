int state = 1;
boolean startbgX, startbgY, endbgX, endbgY;
int bg1x, bg2x, treasureX, treasureY, fighterX, fighterY,
hp_,treasureXeat, treasureYeat, enemyX, enemyY;
final float hpx = 2.00;
PImage bg1, bg2, end1, end2, enemy, fighter, hp, start1, start2, treasure;
boolean upPressed, downPressed, leftPressed, rightPressed,
enemyXcrash, enemyYcrash = false;
void setup () {
  size(640, 480) ;
  // loadImage
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  treasure = loadImage("img/treasure.png");
  bg1x = 0;
  bg2x = -640;
  treasureX = floor(random(160,550));
  treasureY = floor(random(50,390));
  fighterX = 480;
  fighterY = floor(random(120,360));
  hp_ = 20;
}
void draw() {
  switch(state){
    case 1 :   // start
      boolean startbgX = false;
      boolean startbgY = false;
      if (mouseX>200 && mouseX<460){startbgX = true;}
      if (mouseY>375 && mouseY<420){startbgY = true;}
      if (startbgX == true && startbgY == true){
        image(start1,0,0);
        if (mousePressed){state = 2;}
      }else{image(start2,0,0);}
      break;
    case 2 :   //playing
      // bakground
      image(bg1,bg1x,0);
      image(bg2,bg2x,0);
      bg1x += 1;
      bg2x += 1;
      if (bg1x == 640){bg1x = -640;}
      if (bg2x == 640){bg2x = -640;}
      // hp
      fill(255,0,0);
      rect(48,44,hp_*hpx,22);
      image(hp,40,40);
      if (hp_ < 5){state = 3;}
      // treasure
      image(treasure,treasureX,treasureY);
      if (fighterX > (treasureX-50) && fighterX < (treasureX+40)){
        treasureXeat = 1;
      }else{treasureXeat = 0;}
      if (fighterY > (treasureY-50) && fighterY < (treasureY+40)){
        treasureYeat = 1;
      }else{treasureYeat = 0;}
      if (treasureXeat == 1 && treasureYeat == 1){
        treasureX = floor(random(160,550));
        treasureY = floor(random(50,390));
        if (hp_ <= 90){hp_ += 10;}
      }
      //fighter
      image(fighter,fighterX,fighterY);
      if (upPressed) {
        if (fighterY >= 10){fighterY -= 5;}
      }
      if (downPressed) {
        if (fighterY <= 419){fighterY += 5;}
      }
      if (leftPressed) {
        if (fighterX >= 10){fighterX -= 5;}
      }
      if (rightPressed) {
        if(fighterX <= 630){fighterX += 5;}
      }
      //enemy
      image (enemy,enemyX,enemyY);
      enemyX %= 650;
      if (enemyX > 635){enemyY = floor(random(30,450));}
      enemyX += 5;
      enemyY += 0.02*(fighterY-enemyY+25);
      if (enemyX-fighterX > -50 && enemyX-fighterX < 50 ){
        enemyXcrash = true;
      }else{enemyXcrash = false;}
      if (enemyY-fighterY > -50 && enemyY-fighterY < 50 ){
        enemyYcrash = true;
      }else{enemyYcrash = false;}
      if (enemyXcrash && enemyYcrash){
        enemyX = -10;
        hp_ -= 20;
        fighterX = 480;
        fighterY = floor(random(120,360));
      }
      break;
    case 3 : // end
      boolean endbgX = false;
      boolean endbgY = false;
      if (mouseX>200 && mouseX<440){endbgX = true;}
      if (mouseY>310 && mouseY<350){endbgY = true;}
      if (endbgX == true && endbgY == true){
        image(end1,0,0);
        if (mousePressed){
          state = 2;
          hp_ = 20;
          enemyX = 0;
        }
      }else{
        image(end2,0,0);
      }
      hp_ = 20;
      enemyX = 0;
  }
}
void keyPressed(){
  if (key == CODED) { 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
void keyReleased(){
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
