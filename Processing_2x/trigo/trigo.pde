void setup()
{
 size(900,900);
 background(0); 
 ellipseMode(CENTER);
 fill(255,100);
 stroke(255,50);
funzX.add("cos"); funzY.add("sin");
funzX.add("sin"); funzY.add("sin");
funzX.add("sin"); funzY.add("cos");

/*
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
int numFrames = 0;



void draw()
{
    pushMatrix();
      
      float a = random(1.0);
      float b = random(1.0);
      int m = 1+random(5);
      
      if(numFrames++ % 100 == 0)
      {
        funzX.clear(); 
        funzY.clear();
        vel.clear();
        angoli.clear();
        
        for(int f = 0; f<m;f++)
        {
           String a = (random(1.0) > 0.5) ? "sin" : "cos";
           String b = (random(1.0) < 0.7) ? a : a.equals("sin") ? "cos" : "sin" ;
           float velo = random(1.0);
           funzX.add(a);
           funzY.add(b);
           vel.add(velo);
           angle.add(0.0f);
              
        }
      }
      
      
      
      
      
      translate(mouseX,mouseY);
     // rotate(ang);
      //ang+=2.0f;
      float x = r;
      float y = r;
      
      
      for(int i=0;i<funzX.size(); i++)
      {
         x = (funzX.get(i).equals("sin")) ? x*sin(angoli.get(i)) : x*cos(angoli.get(i)) ;
         y = (funzY.get(i).equals("sin")) ? y*sin(angoli.get(i)) : y*cos(angoli.get(i)) ;
         angoli.set(i , new Float (angoli.get(i)+vel.get(i))); 
      }
      
      if(prev!=null)
      {
         line(x,y,prev.x,prev.y);
      }
      prev = new PVector(x,y); 
      //noStroke();
      //ellipse(x, y,5,5);
      //stroke(255,50);
      
    popMatrix();
  
}
