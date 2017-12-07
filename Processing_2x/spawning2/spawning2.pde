void setup()
{
  
  size(800,800);
  background(0);
  strokeWeight(2.5);
 // stroke(255);
}


ArrayList<PVector> listaPunti = new ArrayList<PVector>();



boolean flag = true;
int spost = 10;
int dist = 255;

void draw()
{
  if(!mousePressed)
    return;
  
  
  avvia();
  stoppa(); 
  
}


void avvia()
{
 
  if(flag == true)
 {
    flag = false;
    spawn(mouseX,mouseY,dist);
 } 

 
}

void stoppa()
{ 
  flag = true; 
  avviaDisegno();
  listaPunti.clear();
}

void spawn(int x,int y,int dist)
{
    listaPunti.add(new PVector((float)x,(float)y));
    if(dist<=0)
      return;
    int nx = -spost + (int)(Math.random() * (2 * spost + 1));
    int ny = -spost + (int)(Math.random() * (2 * spost + 1));
    spawn(x+nx,y+ny,dist-1);
}


void avviaDisegno()
{
  int i = 0;
  for(PVector el : listaPunti)
  { i++;
    stroke( 255, 100-i );
    point((int)el.x,(int)el.y);  
  } 
  
}




