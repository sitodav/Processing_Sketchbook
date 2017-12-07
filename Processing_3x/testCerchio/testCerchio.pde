void setup()
{
  size(500,500);
  cent = new PVector(width/2,height/2);
  a = min(a,b);
  b = max(a,b);
  //interv.add(new PVector(a,b));
  lastGen = generaIntervalli(ords,a,b,0);
  background(0);
  
}
PVector cent;
float ray = 250;
float a = random(0,PI);
float b = a+ 10*random(0,PI);
//ArrayList<PVector> interv = new ArrayList<PVector>();
HashMap<Integer,ArrayList<PVector> > ords = new HashMap<Integer,ArrayList<PVector> >();
int cont = 0;
int lastGen;
int actualDrawGen = 0;

void draw()
{
   //background(0); 
   noFill();
   stroke(255,100);
   //ellipseMode(CENTER);
   //ellipse(cent.x,cent.y,2 * ray,2 * ray);
   
   if(((++cont)% 2 )== 0 && ords.get(actualDrawGen) != null)
   {
      
     ArrayList<PVector> popL = ords.get(actualDrawGen);
     for(PVector pop : popL)
     {
       float angoloA = pop.x;
       float angoloB = pop.y;
       float angoloCentrale = (pop.x + pop.y )/2 ;
       float tRay = ray * (1-( (float)actualDrawGen / lastGen ));
       line(cent.x,cent.y, cent.x + tRay * cos(angoloCentrale) , cent.y + tRay * sin(angoloCentrale));
       line(cent.x,cent.y, cent.x + tRay * cos(angoloA) , cent.y + tRay * sin(angoloA));
       line(cent.x,cent.y, cent.x + tRay * cos(angoloB) , cent.y + tRay * sin(angoloB));
       
     }
     actualDrawGen++;
   }
}


Integer generaIntervalli(HashMap<Integer,ArrayList<PVector>> ord,float a,float b,int gen)
{
  
  //ints.add(new PVector( a,b ));
  
  if(!ord.containsKey(gen))
  {
    ord.put(gen,new ArrayList<PVector>());
  }
  
  ArrayList<PVector> t = ord.get(gen);
  t.add(new PVector(a,b)); 
  int maxGen = gen;
  
  if( b -a >= 0.01)
  {
      maxGen = generaIntervalli( ord, a, a + (b-a)/2, gen+1 );
      generaIntervalli(ord, a + (b-a)/2, b, gen+1);
  } 
  return maxGen;
  
}