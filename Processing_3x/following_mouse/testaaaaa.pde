void setup()
{
   size(1000,1000);
   background(255); 
   //fullScreen();
}

Spawner spawner = new Spawner();
int c = 0;

void draw()
{
 fill(255,50);
 rect(0,0,1000,1000);
  c++;
  if(c % 100 == 0)
    spawner.spawn();
  
  spawner.governa();
  spawner.disegna();
}

void mouseMoved()
{
   PVector a = new PVector(mouseX,mouseY);
   PVector b = new PVector(pmouseX,pmouseY);
   float m = a.copy().sub(b).magSq();
   
   if(m > 0.5f)
   {
     spawner.addMoveToToAll(a);
   }
}


class Spawn
{
   PVector pos ;
   ArrayList<PVector> moveTos = new ArrayList<PVector>();
   public Spawn(double x,double y)
   {
     pos = new PVector((float)x,(float)y);
   }
   public void addMoveTo(PVector t)
   {
      moveTos.add(t); 
         
   }
   public void governato()
   {
       if(moveTos.size() == 0) return;
       
       PVector last = moveTos.get(0);
    
       float xn = pos.x + 0.1*(last.x - pos.x);
       float yn = pos.y + 0.1*(last.y - pos.y);
       pos = new PVector(xn,yn);
       if(new PVector(xn-pos.x,yn-pos.y).mag() < 0.1)
         moveTos.remove(0);
       
        
   }
   void disegna()
   {
     pushMatrix();
       translate(pos.x,pos.y);
       fill(0,250);
       stroke(0);
       ellipse(0,0,10,10);
       
     popMatrix();
   }
}


class Spawner
{
  ArrayList<Spawn> spawn = new ArrayList<Spawn>();
  public void spawn()
  {
     spawn.add(new Spawn(random(width),random(height))); 
  }
  public void governa()
  {
     for(Spawn s : spawn)
     {
        s.governato(); 
     }
  }
  public void addMoveToToAll(PVector t)
  {
     for(Spawn s : spawn)
     {
        s.addMoveTo(t); 
     }
  }
  
  public void disegna()
   {
      for(Spawn s : spawn)
      {
         s.disegna(); 
      }
   }
  
  
}