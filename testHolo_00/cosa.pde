class cosa {

  float x, y;
  float w;
  color c;

  float vx, vy;

  String msg, usr;
  float id;

  cosa(float _x, float _y, float _w, color _c) {
    w = _w;
    x = _x;
    y = _y; 
    c = _c;

    vx = random(-3, 3);
    vy = random(-3, 3);

    // float _id, String _msg, String _usr

    /*
    id = _id;
     msg = _msg; 
     usr = _usr;
     */
  }

  void display() {
    fill(c);
    noStroke();
    ellipse(x, y, w, w);

    x += vx;
    y += vy;

    /*
    textAlign(CENTER, CENTER);
     fill(255);
     text(usr, x,y);
     */

    if (x > sw || x < 0) {
      vx = vx * -1;
    }
    
    if (y > sh || y < 0) {
      vy = vy * -1;
    }

    
  }
}