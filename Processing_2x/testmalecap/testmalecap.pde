void setup()
{
 size(500,500);
 background(255);
 al = new ArrayList<PVector>(); 
 al.add(new PVector(width*0.5,height*0.5));
  fill(125,30);
  stroke(0,30);
}

ArrayList<PVector> al;

void draw()
{

  if(mousePressed)
  {
  
    PVector act = new PVector(mouseX,mouseY);
    
    PVector prev = al.size() > 0 ? al.get(al.size()-1) : null;
    
    if(prev == null)
    {
      al.add(act); 
    }
      
    else if( abs(act.x-prev.x)>30 || abs(act.y-prev.y)>30 )
    {
      al.add(act);  
      line(prev.x,prev.y,act.x,act.y);  
      
      spawna(act.x,act.y);
      
    }
  } 
  
  else
  {
    al.clear(); 
  }
}

void spawna(float x,float y)
{
 
 ellipseMode(CENTER);
 fill(125,15);
 noStroke();
 for(int i=-50;i<=50;i++)
  for(int j=-50;j<=50;j++)
      if(random(1.0)>0.1)
        continue;
      else
      {
      
        ellipse((int)x+j,(int)y+i,2,2);
      
      }
}
