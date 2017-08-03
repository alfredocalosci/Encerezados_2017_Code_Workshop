/*  Bajo un mismo cielo: Perseidas en Cerezales y Processing.
 Fecha: 28 de julio de 2017
 Fundación Cerezales, Encerezados, verano 2017. */

// La app busca tweets cada 70 seg.,
// se convierten al nacer en bolas con el nombre de usuario de su autor en su interior,
// nacen algo transparentes y aumenta su transparencia con el tiempo,
// mueren/desaparecen si la transparencia alcanza cierto valor,
// la rotación en cuatro para la pirámide holográfica está en espejo.

// Hay que instalar instalar twitter4j library desde sketch|Import Library|find: twitter4j (si no Simple Tweet),
// hay mas documentación aquí: http://codasign.com/tutorials/processing-and-twitter/searching-twitter-for-tweets/

import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;

import java.util.List;
import java.util.Iterator;

ConfigurationBuilder   cb;
Query query;
Twitter twitter;

ArrayList<String> twittersList;
Timer             time;

int numberSearch = 10; // nro. twitts en cada búsqueda:

ArrayList <cosa> caja; // caja para 'cosas',
float[] listaId = new float[0]; // array de registro de los tweets,

float ancho;

// Holo variables:
float xc, yc;
float sw, sh; // screen w and h,
float sd; // distancia,

void setup() {
  size(1024, 768);
  frameRate(24);

  xc = width/2;
  yc = height/2;

  sw = 340;
  sh = 280;
  sd = 70;

  caja = new ArrayList();

  // Configura un temporizador para buscar aprox. cada minuto: sólo buscar una vez cada minuto.
  time = new Timer(70000); // 70 seg.,

  // Acreditación:
  // Hay que crear un account para las API de Twitter
  // desde aquí: https://dev.twitter.com

  // lo explica aquí:
  // 2. Getting an API Key From Twitter / Creating an Application
  // http://codasign.com/tutorials/processing-and-twitter/processing-and-twitter-getting-started/

  // y rellenar lo 4 parámetros que aparecen a continuación:
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("*****YOUR-KEY-HERE******");
  cb.setOAuthConsumerSecret("*************YOUR-KEY-HERE*************");
  cb.setOAuthAccessToken("*************YOUR-KEY-HERE***************");
  cb.setOAuthAccessTokenSecret("**********YOUR-KEY-HERE***************");

  // Make the twitter object and prepare the query:
  twitter = new TwitterFactory(cb.build()).getInstance();

  // Búsqueda:
  queryTwitter(numberSearch);
}

void draw() {
  background(0);

  if (time.isDone()) {
    queryTwitter(numberSearch);
    time.reset();
  }

  text(int(time.getCurrentTime()), 10, 10);

  time.update();

  // Mostrar los tweets:
  pushMatrix();
  translate(xc, yc);

  for (int n = 0; n < 4; n++) {
    translate(-sw/2, sd);

    // Rectas:
    noFill();
    stroke(255, 32);
    rect(0, 0, sw, sh);

    /*
    fill(255);
     noStroke();
     ellipse(10, 10, 8, 8);
     */

    for (int m = 0; m < caja.size(); m++) {
      cosa esta = caja.get(m);
      if (esta.alfa() < 30) { // cuando su transp. es menor de 30, se borran,
        caja.remove(m);
      }
      esta.display();
    }

    //String t = "s" + n;
    //text(t, sw/2, sh/2);

    // Back:
    translate(sw/2, -sd);

    rotate(HALF_PI);
  }

  popMatrix();
}

ArrayList<String> queryTwitter(int nSearch) {
  ArrayList<String> twitt = new ArrayList<String>();

  // Busca tweets con el hashtag #perseidas:
  query = new Query("#perseidas");
  query.setCount(nSearch);
  try {
    QueryResult result = twitter.search(query);
    List<Status> tweets = result.getTweets();
    println("New Tweet : ");
    for (Status tw : tweets) { // extraemos los componentes del mensaje: ...
      String msg = tw.getText();
      println(msg.length());
      String usr = tw.getUser().getScreenName();
      String twStr = "@"+usr+": "+msg;
      float id_msg = tw.getId();
      // id.add(tw.getId()); // llevo al registro de ids,
      String id_str = str(id_msg);

      // println(id_msg);
      // println(twStr);

      twitt.add(twStr);

      // listaId.add();

      // Existe ya?:
      boolean yalatengo = false;
      for (int n = 0; n < listaId.length; n++) {
        float miId = listaId[n];
        if (miId == id_msg) {
          yalatengo = true;
        }
      }

      if (!yalatengo) { // no la tengo,
        ancho = random(30, 60);
        // las creo, de color ...
        cosa nueva = new cosa(80, 80, ancho, color(255, 0, 0, random(100, 200)), id_msg, msg, "@"+usr);
        // y las pongo en el contenedor:
        caja.add(nueva);

        listaId = append(listaId, id_msg);
      }

      println(listaId.length);
    }
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }

  return twitt;
}