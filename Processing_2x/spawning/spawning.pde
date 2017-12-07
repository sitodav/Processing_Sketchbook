void setup()
{
  
  size(800,800);
  background(0);
}

int incrementoPulse = 10;
int size = 20;

void draw()
{
  if(!mousePressed)
  {
    return;
  }
  spawn(mouseX,mouseY,size);
  stroke(255,20);
  
}



void spawn(int prevx,int prevy,int dist)
{
   if(dist==0)
     return;
  int x = (int)(-incrementoPulse+Math.random()*2*incrementoPulse);
  int y = (int)(-incrementoPulse+Math.random()*2*incrementoPulse);
  line(prevx,prevy,prevx+x,prevy+y);
  spawn(prevx+x,prevy+y,dist-1);
  
}
