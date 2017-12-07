void setup()
{
   size(1000,1000); 
   background(0);
   
}

float angle = 0.0f;
int size = 100;


int n = 20;
float porzAngle = 6.28f / n;
float maxAlpha = 100;
float alphaS = 0.01;

void draw()
{
  if(!mousePressed)
    return;
  angle = angle + 0.1f; 
  float x1,y1,x2,y2,x3,y3;
  x2 = size*cos(PI/2); y2= size*sin(PI/2);
  x1 = size * cos(PI + PI/4); y1=size * sin(PI + PI/4);
  x3 = size * cos ( (PI/4) + (3*PI/2)); y3= size * sin( (PI/4)+(3*PI/2) );
  
  
//  pushMatrix();
//  translate(mouseX,mouseY);
//  rotate(angle);
//    fill(255,1);
//    stroke(255,alphaS * maxAlpha);
//    triangle(x1,y1,x2,y2,x3,y3);
//  popMatrix();
  
  
  for(int i=0;i<n;i++)
  {
     pushMatrix();
      translate(mouseX+size*cos(i*porzAngle),mouseY+size*sin(i*porzAngle));
      rotate(angle);
        fill(255,1);
        stroke(255,alphaS * maxAlpha);
        triangle(x1,y1,x2,y2,x3,y3);
    popMatrix();
  } 
  
//  pushMatrix();
//  translate(mouseX+x1,mouseY+y1);
//  rotate(angle);
//    noFill();
//    stroke(255,20);
//    triangle(x1,y1,x2,y2,x3,y3);
//  popMatrix();
//  
//  pushMatrix();
//  translate(mouseX+x2,mouseY+y2);
//  rotate(angle);
//    noFill();
//    stroke(255,20);
//    triangle(x1,y1,x2,y2,x3,y3);
//  popMatrix();
//  
//  pushMatrix();
//  translate(mouseX+x3,mouseY+y3);
//  rotate(angle);
//    noFill();
//    stroke(255,20);
//    triangle(x1,y1,x2,y2,x3,y3);
//  popMatrix();
}

 
