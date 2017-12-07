
ArrayList<PVector> circle = new ArrayList<PVector>();
ArrayList<PVector> square = new ArrayList<PVector>();
ArrayList<PVector> pos = new ArrayList<PVector>();
int totPs = 100;
int ray = 100;
void setup()
{
   size(600,600); 
   for(int i=0;i<totPs;i++)
   {
       float x = cos( i*(2*PI/(float)totPs) );
       
       float y = sin( i*(2*PI/(float)totPs));
       
       circle.add(new PVector( ray * x , ray * y  ));
       pos.add(new PVector(ray * x, ray * y ));
       
       PVector t = null;
       if( abs(x) > abs(y) )
       {
           t = new PVector( Math.signum( x ) * ray ,ray * y );
       }
       else if(abs(x) < abs(y))
       {
           t = new PVector ( ray * x, Math.signum(y) * ray );
       }
       else
       {
           t = new PVector( ray * x, ray * y );
       }
       
       square.add(t);
       
   }  
}



void draw()
{
  background(0);
  beginShape(POINTS);
  stroke(255);
  translate(width/2,height/2);
  
  
  
  int i = 0;
  for(PVector el : pos)
  {
    PVector t = el.copy();
    float par = ( ((float)(mouseX - width/2 ))/((float)width/2) );;
    System.out.println(par);
    t.x = circle.get(i).x + (square.get(i).x - circle.get(i).x) * par;
    t.y = circle.get(i).y + (square.get(i).y - circle.get(i).y) * par;
    pos.set(i,t);
    i++;
  }
  
  
  
  beginShape(POINTS);
  for(PVector el : pos)
  {
      vertex(el.x,el.y);
  }
  endShape(CLOSE);
  
  
  /*
  beginShape(POINTS);
  int i = 0;
  for(PVector el : square)
  {
     vertex(el.x,el.y); 
     if(i++ > (float)totPs / 4 )
       break;
  }
  endShape(CLOSE);*/
}