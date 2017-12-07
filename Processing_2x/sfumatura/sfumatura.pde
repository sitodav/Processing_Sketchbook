void setup(){
 size(700,700);
 background(0); 
}



float angle2 = 0.0f;

void draw()
{
  
  float nx = mouseX;
  float ny = mouseY;
  
  
  
  float offX = nx-pmouseX;
  float offY = ny-pmouseY;
  
  
  float angle = atan2(offY,offX);
  
  if(!mousePressed)
    return;
    
  ellipseMode(CENTER);
  float incrementoOffset = 3.5;
  float size = 20;
  
  stroke(255, 255 * ((abs(offX) + abs(offY))/300));
  pushMatrix();
    translate(mouseX,mouseY);
    
  
    rotate( angle );
    
    float porz = 100 / 50;
    float porzAngle = 6.28 / 50;
    angle2 = 0.0f;
    for(int i =0 ; i< size; i++)
    {
      
      angle2 += incrementoOffset ;
      rotate(angle2 * 0.001);   
        
      line(sin(angle2 *  0.001) * i * porz, 100 * sin(i * porzAngle),(i+1) * porz, 100 * sin((i+1) * porzAngle));
    }
  
  popMatrix();
  
 
}
