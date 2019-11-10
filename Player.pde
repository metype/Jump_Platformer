class Player {
  float x, y, xvel, yvel, wallJumpTimer=0, gravity=0.2, fall=0;
  boolean isUp, isDown, isLeft, isRight;
  PApplet main;
  Player(PApplet main) {
    this.x=0;
    this.y=0;
    this.main=main;
  }

  private void physics() {
    if (level.scrollable) {
      this.x=width/2;
      this.y=height/2;
      ;
    }
    this.wallJumpTimer--;
    if (isRight) {
      this.xvel+=2;
    }
    if (isLeft) {
      this.xvel-=2;
    }
    if (touchingColour(this.x, this.y, color(0))) {
      this.y-=5;
    }
    this.xvel=constrain(this.xvel, -4, 4);
    this.y-=3;
    this.x+=this.xvel;
    if (touchingColour(this.x, this.y, color(0))) {
      this.y-=6;
      if (touchingColour(this.x, this.y, color(0))) {
        this.y+=6;
        if (level.scrollable) {
          level.scrollX+=xvel/((1920/width)*1);
        }
        this.x-=xvel/((1920/width)*1);
        if (this.xvel<0) {
          //this.x+=5;
        }
        if (this.isUp&&this.wallJumpTimer<0) {
          this.fall=0;
          this.xvel*=-2;
          this.yvel+=13;
          this.x+=xvel/((1920/width)*1);
          this.wallJumpTimer=20;
        }
      }
    }
    this.y+=3;
    this.xvel*=0.85;
    this.fall+=gravity/((1920/width)*1);
    this.y+=this.fall;
    if (touchingColour(this.x, this.y, color(0))) {
      this.y-=this.fall;
      this.fall=0;
      if (this.isUp&&this.wallJumpTimer<0) {
        this.yvel+=22;
        this.wallJumpTimer=20;
      } else {
        this.yvel=0;
      }
    }
    this.yvel*=0.9;
    this.y-=this.yvel/((1920/width)*1);
    //level.set(this.x, this.y-(level.tileSize), 15);
    //println(level.get(this.x, this.y-(level.tileSize)).type);
    // level.set(this.x+30, this.y-(15), 11);
    if (level.cells!=null) {
      try {
        level.cells[(int)((this.x-width/4)/level.tileSize)] [(int)(this.y-(height/8)/level.tileSize)].type=4;
      }
      catch(Exception e) {
      }
    }
    if (touchingColour(this.x, this.y, color(0))) {
      if (level.get(this.x+32, this.y-(15)).type==16) {
        for (int x=0; x<level.cells.length; x++) {
          for (int y=0; y<level.cells[x].length; y++) {
            if (level.cells[x][y].type==16) {
              level.cells[x][y].type=11;
            }
            if (level.cells[x][y].type==13) {
              level.cells[x][y].type=12;
            }
            if (level.cells[x][y].type==15) {
              level.cells[x][y].type=14;
            }
          }
        }
      } else if (level.get(this.x+32, this.y-(15)).type==11) {
        for (int x=0; x<level.cells.length; x++) {
          for (int y=0; y<level.cells[x].length; y++) {
            if (level.cells[x][y].type==11) {
              level.cells[x][y].type=16;
            }

            if (level.cells[x][y].type==12) {
              level.cells[x][y].type=13;
            }
            if (level.cells[x][y].type==14) {
              level.cells[x][y].type=15;
            }
          }
        }
      }
      if (level.scrollable) {
        level.scrollY+=this.yvel/((1920/width)*1);
      }
      this.y+=this.yvel/((1920/width)*1);
      this.yvel=0;
    }
    if (touchingColour(this.x, this.y, color(200, 0, 0))) {
      this.yvel=0;
      this.xvel=0;
      this.fall=0;
      level.createLevel((loadLevel)?customLevelCode:defaultLevels[lvl]);
    }
    if (key=='r'||key=='R') {
      this.yvel=0;
      this.xvel=0;
      this.fall=0;
      level.createLevel((loadLevel)?customLevelCode:defaultLevels[lvl]);
      key=' ';
    }
    if (touchingColour(this.x, this.y, color(200, 200, 0))) {
      this.yvel=0;
      this.xvel=0;
      this.fall=0;
      if (mode==0) {
        animationTimers.add(new AnimationTimer(this.main, "Level Win", 0, 50, new AnimationType("TXT", "Level Completed")));
      }
      if (!loadLevel) {
        lvl++;
      } else {
        pause(true);
      }
      level.createLevel((loadLevel)?customLevelCode:defaultLevels[lvl]);
    }
  }

  void render() {
    this.physics();
    rectMode(CENTER);
    stroke(75);
    fill(150);
    rect((level.scrollable)?width/2:this.x, (level.scrollable)?height/2:this.y-3, level.tileSize*.66, level.tileSize*.66);
  }

  boolean setMove(final int k, final boolean b) {
    switch (k) {
    case +'W':
    case UP:
      return isUp = b;

    case +'S':
    case DOWN:
      return isDown = b;

    case +'A':
    case LEFT:
      return isLeft = b;

    case +'D':
    case RIGHT:
      return isRight = b;

    default:
      return b;
    }
  }

  void go(float x, float y) {
    this.x=x;
    this.y=y;
  }

  boolean touchingColour(float x, float y, color clr) {
    boolean touching=false;
    noFill();

    //rectMode(CORNER);
    //rect(int(x-((level.tileSize/2)-2)), int(y-((level.tileSize/2)-2)), int(level.tileSize), int(level.tileSize));

    try {//rectMode(CENTER);//quad(int(x-((level.tileSize/2)-2)), int(y-((level.tileSize/2)-2)), int(x+((level.tileSize/2)-2)), int(y-((level.tileSize/2)-2)), int(x+((level.tileSize/2)-2)), int(y+((level.tileSize/2)-2)), int(x-((level.tileSize/2)-2)), int(y+((level.tileSize/2)-2)));
      PImage tst = get(int(x-((level.tileSize*(.66/2)))), int(y-((level.tileSize*(.66/2)))), int(level.tileSize*.66), int(level.tileSize*.66));
      tst.loadPixels();
      for (int i=0; i<tst.pixels.length; i++) {
        if (tst.pixels[i]==clr) {
          touching=true;
        }
      }
      if (debug) {
        noFill();
        rectMode(CENTER);
        stroke(255);
        rect (int(x-((level.tileSize*(.66/2)))), int(y-((level.tileSize*(.66/2)))), int(level.tileSize*.66), int(level.tileSize*.66));
      }
      return touching;
    }
    catch(Exception e) {
      return false;
    }
  }

  void resetVelocity() {
    this.xvel=0;
    this.yvel=0;
  }

  void setVelocity(PVector vel) {
    this.xvel=vel.x;
    this.yvel=vel.y;
  }
}
