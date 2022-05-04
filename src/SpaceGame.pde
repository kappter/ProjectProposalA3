Ship s1;
import processing.sound.*;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowerUp> powerUps = new ArrayList<PowerUp>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Star> stars = new ArrayList<Star>();
Timer rockTimer, puTimer;
int score, level, rockTime;
boolean play;
SoundFile laser;
PImage gameOver, startscreen;

void setup() {
  size(1000, 1000);
  s1 = new Ship();
  score = 0;
  level = 1;
  rockTime = 1000;
  rockTimer = new Timer(rockTime);
  rockTimer.start();
  puTimer = new Timer(5000);
  puTimer.start();
  laser = new SoundFile(this, "laser.wav");
  play = false;
  //gameOver = loadImage("");
}

void draw() {
  background(0);
  noCursor();

  // Determine if the user is in gameplay
  if (!play) {
    startScreen();
  } else {
    
    // control for levels
    if(frameCount % 1000 ==10) {
      level++;
    }

    stars.add(new Star());
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }
    // Adding PowerUps on a timer
    if (puTimer.isFinished()) {
      powerUps.add(new PowerUp(int(random(width)), -100));
      puTimer.start();
    }

    // Display power up and detect ship collision
    for (int i = 0; i < powerUps.size(); i++) {
      PowerUp pu = powerUps.get(i);
      pu.display();
      pu.move();
      if (pu.reachedBottom()) {
        powerUps.remove(pu);
      }
      if (pu.intersect(s1)) {
        // find out what type of PU
        if (pu.type == 'h') {
          s1.health+=100;
          powerUps.remove(pu);
        } else if (pu.type == 'l') {
          s1.laserCount+=100;
          powerUps.remove(pu);
        } else if (pu.type == 't') {
          s1.turret++;
          powerUps.remove(pu);
        }
      }
    }

    // Adding rocks on a timer
    if (rockTimer.isFinished()) {
      rocks.add(new Rock(int(random(width)), -100));
      rockTimer.start();
    }

    // Display laser and detect rock collision
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j < rocks.size(); j++) {
        Rock rock = rocks.get(j);
        if (laser.intersect(rock)) {
          score = score + rock.diam;
          lasers.remove(laser);
          rock.health = rock.health - 50;
          if (rock.health < 10) {
            rocks.remove(rock);
          }
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
    }

    // Display rock and detect ship collision
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();
      if (rock.reachedBottom()) {
        rocks.remove(rock);
      }
      if (rock.intersect(s1)) {
        rocks.remove(rock);
        score+=rock.diam;
        s1.health-=rock.diam;
      }
    }
    infoPanel();

    s1.display(mouseX, mouseY);
    // Determine if Gameover sequence is to be run
    if (s1.health <1) {
      gameOver();
      noLoop();
    }
  }
}

void infoPanel() {
  fill(127, 127);
  rectMode(CORNER);
  rect(0, 0, width, 40);
  fill(255, 200);
  textSize(18);
  textAlign(CENTER);
  text("Score:" + score + " Level:" + level + " Health:" + s1.health + " Ammo:" + s1.laserCount, width/2, 30);
}

void startScreen() {
  background(0); // or load image
  textAlign(CENTER);
  fill(255);
  textSize(46);
  text("Welcome to SpaceGame!", width/2, height/2);
  text("by Mr Kapptie | 2021", width/2, height/2+30);
  text("click anywhere to begin...", width/2, height/2+60);
  if (mousePressed) {
    play = true;
  }
}

void gameOver() {
  background(0); // or load image
  textAlign(CENTER);
  fill(255);
  textSize(46);
  text("Game Over!", width/2, height/2);
  text("Final Score:" + score, width/2, height/2+30);
  text("Level Achieved:" + level, width/2, height/2+60);
}

void ticker() {
}

void mousePressed() {
  if (s1.fire()) {
    if (s1.turret == 1) {
      lasers.add(new Laser(s1.x, s1.y));
      laser.play();
    } else if (s1.turret == 2) {
      lasers.add(new Laser(s1.x-10, s1.y));
      lasers.add(new Laser(s1.x+10, s1.y));
      laser.play();
    } else if (s1.turret == 3) {
      lasers.add(new Laser(s1.x, s1.y));
      lasers.add(new Laser(s1.x-10, s1.y));
      lasers.add(new Laser(s1.x+10, s1.y));
      laser.play();
    }
  }
  s1.laserCount--;
}

void keyPressed() {
  if (s1.fire()) {
    if (keyPressed) {
      if (key == ' ') {
        lasers.add(new Laser(s1.x, s1.y));
        laser.play();
      }
    }
  }
  s1.laserCount--;
}
