
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
       pushMatrix();
       stroke(0);
       translate(chiodo.x,chiodo.y);
       textAlign(CENTER);
       text("DRAG ME",0,0-15);
       popMatrix();
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
   
   
   public void muovi(PVector nuovaPos)
   {
      this.pos = nuovaPos; 
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
      this.pos.x += this.vel.x;
      this.pos.y += this.vel.y;
      
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
        noStroke();
        ellipse(0,0,radius,radius);
        stroke(0,0,255,125);
        strokeWeight(3.0);
        line(0,0,vel.x*50,vel.y*50);
        
   
        noStroke();
      popMatrix();
   }
   
   public boolean isMouseSuMover()
   {
      return mouseX > pos.x - radius/2  && mouseX < pos.x + radius/2 && 
       mouseY > pos.y - radius/2  && mouseY < pos.y + radius/2 ;
   }
   
}


MoverClass mover ;
ArrayList<Molla> molle;

void setup()
{
  size(600,600,P2D);
  molle = new ArrayList<Molla>();
  molle.add(new Molla(new PVector(width/2 , 40),0.1 ,50 )) ;
  molle.add(new Molla(new PVector(2*width/3 ,40), 0.1 ,50 )) ;
  
  background(255);
  mover = new MoverClass(new PVector(width/2+100,height/2+100),5,100);
  smooth();
  
}

void draw()
{
    if(mover == null)
      return;
    background(255);
    mover.clearAcc();
    
    //FORZA DA PENDOLO//
    /*
    PVector arm = new PVector( mover.pos.x - chiodo.x , mover.pos.y - chiodo.y ); //<>//
    PVector grav = new PVector(0, mover.mass * 9.2f);
    PVector armRotated = new PVector(  arm.x * cos(-PI/2) + arm.y * sin(-PI/2)  , arm.x * -sin(-PI/2) + arm.y * cos(-PI/2) );
    float dot = ( armRotated.x * grav.x + armRotated.y * grav.y ) / (armRotated.x * armRotated.x + armRotated.y * armRotated.y) ; 
    PVector proiez = new PVector( armRotated.x * dot    ,  armRotated.y * dot    );
    PVector acc = new PVector( proiez.x / mover.mass , proiez.y/mover.mass);
    //pendolo.applyForce(acc);*/


    //FORZA MOLLE sul mover
    for(Molla molla : molle)
    {
      PVector springForce = molla.computeSpringForce((mover.pos));
      mover.applyForce(springForce);  
      molla.disegna(mover.pos);
      
    }
     
    mover.update();
    mover.disegna();
    
    stroke(0);
    
    pushMatrix();
    translate(width/2,height - 50);
    fill(0,255,0);
    text("CLICK ON EMPTY SPOT TO CREATE A NEW SPRING",0,0);
    popMatrix();
}

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
}