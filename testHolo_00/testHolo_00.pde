// Hola variables
float xc, yc;
float sw, sh; // screen w and h
float sd; // distancia

// objects
cosa A,B;

void setup() {
  size(768, 576);
  frameRate(24);

  xc = width/2;
  yc = height/2;

  sw = 240;
  sh = 180;
  sd = 60;
  
  A = new cosa(80,80,32,color(255,0,0));
  B = new cosa(80,80,32,color(255,0,0));
}

void draw() {
  background(0);

  pushMatrix();
  translate(xc, yc);

  for (int n = 0; n<4; n++) {
    
    translate(-sw/2, sd);
    
    // rect
    noFill();
    stroke(255,32);
    rect(0, 0, sw, sh);

    /*
    fill(255);
    noStroke();
    ellipse(10, 10, 8, 8);
    */
    
    A.display();
    B.display();
    
    //String t = "s" + n;
    //text(t, sw/2, sh/2);
    
    // back
    translate(sw/2, -sd);
    
    rotate(HALF_PI);
  }

  popMatrix();
}