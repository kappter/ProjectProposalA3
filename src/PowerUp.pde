class PowerUp {
  int x, y, speed, diam, rand;
  //PImage powerUp;
  char type;

  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    speed = int(random(1, 9));
    diam = int(random(20, 60));
    rand = int(random(3));
    if(rand == 0) {
      type = 'h'; // increases health
    } else if(rand == 1) {
      type = 'l'; // increase laser count
     } else if(rand == 2) {
      type = 't'; // increase turret count
     }
    //powerUp = loadImage(""); // Consider power up types: health, ammo, turret count, 
  }

  void display() {
    //fill(#957D38);
    //rock.resize(diam,diam);
    //image(rock, x, y);
    if(type == 'h') {
      fill(0,255,0); // increases health
    } else if(type == 'l') {
      fill(255,0,0); // increase laser count
     } else if(type == 't') {
      fill(0,0,255); // increase turret count
     }
    ellipse(x, y, diam, diam);
    textAlign(CENTER, CENTER);
    textSize(8);
    fill(0);
    text(diam, x, y);
  }

  void move() {
    y+=speed;
  }

  boolean reachedBottom() {
    if (y>height+50) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Ship s) {
    float distance = dist(x,y,s.x,s.y);
    if(distance < 40) {
      return true;
    } else {
      return false;
    }
  }
}
