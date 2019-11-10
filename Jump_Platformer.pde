import g4p_controls.*;
import java.awt.Font;
import java.awt.GraphicsEnvironment;
import java.awt.GraphicsDevice;
import java.awt.HeadlessException;
import java.awt.event.KeyEvent;
import java.lang.reflect.Field;
import gifAnimation.*;

ArrayList<AnimationTimer> animationTimers=new ArrayList();
public Console console;
GCustomSlider sdr5;
GCustomSlider sdr6;
PGraphics game;
Boolean pause;
String customLevelCode="";
GraphicsEnvironment env = GraphicsEnvironment.getLocalGraphicsEnvironment();
GraphicsDevice[] devices = env.getScreenDevices();
public int numberofScreens = devices.length;
ArrayList<Keys> keys = new ArrayList();
public int consoleTextSize=15;
public int Coffy=0;
public boolean consoleShown=false, debug=false, noclip=false, playMode=false, recordMode=false;
public int consoleScrollSpeed=15;
ArrayList<String> commandslist=new ArrayList();
int commandsIndex=0;
String command="";
PImage[] gfx;
String lvlCodeInv="";
Level level, inv;
Player player = new Player(this);
String[] settings;
String version;
public int mode=2, lvl=0;
int tileType;
color[] cellCodes;
boolean loadLevel=false;
String recordName="recording";
String[] defaultLevels= {
  "111111111111000000004110000000001100000000011000000000110000000001100000000011000000000310000000003100000000031000000010310000000003100000000031000000000311111112221", 
  //"?3211111111111111111111111111111111111b000000411111111111111e000000011111111111111e000000011111111111111e000000011111111111111e000000011111111111111e000000011111111111111e000000011111111111111e000000011111111111111e0000000111111111111111ccccccc11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111", 
  "111111311111000000000110000000001100001310011000031100110000311001100003110011000021104110000311001100003110011000031100110000131001100000000011000000000111111131111", 
  "131111111111000000000110111111101100000031011011111110110000003101101111111011000000214110111111101100000031011011111110110000003101101111111011000000000113111111111", 
  "111111111111211111110110311111301101111111011031111130110111111101103111113011013131310110000400001101310131011031303130110313031301101310131011000000000111111211111", 
  "111111111111000000004110000000003101331111111000000000310000010003100000000031000001000310000000003100000100031000000000310000010003100000000031000001000311111211111", 
  "111111111111000000004110000000071100000007111000000061110000000061100000000011000000000310000000003100000000031000000000310000000003101111111111000000000211113333333", 
  "111111111111000000004110000000071100000007111000000711110000071111100007111111000711111110003333333100000000031000000000310000000333100000000031000000000213333333322", 
  "11111111111140000000011111111b0011ccccccccc11b0011111111eeeeeeeee1111111111011300000000113000000001130000000011300000000113000000001130000000011300000000111111111121", 
  "11111111111100cb0c0321100ce0c03e1100ce0c03e1100ce0c03e11b0ce0c0ce1110b0b00ee1140b00e0c31110100e03311b0c00e0331100c00e0331100c00e0331100c00e0331100c00e033111111111111", 
  "111111311331b0000e00k3100000e0001100000e0001100000b00011cccc1111c110000110001100002b0041100001100011eeee1111e1100000b0001100000c0001100000c00011b0000c00h311111131133", 
  "11111111111111111111111111111111111b00041111113cccc111111b00001111113eeee111111b0000c311113cccc1111113000011111130000111111333321111111111111111111111111111111111111", 
  "1111111k3331111111ik3316111113ik3106111133ik1006111333i10006120001100006100011400000000110000710001100071200011007111333j107111133jh17111113jh31111111jh331111111h333", 
  //"3331111111133j611111113j0061111113000c6111113000c0611113000c0061113000c0016113000b00e4c13000c00e7c13000c0071c13000c0711c13000c7111c13i0071111c133i711111c1333111111c2", 
  "111111111111000000000110110010001100000010011000000100110000001001100000010011004000100110000001001100000010011000000100110000001001101100100011000000000111111111111"
};
GButton Start;
GButton Edit;
GButton SingleScreen;
GButton MultiScreen;
GButton Exit;
GButton Ok;
GButton Ok2;
GButton LoadLevel;
GTextField Code;
String[] DEMO;
int demoTimer=0;






void settings() {

  settings=loadStrings("data/options.txt");
  if (settings==null) {
    String[] newSettings={
      "default_screen:0", 
      "version:0.0.1a"
    };
    saveStrings("data/options.txt", newSettings);
    settings=newSettings;
  }
  cellCodes=new color[5];
  cellCodes[0]=0;
  cellCodes[1]=color(200, 200, 0);
  cellCodes[2]=color(200, 0, 0);
  cellCodes[3]=color(0, 0, 0, 0);
  cellCodes[4]=color(190, 25, 209);
  //fullScreen();//Integer.parseInt(settings[0].split(":")[1]));
  size(1000, 563);
  String[] versions =  loadStrings("https://raw.githubusercontent.com/metype/Jump/master/version.txt");
  if (version==null) {
    version=settings[1].split(":")[1];
  } else {
    version=versions[0];
  }
}

void setup() {
  Start=new GButton(this, width/2-475, 125, 300, 75, "Start");
  Start.setFont(new Font("Dialog", Font.PLAIN, 34));
  Start.setVisible(true);
  Edit=new GButton(this, width/2-150, 125, 300, 75, "Edit");
  Edit.setFont(new Font("Dialog", Font.PLAIN, 34));
  Edit.setVisible(true);
  Exit=new GButton(this, width/2+175, 125, 300, 75, "Exit");
  Exit.setFont(new Font("Dialog", Font.PLAIN, 34));
  Exit.setVisible(true);
  SingleScreen=new GButton(this, width/2-150, 250, 300, 75, "Single Screen");
  SingleScreen.setFont(new Font("Dialog", Font.PLAIN, 34));
  SingleScreen.setVisible(true);
  MultiScreen=new GButton(this, width/2-150, 350, 300, 75, "Multi Screen");
  MultiScreen.setFont(new Font("Dialog", Font.PLAIN, 34));
  MultiScreen.setVisible(true);
  LoadLevel=new GButton(this, width/2-150, 225, 300, 75, "Load from Code");
  LoadLevel.setFont(new Font("Dialog", Font.PLAIN, 34));
  LoadLevel.setVisible(true);
  Ok=new GButton(this, width/2-37.5, 350, 75, 75, "Ok");
  Ok.setFont(new Font("Dialog", Font.PLAIN, 34));
  Ok.setVisible(true);
  Ok2=new GButton(this, width/2-37.5, 350, 75, 75, "Ok");
  Ok2.setFont(new Font("Dialog", Font.PLAIN, 34));
  Ok2.setVisible(true);

  Code=new GTextField(this, width/2-300, 250, 600, 25);

  console=new Console(0, 0, width, height/2);

  level=new Level(15, 11, width, height);
  inv = new Level(15, 11, width, height);
  gfx=new PImage[listFiles(sketchPath()+"/data/gfx").length];
  File[] files =listFiles(sketchPath()+"/data/gfx");
  for (int i=0; i<files.length; i++) {
    gfx[i]=loadImage("data/gfx/"+i+".png");
    gfx[i].resize(level.tileSize, level.tileSize);
  }

  eval("playDemo data/finalDemos/BG.dem");
  sdr5 = new GCustomSlider(this, width/2-130, 150, 260, 80, null);
  sdr5.setShowDecor(false, true, true, true);
  sdr5.setNumberFormat(G4P.EXPONENT, 1);
  sdr5.setLimits(0, 15);
  sdr5.setNbrTicks(16); 
  sdr5.setEasing(1);
  sdr5.setStickToTicks(true);

  sdr6 = new GCustomSlider(this, width/2-130, 250, 260, 80, null);
  sdr6.setShowDecor(false, true, true, true);
  sdr6.setNumberFormat(G4P.EXPONENT, 1);
  sdr6.setLimits(0, 15);
  sdr6.setNbrTicks(16); 
  sdr6.setEasing(1);
  sdr6.setStickToTicks(true);
  surface.setTitle("Jump! - A Platformer on Java");
}

void draw() {
  frameRate(60);
  background(51);
  if (mode==0||mode==1) {
    if (level.scrollable) {
      if (frameCount%2==0) {
        level.render(false);
      }
    } else {
      level.render(false);
    }
    if (mode==0) {
      if (level.scrollable) {
        if (frameCount%2==0) {
          player.render();
        }
      } else {
        player.render();
      }
      if (debug) {
        if (keyPressed) {
          textSize(20);
          text(parseInt(""+key), 10, 30);
        }
      }
    }
    Start.setVisible(false);
    Edit.setVisible(false);
    Exit.setVisible(false);
    SingleScreen.setVisible(false);
    MultiScreen.setVisible(false);
  }

  if (mode==2) {
    textAlign(CENTER);

    level.render(false);//Offset(160);

    player.render();

    fill(255);
    textSize(34);
    text("Jump! - A Platformer", width/2, 50);
    textSize(15);
    text("Version : "+version, width/2, 80);
    Start.setVisible(true);
    Edit.setVisible(true);
    Exit.setVisible(true);
    LoadLevel.setVisible(true);
    SingleScreen.setVisible(false);
    MultiScreen.setVisible(false);
  } else {
    LoadLevel.setVisible(false);
    Start.setVisible(false);
    Edit.setVisible(false);
    Exit.setVisible(false);
  }

  if (mode==3||mode==4) {
    background(100);
    textAlign(CENTER);

    fill(255);
    textSize(34);
    text((mode==3)?"Jump! - A Platformer\n\nChoose One":"Jump! - A Platformer\n\nChoose Size", width/2, 50);
    Start.setVisible(false);
    Edit.setVisible(false);
    Exit.setVisible(false);
    SingleScreen.setVisible(mode==3);
    //MultiScreen.setVisible(mode==3);
    sdr5.setVisible(mode==4);
  }
  sdr5.setVisible(mode==4);
  sdr6.setVisible(mode==4);
  Ok2.setVisible(mode==4);
  if (mode==6) {
    textAlign(CENTER);

    fill(255);
    textSize(34);
    text("Level Code", width/2, 50);
    Code.setVisible(true);
    Ok.setVisible(true);
  } else {
    Code.setVisible(false);
    Ok.setVisible(false);
  }
  if (mode==7) {
    inv.render(false);
    if (mousePressed) {
      if (inv.get((float)mouseX+(inv.tileSize/2), (float) mouseY+(inv.tileSize/2))!=null) {
        tileType=inv.get((float)mouseX+(inv.tileSize/2), (float)mouseY+(inv.tileSize/2)).type;
        mode=1;
      }
    }
  }
  if (recordMode) {
    keys.add(new Keys(player.isUp, player.isDown, player.isLeft, player.isRight, lvl));
  }
  if (playMode) {

    if (DEMO!=null) {
      demoTimer++;
      try {

        if (mode!=2) {
          textSize(10);
          fill(255);
          textAlign(CORNER);
          text("Frame : "+demoTimer+"/"+DEMO.length, 5, height-5);
        }

        if (demoTimer==1) {
          lvl=parseInt(DEMO[0]);
          level.createLevel(defaultLevels[lvl]);
        }
        player.isUp=(DEMO[demoTimer].substring(0, 1).equals("1"));
        player.isDown=(DEMO[demoTimer].substring(1, 2).equals("1"));
        player.isLeft=(DEMO[demoTimer].substring(2, 3).equals("1"));
        player.isRight=(DEMO[demoTimer].substring(3, 4).equals("1"));
      }
      catch(StringIndexOutOfBoundsException e) {
        console.println(e);
      }
      catch(Exception e) {
        playMode=false;
        console.println("Demo Finished Without Issue", color(0, 200, 0));
        if (mode==2) {
          eval("playDemo data/finalDemos/BG.dem");
        } else {
          consoleShown=true;
        }
      }
    }
  }
  if (consoleShown) {
    console.render();
    fill(255);
    stroke(255);
    textSize(10);
    if (frameCount%50<25) {
      text(">"+command+"|", 20, console.x+console.height-3);
    } else {
      text(">"+command, 20, console.x+console.height-3);
    }
  }
  fill(255);
  textSize(20);
  text(floor(frameRate), 20, 30);
  //level.set((float)mouseX+(level.tileSize/2), (float) mouseY+(level.tileSize/2), tileType);
  for (AnimationTimer timer : animationTimers) {
    if (timer.current<timer.ending) {
      timer.draw();
    }
  }
}

public void handleButtonEvents(GButton button, GEvent event) {
  if (button==Start) {
    loadLevel=false;
    player.resetVelocity();
    lvl=0;
    eval("endDemo");
    level.createLevel(defaultLevels[0]);
    mode=0;
  } else if (button==Edit) {
    loadLevel=false;
    level.createLevel("111111111111000000000110000000001100000000011000000000110000000001100000000011000000000110000000001100000000011000000000110000000001100000000011000000000111111111111");
    mode=3;
    eval("endDemo");
  } else if (button==Exit) {
    exit();
  } else if (button==SingleScreen) {
    level.setScrollable(false);
    mode=1;
  } else if (button==MultiScreen) {
    level.setScrollable(true);
    mode=4;
  } else if (button==Ok) {
    level.createLevel(Code.getText());
    customLevelCode=Code.getText();
    if (loadLevel) {
      mode=0;
    } else {
      mode=1;
    }
  } else if (button==Ok2) {
    level.createBlankLevel(parseInt(sdr5.getValueS()), parseInt(sdr6.getValueS()));
    mode=1;
  } else if (button==LoadLevel) {
    mode=6;
    loadLevel=true;
    eval("endDemo");
  }
}

void mousePressed() {
  if (mode==1) {
    try {
      level.set((float)mouseX+(level.tileSize/2), (float) mouseY+(level.tileSize/2), tileType);
    }
    catch(Exception e) {
    }
  }
}

void mouseDragged() {
  if (mode==1) {
    try {
      level.set((float)mouseX+(level.tileSize/2), (float) mouseY+(level.tileSize/2), tileType);
    }
    catch(Exception e) {
    }
  }
}

void keyReleased() {
  player.setMove(keyCode, false);
  level.setMove(keyCode, false);
}

void keyPressed() {
  level.setMove(keyCode, true);
  if ((key=='`'||key=='~')&&keyCode!=ESC) {
    consoleShown=!consoleShown;
    keyCode=0;
  }
  if (mode==1) {
    if (key=='s'||key=='S') {
      println(level.saveLevel());
    }
    if (key=='l'||key=='L') {
      Code.setText("");
      mode=6;
    }
    if (key=='i'||key=='I') {
      mode=7;
      inv.createLevel("1230465789abcfhikj");
    }
  }
  if (!consoleShown&&!playMode&&mode!=2) {
    if (keyCode==ESC) {
      key=' ';
      if (mode==1||mode==0||mode==6) {
        handleOptionDialog(1);
      } else if (mode==2) {
        handleOptionDialog(2);
      } else if (mode==7||mode==6) {
        mode=1;
      } else {
        mode=2;
      }
    }
    player.setMove(keyCode, true);
    if (mode==6) {
      if (keyCode==ENTER||keyCode==RETURN) {
        level.createLevel(Code.getText());
      }
    }
  } else {
    boolean ctrl=false;
    if (keyCode==17) {
      ctrl=true;
    }
    if (key!=BACKSPACE&&key!='') {
      if (((keyCode>=65&&keyCode<=90) || (keyCode<=59&&keyCode>=44) || keyCode==32 || keyCode==222 || (keyCode>=91&&keyCode<=93)|| keyCode==45 || keyCode==61||keyCode==192)&&!ctrl) {
        command+=key;
      }
    } else {

      if (ctrl&&keyCode==BACKSPACE) {
        String[] teb = command.split(" ");
        command="";
        teb[teb.length-1]="";
        for (int i=0; i<teb.length; i++) {
          command+=teb[i]+" ";
        }
        command = command.substring(0, (command.length()-2>-1)?command.length()-2:0);
      } else {
        command = command.substring(0, (command.length()-1>-1)?command.length()-1:0);
      }
    }
    switch(key) {
      case(ENTER):
      commandslist.add(command);
      console.println(">"+command, color(#1BE0C4));
      eval(command);
      command="";
      break;
    }
    if (keyCode=='`') {
      consoleShown=!consoleShown;
      command="";
    }
    if (keyCode==ESC) {
      consoleShown=!consoleShown;
      command="";
      key=' ';
    }
    try {
      switch(keyCode) {
        case(38)://up
        commandsIndex=(commandsIndex>0)?commandsIndex-1:0;
        command=commandslist.get(commandsIndex);
        break;
        case(40)://down
        commandsIndex=(commandsIndex<commandslist.size()-1)?commandsIndex+1:commandslist.size()-1;
        command=commandslist.get(commandsIndex);
        break;
      default:
        commandsIndex=commandslist.size();
      }
    }
    catch(Exception e) {
      console.println(e);
    }
  }
}

public void handleOptionDialog(int num) {
  try {
    if (num==1) {
      int reply = G4P.selectOption(this, "Are you sure you want to return to title screen?", "Warning", G4P.WARNING, G4P.YES_NO);
      switch(reply) {
      case G4P.OK:
        lvl=0;
        eval("playDemo data/finalDemos/BG.dem");
        if (recordMode) {
          recordMode=false;
          console.println("Demo cut short and saved due to session being ended", color(200, 200, 0));
          saveStrings("data/demos/"+recordName+".dem", toStringArray(keys));
          level.createLevel(defaultLevels[0]);
        }
        mode=2;
        break;
      case G4P.NO:
      }
    } else if (num==2) {
      int reply = G4P.selectOption(this, "Are you sure you want to quit the game?", "Warning", G4P.WARNING, G4P.YES_NO);
      switch(reply) {
      case G4P.OK: 
        exit();
        break;
      case G4P.NO:
      }
    }
  }
  catch (Exception e) {
    //console.println(e+"");
  }
}

void mouseWheel(MouseEvent event) {
  if (mouseY<500 && consoleShown) {
    float e = event.getCount();
    Coffy-=e*consoleScrollSpeed;
  }
}

void eval(String command) {
  try {
    if (command.equals("help")) {
      console.println("Key:");
      console.println("[] - Required");
      console.println("<> - Optional");
      console.println("| - Or / Varies depending on other arguments");
      console.println("----------------------------------------");
      console.println("help - shows this dialouge");
      console.println("noclip <boolean> - Toggles free movement, if a boolean is provided, will set value to boolean");
      console.println("debug <boolean> - Toggles the display of debug information, if a boolean is provided, will set value to boolean");
      console.println("set [string] [boolean|integer|float|string <field name>]- Sets the specified feild to a specified value");
      console.println("listFields - Lists all fields that can be changed by the \"set\" command");
      console.println("get [string] - Gets the value of the specified feild");
      console.println("println [string (muct be in quotes)] <hex value> - Prints specified string to console and, if provided, in the color associated with the hex value.");
    } else if (command.split(" ")[0].equals("noclip")) {
      String[] teb;
      teb=command.split(" ");
      if (teb.length>1) {
        //noclip = teb[1].contains("true");
        if (teb[1].equals("true")) {
          noclip=true;
        } else if (teb[1].equals("false")) {
          noclip=false;
        } else {
          throw(new Exception("Boolean value not provided"));
        }
      } else {
        noclip=!noclip;
      }
      console.println("noclip : " + noclip);
    } else if (command.split(" ")[0].equals("set")) {
      try {
        String[] teb=command.split(" ");
        if (teb.length>=3) {
          Class<?> c = this.getClass();
          boolean field2=false;
          Field[] teb2=c.getFields();
          for (int i=0; i<teb2.length; i++) {
            if ((teb2[i]+"").split("Main.")[1].equals(teb[2])) {
              field2=true;
            }
          }
          String val = c.getField(teb[1].substring(0, teb[1].length()))+"";
          if (field2) {
            c.getField(teb[1]).set(this, c.getField(teb[2]).get(this));
          } else {
            if (val.contains("Boolean")) {
              c.getField(teb[1]).set(this, Boolean.parseBoolean(teb[2]));
            }
            if (val.contains("Long")) {
              c.getField(teb[1]).set(this, Integer.parseInt(teb[2]));
            }
            if (val.contains("int")) {
              c.getField(teb[1]).set(this, Integer.parseInt(teb[2]));
            }
            if (val.contains("Float")) {
              c.getField(teb[1]).set(this, Float.parseFloat(teb[2]));
            }
            if (val.contains("String")) {
              c.getField(teb[1]).set(this, teb[2]);
            }
          }
          console.println(c.getField(teb[1].substring(0, teb[1].length()))+"="+c.getField(teb[1]).get(this));
        } else {
          console.println("Not enough arguments provided");
        }
      }
      catch(Exception e) {
        console.println(e+"", 100);
      }
    } else if (command.split(" ")[0].equals("get")) {
      String[] teb=command.split(" ");
      Class<?> c = this.getClass();
      console.println(c.getField(teb[1].substring(0, teb[1].length()))+"="+c.getField(teb[1]).get(this));
    } else if (command.split(" ")[0].equals("debug")) {
      String[] teb;
      teb=command.split(" ");
      if (teb.length>1) {
        //noclip = teb[1].contains("true");
        if (teb[1].equals("true")) {
          debug=true;
        } else if (teb[1].equals("false")) {
          debug=false;
        } else {
          throw(new Exception("Boolean value not provided"));
        }
      } else {
        debug=!debug;
      }
      console.println("debug : " + debug);
    } else if (command.split(" ")[0].equals("listFields")) {
      Class<?> c = this.getClass();
      Field[] val = c.getFields();
      for (int i=0; i<val.length; i++) {
        console.println(val[i]+"");
      }
    } else if (command.split(" ")[0].equals("clear")) {
      console.clear();
    } else if (command.split(" ")[0].equals("recordDemo")) {
      if (command.split(" ").length<2) {
        console.println("Not enough arguments provided", color(200, 0, 0));
        return;
      }
      recordMode=true;
      playMode=false;
      consoleShown=false;
      console.println("Demo started", color(0, 200, 0));
      recordName=command.split(" ")[1];
    } else if (command.split(" ")[0].equals("endDemo")) {
      if (recordMode) {
        recordMode=false;
        saveStrings("data/demos/"+recordName+".dem", toStringArray(keys));
        console.println("Stopped Recording and Saved Demo", color(200, 200, 0));
      } else if (playMode) {
        playMode=false;
        player.isUp=false;
        player.isDown=false;
        player.isLeft=false;
        player.isRight=false;
        console.println("Stopped Playing Demo", color(200, 200, 0));
      } else {
        console.println("What Demo?", color(200, 0, 0));
      }
    } else if (command.split(" ")[0].equals("playDemo")) {
      try {
        String path = "ERROR";
        if (!command.contains("/")&&!command.contains("\\")) {
          path = "data/demos/"+command.split(" ")[1]+".dem";
        } else {
          path = command.split(" ")[1];
        }
        console.println("Attempting to load demo file \""+path+"\"", color(200, 200, 0));
        DEMO=loadStrings(path);
      }
      catch(Exception e) {
        if (command.split(" ").length<2) {
          console.println("Not enough arguments provided", color(200, 0, 0));
          return;
        }
        console.println(e, color(200, 0, 0));
      }
      if (DEMO==null) {
        console.println("Failed to find demo", color(200, 0, 0));
        return;
      }
      console.println("Success!", color(10, 210, 0));
      console.println("Starting Demo and Closing console for viewing pleasure", color(10, 210, 0));
      demoTimer=0;
      playMode=true;
      recordMode=false;
      consoleShown=false;
    } else if (command.split(" ")[0].equals("listDemos")) {
      File[] files = listFiles(sketchPath()+"/data/demos");
      if (files.length==0) {
        console.println("There are no demos available", color(200, 200, 0));
      } else {
        for (int i=0; i<files.length; i++) {
          console.println(files[i].getAbsolutePath(), color(200, 200, 0));
        }
      }
    } else if (command.split(" ")[0].equals("println")) {
      String[] teb=command.split("\"");
      if (teb.length>=3) {
        console.println(teb[1], color(Integer.valueOf(teb[2].substring(1, 3), 16), Integer.valueOf(teb[2].substring(3, 5), 16), Integer.valueOf(teb[2].substring(5, 7), 16)));
      } else if (teb.length==2) {
        console.println(teb[1]);
      } else {
        console.println("Not enough arguments provided");
      }
    } else {
      console.println("Unknown Command : \""+(command.substring(0, command.length())).split (" ")[0]+"\", refer to \"help\" for a list of commands", color(200, 10, 5));
    }
  }
  catch (Exception e) {
    console.println(e, 100);
  }
}

//String[] toStringArray(Object[] t){
// String[] stringArray=new String[t.length]; 
// for(int i=0;i<t.length;i++){
//  stringArray[i] = ""+ t[i];
// }
// return stringArray;
//}

String[] toStringArray(ArrayList<Keys> t) {
  String[] stringArray=new String[t.size()+1]; 
  stringArray[0]=""+keys.get(0).startScreen;
  for (int i=1; i<t.size(); i++) {
    stringArray[i] = ((t.get(i-1).getKeys()[0])?'1':'0')+""+((t.get(i-1).getKeys()[1])?'1':'0')+""+((t.get(i-1).getKeys()[2])?'1':'0')+""+((t.get(i-1).getKeys()[3])?'1':'0')+"";
  }
  return stringArray;
}

boolean pause(boolean pse) {
  return pause=pse;
}


void pause() {
  pause=!pause;
}
