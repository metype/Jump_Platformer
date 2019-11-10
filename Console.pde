class Console {
  int x=0;
  int y=0;
  int width=0;
  int height=0;
  ArrayList<String> console= new ArrayList();
  ArrayList<String> colors= new ArrayList();
  Console(int x, int y, int width, int height) {
    this.x=x;
    this.y=y;
    this.width=width;
    this.height=height;
  }

  public void println(String string) {
    console.add(string);
    main.Coffy=0;
  }
    public void println(String string,color c) {
    console.add(string +"COLORHERE"+c);
    main.Coffy=0;
  }
    public void println(Exception string) {
    console.add(string+"");
    main.Coffy=0;
  }
    public void println(Exception string,color c) {
    console.add(string +"COLORHERE"+c);
    main.Coffy=0;
  }
    public void println(float string) {
    console.add(string+"");
    main.Coffy=0;
  }
    public void println(float string,color c) {
    console.add(string +"COLORHERE"+c);
    main.Coffy=0;
  }
    public void println(Boolean string) {
    console.add(string+"");
    main.Coffy=0;
  }
    public void println(Boolean string,color c) {
    console.add(string +"COLORHERE"+c);
    main.Coffy=0;
  }
    public void println(Object string) {
    console.add(string+"");
    main.Coffy=0;
  }
    public void println(Object string,color c) {
    console.add(string +"COLORHERE"+c);
    main.Coffy=0;
  }
  public void clear() {
    console=new ArrayList();
  }
  public void render() {
    try{
    fill(0, 150);
    stroke(0);
    rectMode(CORNER);
    rect(this.x, this.y, this.width, this.height);
    fill(255);
    stroke(255);
    textAlign(LEFT);
    textSize(main.consoleTextSize);
    for (int i=console.size(); i>0; i--) {
      if (i==console.size()&& (((this.x+this.height)-(i*main.consoleTextSize+2))-25)+main.Coffy>main.consoleTextSize) {
        main.Coffy-=((((this.x+this.height)-(i*main.consoleTextSize+2))-25)+main.Coffy)-main.consoleTextSize;
      }
      if ( (((this.x+this.height)-(i*main.consoleTextSize+2))-25)+main.Coffy<500-main.consoleTextSize-5) {
        if(console.get(constrain((int)map(i, 0, console.size(), console.size(), 0), 0, console.size())).contains("COLORHERE")){
          fill(Integer.parseInt(console.get(constrain((int)map(i, 0, console.size(), console.size(), 0), 0, console.size())).split("COLORHERE")[1]));
        }else {
         fill(255); 
        }
        text(console.get(constrain((int)map(i, 0, console.size(), console.size(), 0), 0, console.size())).split("COLORHERE")[0], 20, (((this.x+this.height)-(i*main.consoleTextSize+2))-25)+main.Coffy);
      }
    }
    fill(51, 150);
    stroke(0);
    rect(0, this.y+this.height-12, this.width, 12);
  }catch(Exception e){
   println(e+""); 
  }
}
}
