void setup()
{
  size(600,600); 
  background(0);
  
  
}

int w = 800;
int h = 800;

int cont = 0;
int nStep2 = 4;
void draw()
{
    background(0);
    noFill();
    stroke(0,255,0);
    
    float nStep = 32;
    
    float stepW = width/nStep;
    float stepY = height/nStep;
    
    float stepW2 = width/(float)nStep2;
    float stepH2 = height/(float)nStep2;
    
    ellipseMode(CENTER);
    
    for(int i=0;i<nStep;i++)
    {
       for(int j=0;j<nStep;j++)
       {
          rect(i*stepW, j* stepY, stepW, stepY);
       }
    }
    
    noStroke();
    fill(255,0,0);
    for(int i=0;i<nStep2;i++)
    {
       for(int j=0;j<nStep2;j++)
       {
          ellipse(i*stepW2 + 0.5f *stepW2 - 10, j* stepH2+ stepH2*0.5f - 10, 10,10);
       }
    }
    cont++;
    if(cont % 100 == 0)
    {
       System.out.println("DIVIDO");
       nStep2 *=2;
    }
    
    
}
