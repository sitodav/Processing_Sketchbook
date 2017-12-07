
int cont = 0;
void setup()
{
  size(900, 900);
  background(0); 
  ellipseMode(CENTER);
  fill(255, 100);
  stroke(255, 100);
  fill(0, 5);
  strokeWeight(1.5);

  /*
funzX.add("cos"); funzY.add("sin");
   funzX.add("sin"); funzY.add("sin");
   funzX.add("sin"); funzY.add("cos");
   
   
   angoli.add(new Float(0.0f));
   angoli.add(new Float(0.0f));
   angoli.add(new Float(0.0f));
   vel.add(new Float(0.2));
   vel.add(new Float(0.4));
   vel.add(new Float(0.9)); */
}

float r = 100;

ArrayList<String> funzX = new ArrayList<String>();
ArrayList<String> funzY = new ArrayList<String>();
ArrayList<Float> angoli = new ArrayList<Float>();
ArrayList<Float>  vel= new ArrayList<Float>();
float ang = 0.0f;
PVector prev;
int prevX=mouseY, prevY = mouseY;


void draw()
{
  cont++;

  //rect(0,0,width,height);
  pushMatrix();



  int m = (int)(1+random(5));

  if (mouseX != prevX || mouseY != prevY)
  {
    prevX = mouseX;
    prevY = mouseY;

    funzX.clear(); 
    funzY.clear();
    vel.clear();
    angoli.clear();

    funzX.add("cos"); 
    funzY.add("sin");
    angoli.add(new Float(0.0f));
    vel.add(new Float(0.2));

    for (int f = 0; f<m; f++)
    {
      String fa = (random(1.0) > 0.5) ? "sin" : "cos";
      //String fb = (random(1.0) < 0.7) ? fa : fa.equals("sin") ? "cos" : "sin" ;
      float velo = 0.1 + random(1.0);
      velo = ((int)(velo*10))/10.0f;
      funzX.add(fa);
      funzY.add(fa);
      vel.add(velo);
      angoli.add(0.0f);
      System.out.print("||"+fa+ " "+ fa+" "+velo);
    }
    System.out.println();
  }





  translate(mouseX, mouseY);
  // rotate(ang);
  //ang+=2.0f;
  float x = r;
  float y = r;


  for (int i=0; i<funzX.size(); i++)
  {
    x = (funzX.get(i).equals("sin")) ? x*sin(angoli.get(i)) : x*cos(angoli.get(i)) ;
    y = (funzY.get(i).equals("sin")) ? y*sin(angoli.get(i)) : y*cos(angoli.get(i)) ;
    angoli.set(i, new Float (angoli.get(i)+vel.get(i)));
  }

  if (prev!=null)
  {
    line(x, y, prev.x, prev.y);
  }
  prev = new PVector(x, y);  
  //noStroke();
  //ellipse(x, y,5,5);
  //stroke(255,50);

  popMatrix();

  if (cont%2 == 0)
  {
    saveFrame("pics/frame-####.png");
  }
}