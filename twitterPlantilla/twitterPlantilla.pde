// hay que instalar instalar twitter4j library
// desde sketch > Import Library > find: twitter4j

// hay mas documentación aquí:
// http://codasign.com/tutorials/processing-and-twitter/searching-twitter-for-tweets/

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

//Number twitters per search
int numberSearch = 10;

PFont font;
int   fontSize = 14;

float H;

ArrayList <cosa> Cajon;

void setup() {
  size(670, 650);
  background(0);
  smooth(4);
  colorMode(HSB, 360, 100, 100);
  Cajon = new ArrayList();

  //FONT
  font = createFont("NexaLight-16.vlw", fontSize, true);
  textFont(font, fontSize);

  // configura un temporizador para buscar aprox cada minuto
  //You can only search once every 1 minute
  time = new Timer(70000); //1 min with 10 secs

  //  Acreditacion
  //  Hay que crear un account para las API de twetter
  //  desde aquí: https://dev.twitter.com

  //  lo explica aquí:
  //  2. Getting an API Key From Twitter / Creating an Application
  //  http://codasign.com/tutorials/processing-and-twitter/processing-and-twitter-getting-started/

  // y rellenar lo 4 parametros que aparecen a continuación:


  cb = new ConfigurationBuilder();      //Acreditacion
  cb.setOAuthConsumerKey("Hr8yDUZYhBwhO1OiUGyZA");   
  cb.setOAuthConsumerSecret("gmQDsJ385rYSi9WbGpKsWnfh9IPrqg03qQUc4oK2AI");   
  cb.setOAuthAccessToken("1371907867-Gmr9Rxhwq3RZaBtGWXAODS5cCMS7qDIrTvRbDFg");   
  cb.setOAuthAccessTokenSecret("SE9UIJ5rWjsxnjWngFj31Rc26pbT2ITXvwWCUez1s");

  /*
  ConfigurationBuilder cb = new ConfigurationBuilder();
   cb.setOAuthConsumerKey("*****YOUR-KEY-HERE******");
   cb.setOAuthConsumerSecret("*************YOUR-KEY-HERE*************");
   cb.setOAuthAccessToken("*************YOUR-KEY-HERE***************");
   cb.setOAuthAccessTokenSecret("**********YOUR-KEY-HERE***************");
   */

  //Make the twitter object and prepare the query
  twitter = new TwitterFactory(cb.build()).getInstance();

  //SEARCH
  twittersList = queryTwitter(numberSearch);

  H = 0;
}

void draw() {
  // background(H,80,80);
  background(0, 0, 0);

  //draw twitters
  //drawTwitters(twittersList);

  if (time.isDone()) {
    twittersList = queryTwitter(numberSearch);
    time.reset();
  }

  textAlign(LEFT,CENTER);
  text(time.getCurrentTime(), 20, 30);

  time.update();
  H = map(time.getCurrentTime(), 0, 60, 0, 360); // 0 > 60
  // println(H);
  // map(time.getCurrentTime(), 0 , 60, );

  for (int n = 0; n < Cajon.size(); n++) {
    cosa esta = Cajon.get(n);
    esta.display();
  }
}

void drawTwitters(ArrayList<String> tw) {
  Iterator<String> it = tw.iterator();
  int i = 0;

  while (it.hasNext ()) {
    String twitt = it.next();
    fill(0, 100, 100);
    text(i + 1, 27, 60 + i*(fontSize)*4 + fontSize);
    fill(0, 0, 100);
    text(twitt, 50, 60 + i*(fontSize)*4, 600, fontSize*4);
    i++;
  }
}

ArrayList<String> queryTwitter(int nSearch) {
  ArrayList<String> twitt = new ArrayList<String>();

  // busca tweets con el hashtag: #againstracism
  query = new Query("#education");
  query.setCount(nSearch);
  try {
    QueryResult result = twitter.search(query);
    List<Status> tweets = result.getTweets();
    println("New Tweet : ");
    for (Status tw : tweets) {
      String msg = tw.getText();
      String usr = tw.getUser().getScreenName();
      String twStr = "@"+usr+": "+msg;
      float id_msg = tw.getId();
      String id_str = str(id_msg);

      println(id_msg);
      println(twStr);

      twitt.add(twStr);

      // existe ya ?
      boolean yalatengo = false;
      for (int n = 0; n < Cajon.size(); n++) {
        cosa esta = Cajon.get(n);
        float miId = esta.id;
        if (miId == id_msg) {
          yalatengo = true;
        }
      }

      if (!yalatengo) {
        // no la tengo
        cosa B = new cosa(random(width), random(height), random(6, 120), color(200, 90, 90), id_msg, msg, usr);
        // ponlo en el contenedor
        Cajon.add(B);
      }
    }
  }
  catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }

  return twitt;
}