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
  stroke(255,55);
  pushMatrix();
    translate(pmouseX,pmouseY);
    rotate(- PI * 0.5f );
    line(0,0,vett.x,vett.y);
    line(0,0,-vett.x,-vett.y);
    
    pushMatrix();
      translate(vett.x,vett.y);
      rotate(PI * 0.5f);
      //line(0,0,vett.x,vett.y);
    //popMatrix();
    
    //pushMatrix();
      //translate(-vett.x,-vett.y);
      //rotate(PI * 0.5f);
      //line(0,0,vett.x,vett.y);
      fill(255,25);
      beginShape(QUADS);
      vertex(0,0);
      vertex(0,-2*vett.y);
      vertex(vett.x,-2*vett.y);
      
      vertex(vett.x,vett.y);
      endShape(CLOSE);
    popMatrix();
  popMatrix();
   
}
