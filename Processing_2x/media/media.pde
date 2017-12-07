void setup()
{
  size(500,500);
  background(0);
  fill(255,25,12,80);
  rect(20,30,100,200);
  strokeWeight(2.0);
  stroke(255,23,44);
  line(0,0,width,height);
}

boolean first = true;

PImage immg;

void draw()
{
  /*if(!mousePressed)
    return;
   
  if(first)
  {
    first = false; 
    immg = get(); 
  }
  float sumr = 0;
  float sumg = 0;
  float sumb = 0;
  
  int size = 2;
  
  for(int xs = -size; xs <= size; xs++)
  {
    for(int ys = -size; ys <= size; ys++)
    {
           sumr+= red(immg.get(mouseX+xs,mouseY+ys));
           sumg+= green(immg.get(mouseX+xs,mouseY+ys));
           sumb+= blue(immg.get(mouseX+xs,mouseY+ys));
    }
  }
 
  color media = color(sumr/(float)pow(2*size,2),sumg/(float)pow(2*size,2),sumb/(float)pow(2*size,2));
  for(int xs = -size; xs <= size; xs++)
  {
    for(int ys = -size; ys <= size; ys++)
    {
          set(xs+mouseX,ys+mouseY,media);
    }
  }*/
  
  
}

void media(int xc,int yc)
{
  float sumr = 0;
  float sumg = 0;
  float sumb = 0;
  
  int size = 2;
  
  for(int xs = -size; xs <= size; xs++)
  {
    for(int ys = -size; ys <= size; ys++)
    {
           sumr+= red(immg.get(xc+xs,yc+ys));
           sumg+= green(immg.get(xc+xs,yc+ys));
           sumb+= blue(immg.get(xc+xs,yc+ys));
    }
  }
 
  color media = color(sumr/(float)pow(2*size,2),sumg/(float)pow(2*size,2),sumb/(float)pow(2*size,2));
  for(int xs = -size; xs <= size; xs++)
  {
    for(int ys = -size; ys <= size; ys++)
    {
          set(xs+xc,ys+yc,media);
    }
  }
}

void mousePressed()
{
  immg = get();
  for(int i=0;i<height;i++)
    for(int j = 0;j<width;j++)
      media(j,i);
}
