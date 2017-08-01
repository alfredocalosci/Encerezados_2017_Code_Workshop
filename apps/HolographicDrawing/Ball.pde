public class Ball implements Drawable{
  
  String name;
  
  int x;
  int y;
  int w;
  int countdown;
  private int COUNTDOWN_W_RELATION=120;
  
  int vx;
  int vy;
  
  color c;
  
  PFont font = loadFont("Arial-Black-48.vlw");
  
  public Ball(String name, int x, int y, int w, int vx, int vy, color c){
    this.name=name;
    this.x=x;
    this.y=y;
    this.w=w;
    this.vx=vx;
    this.vy=vy;
    this.c=c;
    
    this.countdown=this.w*COUNTDOWN_W_RELATION;
  }
  
  public boolean isVisible(){
    return w>0;
  }
  
  public void draw(PGraphics pg){ 
    
    translate(-pg.width/2,-pg.width/2);
    
    int fx=(int)map(x,0,pg.width,y,pg.width-y);
    int fy=y;
    
    fill(this.c);
    //ellipse(fx, fy, this.w, this.w);
    
    textFont(this.font);
    
    fill(150);
    textSize(this.w);
    text("@",fx,fy);
    
    
    if(this.name!=null){
      fill(255);
      textAlign(CENTER,CENTER);
      textSize(4+this.w/4);
      text(name,fx,fy);
    }
    
     translate(pg.width/2,pg.width/2);
    //recalculate(pg);
  }
  
  public void recalculate(PGraphics pg){
    //recalcular posicion
    x+=vx;
    y+=vy;
    
    //correccion rebote en los bordes
    if(x<=0) x=0+w/2+1;
    if(x>=pg.width) x=pg.width-w/2-1;
    if(y<=0) y=0+w/2+1;
    if(y>=pg.height) y=pg.height-w/2-1; 
    
    //recalcular velocidad si rebota
    if(x<=0+w/2 || x>=pg.width-w/2) vx= -vx;
    if(y<=0+w/2 || y>=pg.height-w/2) vy= -vy;
    
    
    this.countdown--;
    if(countdown<=0 ||countdown%COUNTDOWN_W_RELATION==0){
      this.w--;
    }
    
  
    
  }
  
  public String toString(){
    return("name:"+name+" x:"+x+" y:"+y+" w:"+w+" vx:"+vx+" vy:"+vy+" color:"+c);
  }

}