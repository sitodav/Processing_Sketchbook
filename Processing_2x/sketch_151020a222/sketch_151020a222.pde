void setup()
{
  size(800,800);
  background(0);
  noFill();
  stroke(255);
  
  for(int i=0;i<sizeA;i++)
    all.add(new ArrayList<PVector>());
}

int sizeA = 400;
int sizeToAdd = 10;
ArrayList<ArrayList<PVector>> all = new ArrayList<ArrayList<PVector>>();
int size = 5;
float angle = 0.0f;
int steps = 10;
float verticalOff = 0.0f;

void draw()
{
   fill(0,25);
   rect(0,0,width,height);
   noFill();
   
   if(!mousePressed)
     return;
 
   ArrayList<ArrayList<PVector>> temp = new ArrayList<ArrayList<PVector>>();
   float stepX = width / sizeA;
   float stepY = 50 / sizeA;
   for(int i= 0; i<sizeA; i++)
   {
     ArrayList<PVector> t2 = new ArrayList<PVector>();
     for(int j = 0; j < sizeToAdd; j++)
     {
        PVector toAdd = new PVector(10+(float)i * stepX , verticalOff + ((float)j * 5) );
        t2.add(toAdd);
     }   
     temp.add(t2);
   }
   verticalOff += 60.0;
   verticalOff = verticalOff > height ? 0 : verticalOff;
   addAll(temp);
   drawAll();
    
  
}

void mouseReleased()
{
   clearAll();
   verticalOff = 0 ;
}

void drawAll()
{
   for(ArrayList<PVector> el : all)
    drawSingle(el); 
}

void addAll(ArrayList<ArrayList<PVector>> toAdd)
{
  for(int i=0;i<toAdd.size();i++)
  {
      for(PVector el : toAdd.get(i))
      {
         addSingle(all.get(i),el.x,el.y);
      }
  }
}

void clearAll()
{
   for(ArrayList<PVector> el : all)
     clearSingle(el); 
}

void addSingle(ArrayList<PVector> arr, float x, float y)
{
    arr.add(new PVector(x,y));
}

void drawSingle(ArrayList<PVector> punti)
{
    int a =(int)( (punti.size()-size) + random(5));
    int b =(int)( (punti.size()-size) + random(5));
    if(a<0 || a>= punti.size() || b<0 || b>=punti.size())
      return;
      
    float xa = punti.get(a).x;
    float ya = punti.get(a).y;
    float xb = punti.get(b).x;
    float yb = punti.get(b).y;
    double intX = (xa-xb) / steps;
    double intY = (ya-yb) /steps;
    
    float angleStep = 2*PI / steps;
    for(int i=0;i<steps;i++)
    {
      line( (float)(xa+i*intX + 2*cos(i*angleStep ) ),(float)(ya+i*intY + 2*sin(i*angleStep ) ),(float)(xa+(i+1)*intX + 2*cos((i+1)*angleStep ) ),(float)(ya+(i+1)*intY +2*sin((i+1)*angleStep ) ));
    }
}

void clearSingle(ArrayList<PVector> punti)
{
  punti.clear(); 
}


