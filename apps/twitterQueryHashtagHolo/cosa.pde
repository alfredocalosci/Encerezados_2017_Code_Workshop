// Definición de la clase 'cosa': en este caso bolas.

class cosa {
  float x, y;
  float w;
  color c;

  float id;
  String msg, usr; // cadena nombre usuario twitter,

  float vx; // velocidad de desplaz. en horizontal,
  float vy; // velocidad de caida en vertical,

  boolean t = true; // bandera de división del timer,

  // Constructor de cosa;
  cosa(float _x, float _y, float _w, color _c, float _id, String _msg, String _usr) {
    x = _x;
    y = _y;
    w = _w;
    c = _c;

    id = _id; // id. del tweet,
    msg = _msg; // mensaje,
    usr = _usr; // autor,

    vx = random(-2, 2); // velocidades desplazamiento,
    vy = random(-2, 2);
  }

  void display() {
    fill(c);
    noStroke();

    ellipse(x, y, w, w);

    textAlign(CENTER, CENTER); // texto interior,
    fill(255, 255, 255, alpha(c)); // color para el texto,
    textSize(w/4);
    text(usr, x, y);

    // Decrecimiento del canal alfa sólo una vez por segundo:
    if ((int(time.getCurrentTime()) % 2 == 0) && t == true) { // cada 1 segundo se reduce en ...,
      c = color(red(c), green(c), blue(c), alpha(c)-2);
      t = false;
    }

    if ((int(time.getCurrentTime()) % 2 != 0) && t == false) {
      t = true;
    }

    x += vx;
    y += vy;

    // Movimientos:
    if (x > sw || x < 0) {
      vx = vx * -1;
    }  

    if (y > sh || y < 0) {
      vy = vy * -1;
    }
  }

  float alfa() { // devolver el canal alfa.
    return alpha(c);
  }
}