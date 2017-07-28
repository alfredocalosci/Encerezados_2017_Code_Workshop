class cosa {

  float x, y;
  float w;
  color c;
  
  String msg, usr;
  float id;

  cosa(float _x, float _y, float _w, color _c, float _id, String _msg, String _usr) {
    w = _w;
    x = _x;
    y = _y; 
    c = _c;
    
    id = _id;
    msg = _msg; 
    usr = _usr;
  }

  void display() {
    fill(c);
    ellipse(x, y, w, w);
    textAlign(CENTER, CENTER);
    fill(255);
    text(usr, x,y);
  }
  
}