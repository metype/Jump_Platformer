class AnimationTimer {
  PApplet applet;
  String name;
  AnimationType type;
  int starting, ending, current;
  AnimationTimer(PApplet applet, String name, int starting, int ending, AnimationType type) {
    this.applet=applet;
    this.name=name;
    this.starting=starting;
    this.ending=ending;
    this.current=this.starting;
    this.type=type;
    if (type.type.equalsIgnoreCase("GIF")) {
      type.GIF.play();
    }
  }

  public void draw() {
    if (current==ending) {
      dispose();
    }
    current++;
    if (type.type.equalsIgnoreCase("GIF")) {
      imageMode(CENTER);
      image(type.GIF, width/2, height/2);
    }
    if (type.type.equalsIgnoreCase("IMG") ||  type.type.equalsIgnoreCase("IMAGE")) {
      imageMode(CENTER);
      image(type.img, width/2, height/2);
    }
    if (type.type.equalsIgnoreCase("TXT") ||  type.type.equalsIgnoreCase("Text")) {
      textSize(map(current, starting, ending, 10, 150));
      textAlign(CENTER, CENTER);
      fill(color(0, 150, 0, map(current, starting, ending, 255, 0)));
      text(type.text, width/2, height/2);
    }
  }

  public void reset() {
    this.current=this.starting;
  }
}

class AnimationType {
  String type;
  Gif GIF;
  PImage img;
  String text;

  AnimationType(String type) {
    this.type=type;
    if (type.equalsIgnoreCase("GIF")) {
      println(new Exception("Please use the 'AnimationType(PApplet applet, String type, String GIFPath)' constructor to use GIFs"));
      dispose();
    } else    if (type.equalsIgnoreCase("IMG")||type.equalsIgnoreCase("IMAGE")) {
      println(new Exception("Please use the 'AnimationType(String type, PImage img)' constructor to use images"));
      dispose();
    }
  }
  AnimationType(String type, String text) {
    this.type=type;
    this.text=text;
    if (type.equalsIgnoreCase("GIF")) {
      println(new Exception("Please use the 'AnimationType(PApplet applet, String type, String GIFPath)' constructor to use GIFs"));
      dispose();
    } else    if (type.equalsIgnoreCase("IMG")||type.equalsIgnoreCase("IMAGE")) {
      println(new Exception("Please use the 'AnimationType(String type, PImage img)' constructor to use images"));
      dispose();
    }
  }

  AnimationType(String type, PImage img) {
    this.type=type;
    this.img=img;
    if (type.equalsIgnoreCase("GIF")) {
      println(new Exception("Please use the 'AnimationType(String type, PImage GIF)' constructor to use GIFs"));
      dispose();
    }
  }

  AnimationType(PApplet main, String type, String GIFPath) {
    this.type=type;
    this.GIF = new Gif(main, GIFPath);
    if (type.equalsIgnoreCase("IMG")||type.equalsIgnoreCase("IMAGE")) {
      println(new Exception("Please use the 'AnimationType(String type, PImage img)' constructor to use images"));
      dispose();
    }
  }
}
