void setup()
{
   size(500,500);
   background(0); 
   rectMode(CENTER);
}


int incrementoRotazione = 100;
float porzAngle = 3.14 / incrementoRotazione;
ArrayList<PVector> lPunti = new ArrayList<PVector>();
int size = 50;

void draw()
{
   if(!mousePressed)
     return;

   
    
  for(int i=0;i<incrementoRotazione;i++)
  {
   
     
      int offX = (int) (Math.random() * size);
      int offY = (int)(Math.random()*offX);
      pushMatrix();
        translate(mouseX,mouseY);
        rotate(i*porzAngle);
        pushMatrix();
          translate(offX,offY);
          System.out.println( red(get(0,0)) );
          noStroke();
          fill(255, (int)(255 * ((float)offX / width)));  
          rect(0,0,3,3);
        popMatrix();
        rotate(3.14);
        translate(offX,offY);
        rect(0,0,3,3); 
      popMatrix();
     
    
  }
  
  
}


  
