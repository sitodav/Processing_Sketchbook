void setup()
{
  size(600, 600); 
  ellipseMode(CENTER);
  //noLoop();
  stroke(0);
  noFill();

  //background(255);
  //drawCircle(new PVector(width/2,height/2),300);
}

float divisore = 2; 



void draw()
{

  background(255);
  drawCircle(new PVector(width/2, height/2), 300);
}

void drawCircle(PVector c, float diameter)
{
  if (diameter < 3)
    return;
  drawCircle(new PVector(c.x + diameter/divisore, c.y), 0.5 * diameter);
  drawCircle(new PVector(c.x - diameter/divisore, c.y), 0.5* diameter);
  drawCircle(new PVector(c.x, c.y + diameter/divisore), 0.5 * diameter);
  //drawCircle(new PVector(c.x, c.y - diameter/divisore), 0.5 * diameter);

  ellipse(c.x, c.y, diameter, diameter);
}