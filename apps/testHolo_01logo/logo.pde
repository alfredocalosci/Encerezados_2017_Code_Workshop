class logo {

  float x, y, w;
  float a, ww;

  logo() {
    x = sw/2;
    y = 120;
    w = 90;
    ww = 0;
  }

  void display() {
    rectMode(CENTER);
    strokeWeight(1);

    noStroke();
    // stroke(255,0,0);
    fill(255);
    //rect(CENTRE, CENTRE, 150, 150);

    rect(x, y, w, w);

    fill(0);
    //rect(CENTRE, CENTRE, 85, 85);
    rect(x, y, w/2, w/2);

    fill(255);
    //triangle(CENTRE-75,CENTRE+75,CENTRE+75,CENTRE+75,CENTRE,CENTRE+150);
    triangle(x-w/2, y+w/2, x+w/2, y+w/2, x, y+w);

    fill(0);
    float d = w/8;
    triangle(x-w/2+(d*2), y+w/2+d/2, x+w/2-(d*2), y+w/2+d/2, x, y+w-(d*1.5));
    rectMode(CORNER);
    
    a+=0.01;
    w += cos(a)/4;

  }
}