class Rock {
  int x, y, speed, diam, rand, health;
  PImage rock;

  Rock(int x, int y) {
    this.x = x;
    this.y = y;
    
    speed = int(random(1, 9));
    diam = int(random(20, 60));
    health = diam;
    rand = int(random(3));
    rock = loadImage("Rock.png");
  }

  void display() {
    fill(#957D38);
    rock.resize(diam,diam);
    image(rock, x, y);
    //ellipse(x, y, diam, diam);
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
