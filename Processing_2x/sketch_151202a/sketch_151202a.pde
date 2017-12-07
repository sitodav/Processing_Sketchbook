void setup()
{
   size(1000,1000,P3D);
   background(0); 
   rectMode(CENTER);
   stroke(0,255,0,255);
   ortho();
}

void draw()
{
    background(0);
    float z = 500;
    float f = 1000.0f;
    pushMatrix();
      fill(255,200);
      translate(width/2,height/2,-1 * z);
      rect(0,0,400,400);
    popMatrix();
    
    float xMouse = mouseX - (width/2);
    float yMouse = mouseY - (height/2);
    
    float xWorld = width/2 + z * (xMouse / f);
    float yWorld = height/2 + z * (yMouse / f);
    
    fill(255);
    pushMatrix();
      translate(xWorld,yWorld,z);
      sphere(30);
    popMatrix();
    
    //System.out.println(xMouse+" "+yMouse);
    
}

void keyPressed()
{
   if(keyCode == UP)
      z+=30; 
}
