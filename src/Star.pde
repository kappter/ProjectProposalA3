class Star{
  // Member variables
  int x,y,diam,speed;
  
  // Constructor
  Star() {
    x = int(random(width));
    y = int(random(height));
    diam = int(random(1,5));
    speed = int(random(1,10));
  }
  
  // Member methods
  void display() {
    fill(255);
    ellipse(x,y,diam,diam);
  }
  
  void move() {
    y+=speed;
  }
  
  boolean reachedBottom() {
    if (y>height+10) {
      return true;
    } else {
      return false;
    }
  }
}
