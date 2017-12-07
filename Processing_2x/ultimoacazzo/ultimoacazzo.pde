void setup()
{
   size(1000,1000);
   background(0); 
   strokeWeight(2.0);
   
}

int size = 50;
ArrayList<PVector> listaPunti = new ArrayList<PVector>();
float angle = 0.0f;


void draw()
{
  
   if(!mousePressed)
      return;
   pushMatrix();
   translate(mouseX,mouseY);
   rotate(angle);
   angle += 0.1f;
   spawn(0,0,size,1);
   spawn(0,0,size,2);
   spawn(0,0,size,3);
   spawn(0,0,size,4);   
   popMatrix();
}

void spawn(int x,int y,int dist,int dir)
{
   stroke(255, 50 * ((float)dist/size) );
   point(x,y);
   
   if(dist == 0)
     return;
   int nx = x, ny = y;
   
   switch(dir)
   {
      case 1 : nx = x - 2; ny = y + (int)(-4 + Math.random() * 2 * 4); break;
      case 2 : ny = y - 2; nx = x + (int)(-4 + Math.random() * 2 * 4); break;
      case 3 : nx = x + 2; ny = y + (int)(-4 + Math.random() * 2 * 4); break;
      case 4 : ny = y + 2; nx = x + (int)(-4 + Math.random() * 2 * 4); break; 
   }
   spawn(nx,ny,dist-1,dir);
}
