void setup()
{
   size(800,800,P3D); 
}

float actualAngle = 0;
float nextAngle = 0;
float actualSpace = 0;
float nextSpace = 0;

float size = 200;
float z = -100;
void draw()
{
  z+=1;
  background(255);
  //fill(255,100);
  //rectMode(CORNER);
  //rect(-1,-1,width+1,height+1);
  noFill();
  stroke(0);
  rectMode(CENTER);
  
  pushMatrix();
  
  translate(width/2,height/2,z);
  actualAngle = actualAngle + 0.1 * (nextAngle -actualAngle);
  rotate(actualAngle);
  
  actualSpace = actualSpace + 0.05 * (nextSpace -actualSpace);
  for(int i=-1;i<=1;i++)
  {
     for(int j=-1;j<=1;j++)
     {
         
         pushMatrix();
           translate(i* size/3 - (i<0 ? actualSpace : i==0 ? 0 : -actualSpace ), j * size/3 - (j<0 ? actualSpace : j==0 ? 0 : -actualSpace ));
           rect(0,0,size/3,size/3);
         popMatrix();
       
     }
  }
  popMatrix();
  
}

void keyPressed()
{
   switch(keyCode)
   {
      case UP: break;
      case LEFT: nextAngle -= PI/2; nextSpace = size/6; actualSpace = 0; break;
      case RIGHT:  nextAngle += PI/2; nextSpace = size/6; actualSpace = 0; break;
      case DOWN: break; 
   }
}