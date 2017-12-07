

class Molla
{
    PVector chiodo;
    float restLenMolla;
    float kElast ;
    boolean kElastCentralizzata;
   
   
   
   void muoviChiodo(PVector nuovaPosChiodo)
   {
      chiodo = nuovaPosChiodo; 
   }
   
   Molla(PVector chiodo,float restLenMolla) // kElastCentralizzata
   {
      this.chiodo = chiodo;
      this.restLenMolla = restLenMolla;
      kElastCentralizzata = true;
   }
     
   Molla(PVector chiodo,float kElast,float restLenMolla)
   {
      this.chiodo = chiodo;
      this.kElast = kElast;
      this.restLenMolla = restLenMolla;
   }
   
   public PVector computeSpringForce(PVector where)
   {    
      float kElast = kElastCentralizzata ? kElastMolleBordi : this.kElast ;
      PVector molla = new PVector( where.x - chiodo.x , where.y - chiodo.y );
      float lenMolla = sqrt(  molla.x * molla.x + molla.y * molla.y   );
      
      molla.x /= lenMolla;
      molla.y /= lenMolla;
      
      float offMolla = -lenMolla + restLenMolla;
      return new PVector( offMolla * kElast * molla.x , offMolla * kElast * molla.y );  
   }
   
   public void disegna(PVector where)
   {
     
       float estens = sqrt(pow(where.x - chiodo.x,2)+pow(where.y-chiodo.y,2));
       float str =(255 * estens/50.0f);
       stroke(str,str);
       line(chiodo.x,chiodo.y,where.x,where.y);
       /*ellipseMode(CENTER);
       noStroke();
       fill(0,255,0);
       ellipse(chiodo.x,chiodo.y,20,20);*/
       /*pushMatrix();
       stroke(0);
       translate(chiodo.x,chiodo.y);
       textAlign(CENTER);
       text("DRAG ME",0,0-15);
       popMatrix();*/
   }
   
   public boolean isMouseSuChiodo()
   {
      return mouseX > chiodo.x - 40  && mouseX < chiodo.x + 40 && 
       mouseY > chiodo.y - 40  && mouseY < chiodo.y + 40 ;
   }
   
   
}


class MoverClass
{
   public PVector pos;
   public PVector acc;
   public PVector vel;
   public float mass;
   public float radius;
   
   ArrayList<Molla> mollePerMover = new ArrayList<Molla>();
   ArrayList<Molla> chiodiSuMover = new ArrayList<Molla>();
   
   public void addMollaPerMover(Molla molla)
   {
       mollePerMover.add(molla);
   }
   
   public void addChiodoSuMover(Molla molla)
   {
      chiodiSuMover.add(molla);
   }
   
   public void muovi(PVector nuovaPos)
   {
      this.pos = nuovaPos; 
      for(Molla molla : chiodiSuMover)
      {
         molla.chiodo = nuovaPos; 
      }
      
   }
   
   public MoverClass(PVector pos, float mass,float radius)
   {  this.pos = pos; this.mass = mass; this.radius = radius;
      this.acc = new PVector(0,0);
      this.vel = new PVector(0,0);
   }
   
   //applyin force means we have to add a new accel based on the mass
   public void applyForce(PVector f)
   {
       
       this.acc.x += f.x/mass;
       this.acc.y += f.y/mass;
   }
   
   //we update the velocity according to the acceleration, and we update the position according to the velocity
   public void update()
   {
      //attrito
      this.vel.x *= 0.9;
      this.vel.y *= 0.9;
      //aggiorno vel
      this.vel.x += this.acc.x;
      this.vel.y += this.acc.y;
      this.muovi(new PVector(this.pos.x + this.vel.x, this.pos.y + this.vel.y));
      
      
   }
   
   
   
   //we use this routine to reset the acceleration
   public void clearAcc()
   { //<>// //<>// //<>// //<>//
      //acc.mult(0);  //<>// //<>// //<>// //<>//
      acc.x *= 0;
      acc.y *= 0;
      vel.limit(5);
   }
   public void disegna(boolean highlighted)
   {
      pushMatrix();
        translate(pos.x,pos.y);
        float mag = (vel.x * vel.x + vel.y * vel.y);
        float fll = 255*(1-mag*mag/25.0f);
        fill(fll);
        noStroke(); //<>// //<>// //<>// //<>// //<>//
        ellipse(0,0,5,5);
        if(highlighted)
        {   fill(fll,0,0,fll);
            ellipse(0,0,15,15);
        }
        /*stroke(0,0,255,125);
        strokeWeight(3.0);
        line(0,0,vel.x*20,vel.y*20);*/
   
        noStroke();
      popMatrix();
   }
   
   public boolean isMouseSuMover()
   {
      return mouseX > pos.x - radius/2  && mouseX < pos.x + radius/2 && 
       mouseY > pos.y - radius/2  && mouseY < pos.y + radius/2 ;
   }
   
   
   
}


MoverClass[][] movers ;
int nMoversX = 20;
int nMoversY = 20;

float kElastMolleBordi;
float restLenMolleCentralizzata;
//ArrayList<Molla> molle;
int cont ;
int flag ;


void setup()
{
  
  size(600,600,P2D);
  
  //molle = new ArrayList<Molla>();
  movers = new MoverClass[nMoversY][nMoversX];
  int padd = 20;
  float yOff = (float)(height - 2*padd) / nMoversY;
  float xOff = (float)(width - 2*padd) / nMoversX;
  kElastMolleBordi = 1.0;
  restLenMolleCentralizzata = xOff;
  cont = 0;
  flag = 1;
  
  for(int i=0;i<nMoversY;i++)
  {     
     for(int j=0;j<nMoversX;j++)
     {
        movers[i][j] = new MoverClass(new PVector(padd + j * xOff + 0.5f * xOff, padd + i*yOff + 0.5f * yOff),5,30);  
        
     }
  }
  
  
  for(int j=0;j<nMoversX;j++)
  {
     movers[0][j].addMollaPerMover(new Molla(new PVector(movers[0][j].pos.x, movers[0][j].pos.y - 5),restLenMolleCentralizzata));
     movers[nMoversY-1][j].addMollaPerMover(new Molla(new PVector(movers[nMoversY-1][j].pos.x, movers[nMoversY-1][j].pos.y - 5),restLenMolleCentralizzata));
     
  }
  
  for(int i=0;i<nMoversY;i++)
  {
     movers[i][0].addMollaPerMover(new Molla(new PVector(movers[i][0].pos.x - 5 , movers[i][0].pos.y),restLenMolleCentralizzata));
     movers[i][nMoversX-1].addMollaPerMover(new Molla(new PVector(movers[i][nMoversX-1].pos.x + 5 , movers[i][nMoversX-1].pos.y), restLenMolleCentralizzata));
  }
  
  for(int i=0;i<nMoversY;i++)
  {
     for(int j=0;j<nMoversX;j++)
     {
        Molla mollaTraMovers = null;
        mollaTraMovers = new Molla( movers[i][j].pos, 0.1/*1.0*((i+j)/((float)(nMoversX + nMoversY)))*/,5 );
        movers[i][j].addChiodoSuMover(mollaTraMovers);
        
        if(j <nMoversX - 1)
        {   
           movers[i][j+1].addMollaPerMover(mollaTraMovers);
           if(i< nMoversY-1)
              movers[i+1][j+1].addMollaPerMover(mollaTraMovers);
           if(i > 0)
              movers[i-1][j+1].addMollaPerMover(mollaTraMovers);
        }
        
        if(j > 0)
        {   
           movers[i][j-1].addMollaPerMover(mollaTraMovers);
           if(i< nMoversY-1)
              movers[i+1][j-1].addMollaPerMover(mollaTraMovers);
           if(i > 0)
              movers[i-1][j-1].addMollaPerMover(mollaTraMovers);
        }
        if(i > 0)
          movers[i-1][j].addMollaPerMover(mollaTraMovers);
        if(i< nMoversY-1)
          movers[i+1][j].addMollaPerMover(mollaTraMovers);
     }
  }
  
  
  
  
  
  
  
  background(255);
  //mover = new MoverClass(new PVector(width/2+100,height/2+100),5,100); //<>// //<>//
  smooth(); //<>// //<>// //<>// //<>//
   //<>// //<>//
}



void draw()
{
    
      
    if(movers == null) //<>//
      return; //<>// //<>//
    
    //background(255);
    fill(255,10);
    rect(0,0,width,height);
    
    for(MoverClass[] mover : movers)
      for(MoverClass mover2 : mover)
        mover2.clearAcc();
    
    
    if(mousePressed && mouseButton == LEFT && movers != null)
    {
      
       int xMover = (int)((mouseX/(float)width) * (nMoversX-1));
       int yMover = (int)((mouseY/(float)height) * (nMoversY-1));
       //System.out.println(xMover+" "+yMover);
       int numElemX = nMoversX / 5;
       int numElemY = nMoversY / 5;
       if(!(xMover < numElemX || xMover > nMoversX-numElemX || yMover < numElemY || yMover > nMoversY-numElemY))
       {
         for(int i=-numElemX;i<=numElemX;i++)
         {
            for(int j=-numElemY;j<=numElemY;j++)
            {  
               if(abs(i)+abs(j) > 3)
                 continue;
               PVector f = new PVector(mouseX - movers[yMover+i][xMover+j].pos.x,mouseY-movers[yMover+i][xMover+j].pos.y);
               //System.out.println(f.x+" "+f.y);
               movers[yMover+i][xMover+j].applyForce(new PVector(f.x * 0.8, f.y * 0.8));
            }
         }
       }
    }

    
    /******************************************************FORZA AGGIUNTIVA1*/
   /* int ti = nMoversY-1,tj = nMoversX-1;
    ArrayList<PVector> ps = new ArrayList<PVector>();
    ps.add(new PVector(0,0));
    while(ti>0 && tj>0) //<>//
    {
      float f = random(0,1);
      PVector l = ps.get(ps.size()-1);
      if( ti==0 || (f>.8 && tj!=0) )

      {
          ps.add(new PVector( l.x+1,l.y ));
          tj--;
      }
      else
      {
        ps.add(new PVector( l.x,l.y+1 ));
        ti--;
      }
       //<>//
      
    }
    
    for(PVector el: ps)
    {
       movers[(int)el.y][(int)el.x].applyForce(new PVector(random(-10,10),random(-10,10))); 
       //movers[(int)el.y][(int)el.x].disegna(true);
    }
    */ 
    
    
    /***********************************************FORZA AGGIUNTIVA2***/
    /* 
    cont += (flag);
      
    if(cont == 20 || cont ==0)
    {
        flag *= -1;
    }
    if(cont % 5 == 0)
    {
       kElastMolleBordi += 2*flag ;
       //System.out.println(kElastMolleBordi);
    }
    */
    

    
    //per ciascun mover, calcolo la forza delle molle che gli sono attaccate, lo muovo (quindi si aggiornano le molle di cui Ã¨ chiodo)
    //e quindi cambieranno anche i movers associati alle molle di cui Ã¨ chiodo
    
    for(MoverClass[] mover : movers)
    {

      for(MoverClass mover2 : mover)
      {
         
         for(Molla molla : mover2.mollePerMover)
         {
              PVector springForce = molla.computeSpringForce((mover2.pos));
              mover2.applyForce(springForce);  
              //PVector t = new PVector(mover2.pos.x - width/2.0f, mover2.pos.y - height/2.0f);
              //mover2.applyForce(t.mult(0.005));
              
              molla.disegna(mover2.pos);
         } 
         
         mover2.update();
         mover2.disegna(false); //<>//
        
      }
    }
    
    
    
    
         
     
    
    stroke(0);
    
}




void keyPressed()
{
   if(keyCode == UP)
   {
      if(kElastMolleBordi > 8.0)
        return;
      kElastMolleBordi+=1.2;
   }
   else if(keyCode == DOWN)
   {
      if(kElastMolleBordi < - 0.5)
        return;
      kElastMolleBordi -= 1.2; 
   }
   else if(key == 'k')
   {
      for(Molla molla : movers[(int)random(0,9)][(int)random(0,9)].chiodiSuMover)
      {
         molla.kElast *=2;
      }
   }
   System.out.println(kElastMolleBordi);
}



/***routine per image processing ***********************************************/

void rgb2Gray(PImage img) //used to store in each of the three channels of a PImage, the same value obtained as the mean of the 3 original channels (R+G+B)/3
{
  img.loadPixels();
  for(int i=0;i<img.width*img.height;i++)
   {
      int iR = i / img.width;
      int iC = i % img.width;
      color c= img.get(iC,iR);
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      float v = 0.3333 * (red+green+blue);
      img.pixels[i] = color(v,v,v);
   }
   img.updatePixels();
}
 







void edgeDetectionGradiente(PImage img, PVector sizeKernel, float[] kernelX, float[] kernelY, float sogliaEdge)
{
    
    PImage xDer = img.copy();
    PImage yDer = img.copy();
    convoluzione(xDer,sizeKernel,kernelX,sogliaEdge);
    convoluzione(yDer,sizeKernel,kernelY,sogliaEdge);
    
    img.loadPixels();
    for(int i=(int)(sizeKernel.y /2.0); i<= img.height - (sizeKernel.y /2.0);i++)
     {
         for(int j=(int)(sizeKernel.x /2.0); j<=  img.width - (int)(sizeKernel.x /2.0);j++) 
         {
               float t = red(xDer.get(j,i));  
               float t2 = red(yDer.get(j,i));
               
               float vToSet = sqrt( t*t + t2*t2);
               vToSet = abs(vToSet) > sogliaEdge ? abs(vToSet) : .0 ;
               img.pixels[i*img.width + j] = color(vToSet,vToSet,vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
              
         }
     }
     img.updatePixels();
    
}

void convoluzione(PImage img, PVector sizeKernel,float[] kernel,float soglia)
{
   img.loadPixels();
   
   for(int i=(int)(sizeKernel.y /2.0); i<= img.height - (sizeKernel.y /2.0);i++)
   {
       for(int j=(int)(sizeKernel.x /2.0); j<=  img.width - (int)(sizeKernel.x /2.0);j++) 
       {
             float t = 0;  
             
             for(int ii= - (int)(sizeKernel.y /2.0) ;ii<= (int)(sizeKernel.y /2.0);ii++)
             {
                for(int jj=- (int)(sizeKernel.x /2.0);jj<=(int)(sizeKernel.x /2.0);jj++)
                {
                    t += red(img.get(j+jj + (int)(sizeKernel.x /2.0) , i+ii + (int)(sizeKernel.y /2.0))) * kernel[((ii+ (int)(sizeKernel.y /2.0))*(int)sizeKernel.x+ jj + (int)(sizeKernel.x /2.0)  )];
                    
                }
             }
             float vToSet = t; 
             vToSet = abs(vToSet) > soglia ? abs(vToSet) : .0 ;
             img.pixels[i*img.width + j] = color(vToSet,vToSet,vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
            
       }
   }
   img.updatePixels(); //in this way we flush from img.pixels[] to > img
   
}












/*
void mouseDragged()
{
   for(Molla molla : molle)
   {
      if(molla.isMouseSuChiodo())
      {
        molla.muoviChiodo(new PVector(mouseX,mouseY));
        break;
      }
   }
   
   if(mover.isMouseSuMover())
   {
      mover.muovi(new PVector(mouseX,mouseY)); 
   }
   
}

void mouseClicked()
{
    molle.add(new Molla(new PVector(mouseX,mouseY), 0.1,200));
}*/