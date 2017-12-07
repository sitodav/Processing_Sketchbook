void setup()
{
  size(500,500);
  background(0);
}

void draw()
{
  PVector v = new PVector(mouseX-pmouseX,mouseY-pmouseY);
  float angle = atan2(v.y , v.x);
  System.out.println(angle);
  rectMode(CENTER);
  pushMatrix();
    translate(mouseX,mouseY);
    rotate(angle);
    noStroke();
    fill(255 * ( abs((v.y+v.x))/ (0.01*width) ) ,20);
    rect(0,0,50,50);
    
  popMatrix();
}
