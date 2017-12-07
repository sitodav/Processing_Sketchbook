
HashMap<Integer,Boolean> keyCodeEvents = new HashMap<Integer,Boolean>();
HashMap<String,Boolean> keyEvents = new HashMap<String, Boolean> ();


void setup()
{
    size(1400,800,P3D);
    background(0);
    rectMode(CENTER);
    pl = new PVector(width/2,100 +height/2,500);
    mv = new PVector(0,0,0);
}

PVector pl = null;
int spintaGravity = 0;
float angleX = 0.0f, angleY = 0.0f;
float floorWidth = 900, floorHeight=20000;
int celleFloor = 20;
float spost = 20;
 
/*
void mouseMoved()
{
   angleY = 0.3*2*PI* (mouseX - width/2) /  (float)(width/2);
   angleX = 0.3*2*PI * (mouseY - height/2) / (float)(height/2);
}*/

PVector mv;

void draw()
{  background(0);
   keyBuffering();
   checkGravity();
   pushMatrix();
    translate(pl.x,pl.y,pl.z);
    
     
    
    
   pushMatrix();
     //rotateX(-PI*0.5);
     rotateX(angleX);
     rotateY(angleY);
     
     translate(-mv.x,mv.y,-mv.z);
     
     //rotateX(angleX);
     fill(255);
     //rect(0,0,400,2000);
     disegnaLivello();
     
     
     
   popMatrix();
   
   popMatrix();
}

void disegnaLivello()
{
  float xOff = floorWidth / celleFloor;
  float yOff = floorHeight / celleFloor;
  noFill();
  stroke(0,255,0);
  for(int i = -(int)(celleFloor * 0.5); i<(int)( celleFloor * 0.5); i++)
  {
     
     for(int j= - (int)(celleFloor * 0.5); j< (int)(celleFloor * 0.5); j++)
     {
          //rect(j* xOff + xOff*0.5, i*yOff + yOff * 0.5, xOff,yOff);   
         beginShape();
            vertex(j*xOff,0,i*yOff);
            vertex((j+1)*xOff, 0 ,i*yOff);
            vertex((j+1)*xOff,0,(j+1)*yOff);
            
            //vertex(j*xOff,0,(i+1)*yOff);
            
         endShape(); 
     } 
  }
  
}


void keyBuffering()
{
 
   float t = spost * cos(angleY);
   float t2 = spost * cos(0.5*PI - angleY);
   float t3 = spost * cos(PI*0.5 - angleY);
   float t4 = spost * cos(angleY);
  
    System.out.println(keyEvents.size());
    
    for(Integer tKeyCode : keyCodeEvents.keySet() )
    {   
          if( (int)tKeyCode == UP)
          {
            angleX = angleX < (PI/5.0f) ? angleX + 0.05 : angleX ;
            
          }
          if((int)tKeyCode==DOWN)
          {
            angleX = angleX > -(PI/5.0f) ? angleX - 0.05 : angleX ;
          }
          if((int)tKeyCode==LEFT)
          {
            angleY -= 0.1;
          }
          if((int)tKeyCode==RIGHT)
          {
            angleY += 0.1;
          }
          
          
    }      
        
    for(String tKeyStr : keyEvents.keySet() )
    {    
            char tKey = tKeyStr.charAt(0);
            if(tKey== 'w')
            { 
              mv.z -= t; mv.x +=t2; 
            }
            if(tKey== 's')
            { 
              mv.z += t; mv.x -=t2; 
            }
            if(tKey== 'a')
            { 
              mv.z -= t3; mv.x -=t4; 
            }
            if(tKey== 'd')
            { 
              mv.z += t3; mv.x +=t4; 
            }
            if(tKey == ' ')
            {
              if(mv.y == 0 )
              {
                mv.y = 1;
                spintaGravity = 10;
              }
            }   
   }  
        
        
  
}


void checkGravity()
{
    mv.y += spintaGravity;
    spintaGravity--;
    if(mv.y < 1)
    {
       spintaGravity = 0;
      mv.y = 0; 
    }
}
  

void keyPressed()
{
      if(key==CODED)
        keyCodeEvents.put(keyCode,true);
      else
        keyEvents.put(key+"",true);    
}


void keyReleased()
{
      if(key==CODED)
        keyCodeEvents.remove(keyCode);
      else
        keyEvents.remove(key+"");    
}


