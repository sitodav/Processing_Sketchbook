void setup()
{
  size(1000,1000);
  background(0);
}


void draw()
{
  if(!mousePressed)
   return;
  
  float offX = mouseX - pmouseX;
  float offY = mouseY - pmouseY;
 
  PVector vett = new PVector(offX,offY);

  pushMatrix();
    translate(pmouseX,pmouseY);
    rotate(- PI * 0.5f );
    line(0,0,vett.x,vett.y);
    line(0,0,-vett.x,-vett.y);
  popMatrix();
   fill(255,25);
    pushMatrix();
      translate(pmouseX,pmouseY);
      translate(0.5 * vett.x,0.5 * vett.y);
      rotate(atan2(-vett.y,-vett.x));
      rectMode(CENTER);
      rect(0,0,abs(vett.x)+abs(vett.y),abs(vett.x)+abs(vett.y),10); 
    
  popMatrix();
   
}
