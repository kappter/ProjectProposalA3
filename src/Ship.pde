class Ship{
  // Member Variables
  int x,y,w,health,laserCount,turret;
  boolean alive;
  PImage ship;
  
  // Constructor
  Ship() {
    x = 0;
    y = 0;
    w = 80; 
    health = 100;
    laserCount = 500;
    turret = 1;
    alive = true;
    ship = loadImage("Ship.png");
  }
  
  // Member Methods
  void display(int x, int y) {
    this.x = x;
    this.y = y;
    imageMode(CENTER);
    ship.resize(80,80);
    image(ship,x,y);
  }
  
  void move() {} // is designed for keyboard movement
  
  boolean fire() {
    if(laserCount > 0) {
      return true;
    } else {
      return false;
    }
  }
  
  boolean intersect(Rock r) {
    return true;
  }
}
