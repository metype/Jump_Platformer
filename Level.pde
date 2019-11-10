class Level {
  Cell[][] cells; 
  Jump_Platformer main=new Jump_Platformer();
  int loadedFrame;
  int tileSize;
  int width, height, with, hite;
  float scrollX, scrollY;
  boolean scrollable=false;
  boolean isUp, isDown, isLeft, isRight;

  Level(int width, int height, int w, int h) {
    this.width=width;
    this.height=height;
    this.with=w;
    this.hite=h;
    tileSize=(int)map(w, 1366, 1920, 48, 64);
  }

  Level(int width, int height, boolean canScroll) {
    this.width=width;
    this.height=height;
    this.scrollable=canScroll;
    tileSize=(int)map(main.width, 1366, 1920, 48, 64);
  }

  boolean getScrollable() {
    return this.scrollable;
  }

  void setScrollable(boolean eh) {
    this.scrollable=eh;
  }

  void render(boolean near) {
    if (cells!=null) {
      if (near) {
        imageMode(CENTER);
        image(gfx[get(float(width/2), float(height/2)).type], width/2, height/2); 
        image(gfx[get(float(width/2)-tileSize, float(height/2)).type], width/2, height/2); 
        image(gfx[get(float(width/2)+tileSize, float(height/2)).type], width/2, height/2); 
        image(gfx[get(float(width/2)-tileSize, float(height/2)-tileSize).type], width/2, height/2); 
        image(gfx[get(float(width/2)+tileSize, float(height/2)-tileSize).type], width/2, height/2); 
        image(gfx[get(float(width/2), float(height/2)-tileSize).type], width/2, height/2); 
        image(gfx[get(float(width/2)-tileSize, float(height/2)+tileSize).type], width/2, height/2); 
        image(gfx[get(float(width/2)+tileSize, float(height/2)+tileSize).type], width/2, height/2); 
        image(gfx[get(float(width/2), float(height/2)+tileSize).type], width/2, height/2);
      } else {
        for (int x=0; x<cells.length; x++) {
          for (int y=0; y<cells[x].length; y++) {
            try {
              if (mode==1) {
                if (this.isUp) {
                  this.scrollY+=0.01;
                }
                if (this.isDown) {
                  this.scrollY-=0.01;
                }
                if (this.isLeft) {
                  this.scrollX+=0.01;
                }
                if (this.isRight) {
                  this.scrollX-=0.01;
                }
              }
              boolean show=true;
              if (mode!=1&&mode!=7) {
                if (cells[x][y].type==4) {
                  show=false;
                  // println(this.loadedFrame-frameCount);
                  if (this.loadedFrame-frameCount>-2) {
                    if (this.scrollable) {
                      this.scrollX=(x*tileSize)+550;
                      this.scrollY=(y*-tileSize)+355;
                    } else {
                      player.go((x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)-15), (y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize)));
                    }
                  }
                } else {
                  show=true;
                }
              }
              if (show) {
                //println(((x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)+15))+" is greater than "+this.with + "  " +((x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)+15)>this.with));//(x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)+15)<0||(y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))>height||(y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))<0));
                if ((x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)-15)>this.with||(x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)-15)<0||(y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))>this.hite||(y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))<0) {
                  // break;
                } else {
                  imageMode(CENTER);
                  image(gfx[cells[x][y].type], (x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)-15), (y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize)));
                }
              }
            }
            catch(Exception e) {
              console.println(e);
            }
          }
        }
      }
    }
  }


  void renderOffset(int yoff) {
    if (cells!=null) {
      for (int x=0; x<cells.length; x++) {
        for (int y=0; y<cells[x].length; y++) {
          try {
            boolean show=true;
            if (mode!=1&&mode!=7) {
              if (cells[x][y].type==4) {
                show=false;
                // println(this.loadedFrame-frameCount);
                if (this.loadedFrame-frameCount>-2) {
                  player.go((x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)+15), (y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))+yoff);
                }
              } else {
                show=true;
              }
            }
            if (show) {
              imageMode(CENTER);
              image(gfx[cells[x][y].type], (x*this.tileSize)+((scrollable)?(this.scrollX):((width/2)*this.tileSize)+15), (y*this.tileSize)+((scrollable)?(this.scrollY):((height/4)*this.tileSize))+yoff);
            }
          }
          catch(Exception e) {
            console.println(e);
          }
        }
      }
    }
  }

  void createBlankLevel(int screenWidth, int screenHeight) {
    cells=new Cell[15*screenWidth][11*screenHeight];
    for (int x=0; x<cells.length; x++) {
      for (int y=0; y<cells[x].length; y++) {
        cells[x][y]=new Cell(1);
      }
    }
    this.loadedFrame=frameCount;
  }

  void set(float x, float y, int tileType) {
    try {
      if (!scrollable) {
        cells[int(x/this.tileSize)-((width/2))] [int(y/this.tileSize)-((height/4))]=new Cell(tileType);
      } else {
        cells[int((x/this.tileSize)-((this.scrollX/tileSize)))] [int((y/this.tileSize)-((this.scrollY/tileSize)))]=new Cell(tileType);
      }
    }
    catch(Exception e) {
      //meh idc;
    }
  }

  void set(int x, int y, int tileType) {
    try {
      cells[x][y]=new Cell(tileType);
    }
    catch(Exception e) {
      //meh idc;
    }
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

  Cell get(float x, float y) {
    if (!scrollable) {
      try {
        return cells[(int)((x/this.tileSize)-(width/2))] [(int)(y/this.tileSize)-((height/4))];
      }
      catch(Exception e) {
        return new Cell(0);
      }
    } else {
      return new Cell(0);
    }
  }

  Cell get(int x, int y) {
    return cells[x][y];
  }

  void createLevel(String lvlCode) {
    if (lvlCode.startsWith("?")) {
      this.scrollable=true;
      this.cells=new Cell[15*fromBase64(lvlCode.substring(1, 2))][11*fromBase64(lvlCode.substring(2, 3))];
      lvlCode=lvlCode.substring(3, lvlCode.length()-1);
    } else {
      this.scrollable=false;
      this.cells=new Cell[this.width][this.height];
    }
    int i=0;
    for (int x=0; x<cells.length; x++) {
      for (int y=0; y<cells[x].length; y++) {
        try {
          i++;
          String cur =  lvlCode.substring(i, i+1);
          cells[x][(y+1>=cells[x].length)?0:y+1]=new Cell(fromBase64(cur));
        }
        catch(Exception e) {
          cells[x][(y+1>=cells[x].length)?0:y+1]=new Cell(1);
        }
      }
    }
    this.loadedFrame=frameCount;
    // shiftRight(cells[0]);
    for (int x=0; x<cells.length; x++) {
      for (int y=0; y<cells[x].length; y++) {
        if (cells[x][y].type==16) {
          cells[x][y].type=11;
        }
        if (cells[x][y].type==13) {
          cells[x][y].type=12;
        }
        if (cells[x][y].type==15) {
          cells[x][y].type=14;
        }
      }
    }
  }

  String saveLevel() {
    String lvlCode="";
    if (scrollable) {
      lvlCode+="?"+toBase64(cells.length/15)+toBase64(cells[0].length/11);
    }
    for (int x=0; x<cells.length; x++) {
      for (int y=0; y<cells[x].length; y++) {
        lvlCode+=toBase64(cells[x][y].type);
      }
    }
    return lvlCode;
  }

  String toBase64(int num) {
    String[] codes = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};
    if (num<10) {
      return ""+num;
    } else {
      return codes[num-10];
    }
  }

  int fromBase64(String chr) {
    try {
      return Integer.parseInt(chr);
    }
    catch(Exception e) {
      String[] codes = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};
      return Index.findIndex(codes, chr)+10;
    }
  }
}
