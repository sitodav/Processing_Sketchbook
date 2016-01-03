void setup()
{
  
 size(500,500);
 background(0); 

}


float raggio = 70; 
int n = 10;
int n2= 5;
float porzioneAngolo = 2 * PI / n;
float porzioneRaggio = raggio / n2;
float porzioneAngoloInterno = 2 * PI / n2;

float t = 0.0f;



void draw()
{
 // background(0);
  stroke(255, ((int)t)%100 );
  
   for(int i=0;i<n;i++)
   {
    pushMatrix();
    translate(mouseX,mouseY);
    rotate(i*porzioneAngolo);
    for(int j=0;j<n2;j++)
    {
       line(j * porzioneRaggio,raggio * sin(j*porzioneAngoloInterno+t) ,(j+1)*porzioneRaggio, raggio * sin((j+1)*porzioneAngoloInterno+t));   
    
    }
    popMatrix();
    
    // rotate (.. + t) // rotate (... + cos(t) ) // rotate (... + sin(t))
    //raggio * sin .. raggio *   sin
    //raggio * cos..raggio * sin etc
    
   }
    
   t+=0.05;
  }  
  
  

