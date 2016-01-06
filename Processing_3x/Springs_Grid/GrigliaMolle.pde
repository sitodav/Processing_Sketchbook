
class Molla
{
    PVector chiodo;
    float restLenMolla = 200;
    float kElast = 0.01;
   
   
   
   void muoviChiodo(PVector nuovaPosChiodo)
   {
      chiodo = nuovaPosChiodo; 
   }
     
   Molla(PVector chiodo,float kElast,float restLenMolla)
   {
      this.chiodo = chiodo;
      this.kElast = kElast;
      this.restLenMolla = restLenMolla;
   }
   
   public PVector computeSpringForce(PVector where)
   {    
      PVector molla = new PVector( where.x - chiodo.x , where.y - chiodo.y );
      float lenMolla = sqrt(  molla.x * molla.x + molla.y * molla.y   );
      
      molla.x /= lenMolla;
      molla.y /= lenMolla;
      
      float offMolla = -lenMolla + restLenMolla;
      return new PVector( offMolla * kElast * molla.x , offMolla * kElast * molla.y );  
   }
   
   public void disegna(PVector where)
   {
     
       stroke(0);
       line(chiodo.x,chiodo.y,where.x,where.y);
       ellipseMode(CENTER);
       noStroke();
       fill(0,255,0);
       ellipse(chiodo.x,chiodo.y,20,20);
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
      this.vel.x += this.acc.x;
      this.vel.y += this.acc.y;
      this.muovi(new PVector(this.pos.x + this.vel.x, this.pos.y + this.vel.y));
      
      
   }
   
   
   
   //we use this routine to reset the acceleration
   public void clearAcc()
   {
      acc.mult(0); 
      vel.limit(5);
   }
   public void disegna()
   {
      pushMatrix();
        translate(pos.x,pos.y);
        fill(0);
        noStroke(); //<>// //<>// //<>//
        ellipse(0,0,radius,radius);
        //stroke(0,0,255,125);
        //strokeWeight(3.0);
        //line(0,0,vel.x*50,vel.y*50);
        
   
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
int nMoversX = 15;
int nMoversY = 15;
//ArrayList<Molla> molle;

void setup()
{
  size(600,600,P2D);
  //molle = new ArrayList<Molla>();
  movers = new MoverClass[nMoversY][nMoversX];
  float yOff = (float)(height - 40) / nMoversY;
  float xOff = (float)(width - 40) / nMoversX;
  
  for(int i=0;i<nMoversY;i++)
  {     
     for(int j=0;j<nMoversX;j++)
     {
        movers[i][j] = new MoverClass(new PVector(20 + j * xOff + 0.5f * xOff, 20 + i*yOff + 0.5f * yOff),5,30);  
        
     }
  }
  
  
  for(int j=0;j<nMoversX;j++)
  {
     movers[0][j].addMollaPerMover(new Molla(new PVector(movers[0][j].pos.x, movers[0][j].pos.y - 5),0.1,5));
     movers[nMoversY-1][j].addMollaPerMover(new Molla(new PVector(movers[nMoversY-1][j].pos.x, movers[nMoversY-1][j].pos.y - 5),3,5));
     
  }
  
  for(int i=0;i<nMoversY;i++)
  {
     movers[i][0].addMollaPerMover(new Molla(new PVector(movers[i][0].pos.x - 5 , movers[i][0].pos.y),0.1,5));
     movers[i][nMoversX-1].addMollaPerMover(new Molla(new PVector(movers[i][nMoversX-1].pos.x + 5 , movers[i][nMoversX-1].pos.y), 3,5));
  }
  
  for(int i=0;i<nMoversY;i++)
  {
     for(int j=0;j<nMoversX;j++)
     {
        Molla mollaTraMovers = null;
        mollaTraMovers = new Molla( movers[i][j].pos, 0.1,5 );
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
  //mover = new MoverClass(new PVector(width/2+100,height/2+100),5,100);
  smooth();
  
}

void draw()
{
    if(movers == null)
      return; //<>// //<>//
    
    background(255);
    
    for(MoverClass[] mover : movers)
      for(MoverClass mover2 : mover) //<>//
        mover2.clearAcc();
    
    

    
    //per ciascun mover, calcolo la forza delle molle che gli sono attaccate, lo muovo (quindi si aggiornano le molle di cui è chiodo)
    //e quindi cambieranno anche i movers associati alle molle di cui è chiodo
    for(MoverClass[] mover : movers)
    {
      for(MoverClass mover2 : mover)
      {
         for(Molla molla : mover2.mollePerMover)
         {
              PVector springForce = molla.computeSpringForce((mover2.pos));
              mover2.applyForce(springForce);  
              
              molla.disegna(mover2.pos);
         } 
         
         mover2.update();
         mover2.disegna();
      }
    }
    
    /*for(MoverClass[] mover : movers)
      for(MoverClass mover2 : mover)
      {
        mover2.update();
        mover2.disegna();
      }
    */
     
    
    stroke(0);
    
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