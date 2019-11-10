class Keys {
  boolean isUp, isDown, isLeft, isRight;
  int startScreen=0;
  Keys(boolean up, boolean down, boolean left, boolean right) {
    this.isUp=up;
    this.isDown=down;
    this.isLeft=left;
    this.isRight=right;
  }

Keys(boolean up, boolean down, boolean left, boolean right,int screen) {
    this.isUp=up;
    this.isDown=down;
    this.isLeft=left;
    this.isRight=right;
    this.startScreen=screen;
  }
  
  boolean[] getKeys() {
    boolean[] thi = {this.isUp, this.isDown, this.isLeft, this.isRight}; 
    return thi;
  }
}
