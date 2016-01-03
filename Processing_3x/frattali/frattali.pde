int numGen = 4;
int numVert = 2;

long contA=0,contB = 0;

boolean toUp = true;

class Linea
{
   PVector a;
   PVector b;
   
   public Linea(PVector a,PVector b)
   {
      this.a = a; this.b = b;
   } 
   public void draw()
   {
      pushMatrix();
      
      translate(a.x,a.y);
      line(0,0,b.x - a.x,b.y-a.y);
      popMatrix(); 
   }
}

class LineeDispenser
{
   ArrayList<Linea> linee = new ArrayList<Linea>();
   public LineeDispenser(PVector startA, PVector startB)
   {
      linee.add(new Linea(startA,startB));
   }
   public LineeDispenser(ArrayList<Linea> toAdd)
   {
      for(Linea l : toAdd)
      {
         linee.add(l);
      } 
   }
   public void nuovaGenerazione()
   {
      ArrayList<Linea> nuovaGen = new ArrayList<Linea>();
      for(Linea l : linee)
      {
         float thirdLength = 0.3333f * (sqrt( (l.b.x - l.a.x)*(l.b.x - l.a.x) + (l.b.y - l.a.y)*(l.b.y - l.a.y) ));
         float oldAlpha = 0.0f+atan2( l.b.y - l.a.y, l.b.x - l.a.x  );
        // System.out.println(oldAlpha);
         PVector a = l.a;
         PVector b = new PVector( a.x + 0.3333f*(l.b.x - l.a.x), a.y + 0.3333f*(l.b.y - l.a.y) );
         PVector c = new PVector( b.x+cos( PI/3.0f + oldAlpha) * thirdLength, b.y + sin( PI/3.0f + oldAlpha)*thirdLength );
         PVector d = new PVector(b.x + 0.3333f*(l.b.x - l.a.x), b.y + 0.3333f*(l.b.y - l.a.y) );
         PVector e = new PVector(l.b.x,l.b.y); 
         
         nuovaGen.add(new Linea( a,b ));
         nuovaGen.add(new Linea( b,c ));
         nuovaGen.add(new Linea( c,d ));
         nuovaGen.add(new Linea( d,e ));
         
      }
      linee = nuovaGen;
   } 
   public void disegnaLinee()
   {
      for(Linea l: linee)
      {
         l.draw();
      } 
   }
}

LineeDispenser disp = null;

public void setup()
{
  
   
      numGen = 4;
      numVert = 2;
   size(1000,800,P2D);
   background(255);
   stroke(0);
   //disp = new LineeDispenser(new PVector(0, height/2), new PVector(width,height/2));
  startAt(width/2,height/2);
  
}

public void draw()
{
   contA++;
   contB++;
   
  
   
      if(toUp)
        numVert ++;
      else numVert--;
      
      numVert = numVert % 2 != 0 ? toUp ? numVert +1 : numVert-1 : numVert;
      
      ;
     if(numVert > 4)
       toUp = false;
     if(numVert<4)
       toUp = true;
   
   background(255);
  
   disp.disegnaLinee(); 
   
     
      startAt(width/2,height/2); 
   
}






public ArrayList<Linea> nuovoCerchio(int lvlRim,float x,float y,float radius)
{
  if(lvlRim ==0)
    return null;
  float angle = 2*PI / numVert;
   PVector center = new PVector(x,y);
   ArrayList<Linea> toAdd = new ArrayList<Linea>();
   for(int i=0;i<numVert;i++)
   {
     PVector a = new PVector( center.x + radius * cos(i*angle), center.y + radius * sin(i*angle) );
     PVector b = new PVector( center.x + radius * cos((i+1)*angle), center.y + radius * sin((i+1)*angle) );
     toAdd.add(new Linea(a,b));
   }
   ArrayList<Linea> t =nuovoCerchio(lvlRim-1,x+radius/2,y,radius/2);
   if(t!=null)
     for(Linea el : t)
     {
        toAdd.add(el); 
     }
   t=nuovoCerchio(lvlRim-1,x-radius/2,y,radius/2);
   if(t!=null)
     for(Linea el : t)
     {
        toAdd.add(el); 
     }
   t=nuovoCerchio(lvlRim-1,x,y+radius/2,radius/2);
   if(t!=null)
     for(Linea el : t)
     {
        toAdd.add(el); 
     }
   t=nuovoCerchio(lvlRim-1,x,y-radius/2,radius/2);
   if(t!=null)
     for(Linea el : t)
     {
        toAdd.add(el); 
     }
   return toAdd;
}

public void startAt(float x,float y)
{
   /*disp = new LineeDispenser(new PVector(0,height/2), new PVector(mouseX,mouseY)); 
   for(int i=0;i<numGen;i++)
   {
      disp.nuovaGenerazione(); 
   }*/
  
  
   ArrayList<Linea> toAdd = nuovoCerchio(4,x,y,300);
   disp = new LineeDispenser(toAdd);
   for(int i=0;i<numGen;i++)
   {
      disp.nuovaGenerazione(); 
   }
   
}

public void mouseClicked()
{
  
    //numGen++;
}