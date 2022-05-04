class Laser {
  int x, y, w, h, speed;

  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    w = 3;
    h = 8;
    speed = 8;
  }

  void display() {
    rectMode(CENTER);
    fill(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }

  void move() {
    y-=speed;
  }

  boolean reachedTop() {
    if (y<0-50) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Rock r) {
    float distance = dist(x,y,r.x,r.y);
    if(distance < 10) {
      return true;
    } else {
      return false;
    }
  }
}
