// Holo variables
float xc, yc;
float sw, sh; // screen w and h
float sd; // distancia

// objects
cosa A, B;

boolean rMode;

void setup() {
  size(1280, 1024);
  frameRate(24);

  xc = width/2;
  yc = height/2;

  sw = 280;
  sh = 360;
  sd = 48;

  A = new cosa(80, 80, 32, color(255, 0, 0));
  B = new cosa(80, 80, 32, color(255, 0, 0));
  
  rMode = true;
}

void draw() {
  background(0);

  pushMatrix();
  translate(xc, yc);

  for (int n = 0; n<4; n++) {

    translate(-sw/2, sd);

    // el rectangulo de cada pantalla
   
   if(rMode){
      noFill();
    stroke(255);
    rect(0, 0, sw, sh);
   }
   

    /*
    fill(255);
     noStroke();
     ellipse(10, 10, 8, 8);
     */

    // empieza a dibujar desde aquí
    
   
    A.display();
    B.display();
    
    
    // hasta aquí


    // el nombre de cada pantalla
    /*
    fill(255);
    String t = "s" + n;
    text(t, sw/2, sh/2);
    */

    // back
    translate(sw/2, -sd);

    rotate(HALF_PI);

    // reflejos
    if (n== 1 || n == 3) {
      scale(-1, 1);
    }

    if (n==2) {
      rotate(PI);
    }
  }

  popMatrix();
}

void keyPressed(){
  if(key == 'r'){
    rMode = !rMode;
  }
}