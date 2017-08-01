import twitter4j.conf.*;
import twitter4j.api.*;
import twitter4j.*;

import java.util.List;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
  
PGraphics pg;
HashMap<Long,Drawable> drawableObjectsMap;
int PGW;
int PGH;

int MIN_BALL_W=5;
int MAX_BALL_W=50;

int N_ELEMENTS=5;

Long lastTweetId;

Twitter twitter;
Timer time;


void setup() {
  size(800, 800);
  PGW=800;
  PGH=375;
  pg = createGraphics(PGW, PGH);
  drawableObjectsMap=new HashMap<Long,Drawable>();
  
  twitter=buildTwitter();
  time = new Timer(70000); //1 min with 10 secs  
  
  //primera llamada
  reloadTwitterDrawableObjects();
  
  lastTweetId=null;
}

void draw() {
  
  //comprobar que elementos deben retirarse 
  ArrayList<Long> ballIdsToRemove= new ArrayList<Long>();
  for (Map.Entry<Long,Drawable> currentMapEntry:  drawableObjectsMap.entrySet()) {
    if(!currentMapEntry.getValue().isVisible()){
      println("Eliminamos "+currentMapEntry.getKey()+" "+((Ball)currentMapEntry.getValue()).name);
      ballIdsToRemove.add(currentMapEntry.getKey());
    }
  }
  for(Long id: ballIdsToRemove){
    drawableObjectsMap.remove(id);
  }
  
  
  background(0);
  pg.beginDraw();
  //pg.fill(0);
  //pg.stroke(255);
  //pg.triangle(0,0,pg.width,0,pg.width/2,pg.width/2);
  //pg.stroke(0);
  translate(0,height);
  scale(1,-1);
  translate(width/2, height/2);
  for(Drawable currentDrawable: drawableObjectsMap.values()){
    for(int j=0; j<4; j++){
      currentDrawable.draw(pg);
      rotate(PI/2);
    }        
    //println(i+")"+drawableObjects.get(i).toString());
    currentDrawable.recalculate(pg);
  }
  //pg.endDraw(); 
  
  
  
  
  if (time.isDone()) {
    reloadTwitterDrawableObjects();
    time.reset();
  }
  time.update();
  
  
}

void reloadTwitterDrawableObjects(){
  println("inicio reloadTwitterDrawableObjects");
  
  Query query = new Query("#education");
  query.setCount(N_ELEMENTS);
  if(lastTweetId!=null){
    query.maxId(lastTweetId);
  }
  try {
    QueryResult result = twitter.search(query);
    List<Status> tweets = result.getTweets();
    for (Status tw : tweets) {
      Long id=tw.getId();
      Ball newBall=new Ball(tw.getUser().getScreenName(),(int)random(40,PGW-40),(int)random(40,PGH-40),tw.getText().length()/2,
                                      1+(int)random(2), 1+(int)random(2),
                                      255);
      if(!drawableObjectsMap.keySet().contains(id)){
         println("Añadimos "+id+" "+newBall.name);
         drawableObjectsMap.put(id, newBall); //<>//
      }
      lastTweetId=id;    
    }
  }catch (TwitterException te) {
    println("Couldn't connect: " + te);
  }
  println("fin reloadTwitterDrawableObjects");
  
}





void keyPressed(){
  if(key==' '){
    reloadTwitterDrawableObjects();
  }
}


//Twitter utilities
public Twitter buildTwitter(){
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("XXXXXXXXXXXXXXXXXX");
  cb.setOAuthConsumerSecret("XXXXXXXXXXXXXXXXXX");
  cb.setOAuthAccessToken("XXXXXXXXXXXXXXXXXX");
  cb.setOAuthAccessTokenSecret("XXXXXXXXXXXXXXXXXX");
  
 
  //Make the twitter object and prepare the query
  return new TwitterFactory(cb.build()).getInstance();
}