void setup()
{
 
   size(900,500);
   background(0);
   stroke(255,5);
   //strokeWeight(20);
}

int last = 0;
float angle = 0.0f;

void draw()
{
    if(mousePressed)
    {
      for(int h=0;h<10;h++)
      {
            
            float size = random(50);
            PVector v = new PVector( mouseX + size * cos( 2*PI*0.1*h ) , mouseY + size * sin( 2*PI*0.1*h ) );
             
            al.add(v);
            
              if(al.size() >= 2)
              {
                
                
                
                for(int i=al.size()-2;i<al.size()-1;i++)
                {
                   PVector a = al.get(i);
                   PVector b = al.get(i+1);
                   
                   double angle = atan2( b.y-a.y, b.x-a.x );
                   
                   
                   
                   for(int k=-5;k<5;k++)
                   { 
                     pushMatrix(); 
                     translate( a.x + k*r*cos((float)angle+0.5*PI)  ,a.y + k*r*sin((float)angle+0.5*PI)  );
                     for(int f=0;f<10;f++)
                     {
                       line(f * (b.x-a.x) * 0.1 , f * 0.1*(b.y-a.y) ,(f+1) * (b.x-a.x) * 0.1 , (f+1) * 0.1*(b.y-a.y) );
                     }
                     popMatrix();  
                   }
                   
                   
                    
                }
              }  
          
          
          
          
        }  
    
    }
  
}

float r = 5;

ArrayList<PVector> al = new ArrayList<PVector>();

void mouseReleased()
{
  al.clear(); 
}




