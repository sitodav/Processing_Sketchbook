void setup()
{
 size(500,500);
 background(0);
 noFill();
 stroke(255,25); 
}

boolean flag;
PVector source = new PVector();

void draw()
{
  fill(0,10);
  //rect(0,0,width,height);
  if(flag)
  {
    ellipseMode(CENTER);
    ellipse(source.x,source.y,10,10);
    
  }
  else
  {
    float interv = source.x+(source.x-pmouseX) - pmouseX;
    float intervY = source.y+(source.y-pmouseY) - pmouseY;
    float intervAlpha = (2.0f*PI) / 100.0;
    if(!mousePressed)
      return;
    
    for(int i=0;i<100;i++)
    {
     
      line(pmouseX + i * (interv/100)+50*cos(i*intervAlpha+t), pmouseY + i * (intervY/100)+50*sin(i*intervAlpha+t), pmouseX + (i+1) * (interv/100)+50*cos((i+1+t)*intervAlpha), pmouseY + (i+1) * (intervY/100)+50*sin((i+1)*intervAlpha+t));
    }
    
    //line(mouseX,mouseY,source.x,source.y);
  }
  t+= 0.1;
}

float t= 0.0f;
 
void mousePressed()
{
  
   if(!flag)
   {
     flag = true;
     source.x = mouseX;
     source.y = mouseY;
   } 
   else
     flag = false;
  System.out.println(flag);   
  
}
