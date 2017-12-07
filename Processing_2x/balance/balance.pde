void setup()
{
  size(800,800,P3D);
  background(0); 
  lvl = new Livello(new PVector[]{ new PVector(0,0,-500), new PVector(width,0,-500), new PVector(width,height,-500), new PVector(0,height,-500) },new Palla(new PVector(0,0,70),30));
 
}

void draw()
{
  background(0);
  lvl.disegnaLvl(10,10 );
  
  
}


void mousePressed()
{
      startX = mouseX;
      startY = mouseY; 
      

}

void mouseDragged()
{
     
     float xmov =  0.003 * (mouseX-pmouseX);//(mouseX-startX) / width;
     float ymov = 0.003 * (mouseY-pmouseY);//(mouseY-startY) / height;  
     lvl.setYRot(lvl.getRots()[1]+xmov);
     lvl.setXRot(lvl.getRots()[0]-ymov);
}


float startX, startY;
Livello lvl = null;


class Livello
{
  Palla sfera = null;
  PVector a,b,c,d;
  float alpha = 0.0f;
  final float STARTING_X_ROT = 1; 
  float XROT, YROT;
  final float MAX_XROT = 0.5;
  final float MAX_YROT = 0.5;
  float xAcc = 1;
  float yAcc = 1;
  boolean firstDraw = true;
  boolean[][] tempMatCelle ;
  
  public float[] getRots()
  {
    return new float[]{XROT,YROT};
  }
  public void setXRot(float newV)
  {
      if(newV < -MAX_XROT || newV > MAX_XROT)
        return;
      XROT = newV;
  }
  public void setYRot(float newV)
  {
    if(newV < -MAX_YROT || newV > MAX_YROT)
        return;
      YROT = newV; 
  }
  
  public Livello(PVector[] ps,Palla sfera)
  {
   this.a = ps[0]; this.b = ps[1]; this.c = ps[2]; this.d = ps[3];
   this.sfera = sfera;
   
  } 
  void disegnaLvl(int nX,int nY)
  {
     if(firstDraw)
     {
        firstDraw = false; 
        tempMatCelle = new boolean[nY][nX];
        for(int i=0;i<nY;i++)
          for(int j=0;j<nX;j++)
          {
            tempMatCelle[i][j] = false;
          }
     }
     if( abs(XROT) < 0.2 )
     {
        xAcc = 1; 
        System.out.println("azzero accell x");
     }
     else
     {
        xAcc+=0.1; 
        
     }
     if( abs(YROT) < 0.2 )
     {
        yAcc = 1; 
        System.out.println("azzero accell y");
     }
     else
     {
       yAcc+=0.1; 
       System.out.println("xAcc:"+xAcc+ " yAcc:"+yAcc);
     }
     
     pushMatrix();
       translate((b.x-a.x)/2,(c.y-b.y)/2,a.z);
       rotateX(STARTING_X_ROT + XROT);
       rotateY(YROT);
       rotateZ(alpha);
       //alpha+=.01;
       noFill();
       stroke(255);
       float stpX = (b.x-a.x) / nX;
       float stpY = (c.y-b.y) / nY;
       
       sfera.updateConVel( new PVector(yAcc * 3*YROT / MAX_YROT, xAcc * (-3* XROT) / MAX_XROT,0) );
       
       int cellXIndex =(int) (sfera.getPos().x / stpX) + (int)(nX/2);
       int cellYIndex =(int) (sfera.getPos().y / stpY) + (int)(nY/2);
       //System.out.println("---------------------"+cellXIndex+" "+cellYIndex);
       if(cellXIndex > 0 && cellXIndex < nX && cellYIndex > 0 && cellYIndex < nY)
         tempMatCelle[cellYIndex][cellXIndex] = true;
       else
         exit();
       
       sfera.disegnami();
       
       
       
       for(int i=0;i<nX;i++)
       {
          //rect(-width/2 + j*stpX,-height/2,stpX,stpY);
           //rect(-width/2 + j*stpX,height/2 - stpY,stpX,stpY); 
          /*pushMatrix();
            translate(-(b.x-a.x)/2 + j*stpX,-(c.y-b.y)/2,0);
            box(stpX);
          popMatrix();
          pushMatrix();
           translate(-(b.x-a.x)/2 + j*stpX,(c.y-b.y)/2 - stpX,0);
           box(stpX);
          popMatrix();*/
          
           for(int j=0;j<nY;j++)
           {
              //rect(-width/2,-height/2 + j*stpY,stpX,stpY);
              //rect(width/2 -stpX,-height/2 + j*stpY,stpX,stpY); 
             pushMatrix();
                float tX = -(b.x-a.x)/2 + i * stpX;
                float tY = -(c.y-b.y)/2 + j*stpY;
                translate(tX,tY,0);

                
                
                if(tempMatCelle[j][i] == true)
                {
                  fill(120,0,0,random(255));
                }
                else
                  fill(120,50,255,200);
                  
                stroke(0,0,0,255);
                box(stpY);
              popMatrix();
              /*pushMatrix();
               translate((b.x-a.x)/2 -stpX,-(c.y-b.y)/2 + j*stpY,0);
               box(stpY);
              popMatrix();*/
           }
       }
      
       //sfera.updateConVel(new PVector(2,3,4));
      
       
     popMatrix();
  }
}

class Palla
{
   
 PVector pos; 
 float size;
 public Palla(PVector p,float size)
 {
   pos = p; this.size = size;
 } 
 
 public void disegnami()
 {
    pushMatrix();
    translate(pos.x,pos.y,pos.z);
    fill(255,0,0,200);
    noStroke();
    sphere(size); 
    popMatrix();
 }
 public void updateConVel(PVector v)
 {
     pos = new PVector(pos.x+v.x,pos.y+v.y,pos.z+v.z);
 }
 
 public PVector getPos()
 {
    return pos; 
 }
}
