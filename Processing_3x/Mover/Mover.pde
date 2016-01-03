class MoverClass
{
   public PVector pos;
   public PVector acc;
   public PVector vel;
   public float mass;
   public float radius;
   
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
        translate(vel.x*50,vel.y*50);
        ellipse(0,0,10,10);
        noStroke();
      popMatrix();
   }
}

class CollisionChecker
{
  ArrayList<PVector[]> ostacoli = new ArrayList<PVector[]>();
  public void checkBordiLvl(MoverClass mover)
   {
         //we first check for the 4 basic boundaries of the screen...
         if(mover.pos.x + mover.radius/2 > width)
         {
             mover.vel.x *= -1 ;
             
             mover.pos.x--;
         }
         else if(mover.pos.x - mover.radius/2 < 0){mover.vel.x *= -1;
                
             mover.pos.x ++;
         }
         
         if(mover.pos.y + mover.radius/2 > height)
         {
             mover.vel.y *= -1;
             mover.pos.y --;
             
         }
         else if(mover.pos.y - mover.radius/2 < 0){
             mover.vel.y *= -1; 
             mover.pos.y ++;
         }
         
         //then, for every drawn obstacle...
         for(PVector[] ost : ostacoli)
         {
            PVector a = ost[0], b = ost[1]; 
            
               
               //if the center of the mover is not in the bounding box of the obstacle, we don't want to do anything
               if(!( mover.pos.x > min(a.x,b.x)-mover.radius && mover.pos.x < max(a.x,b.x)+mover.radius && mover.pos.y > min(a.y,b.y)-mover.radius && mover.pos.y < max(a.y,b.y)+mover.radius  ))
                 continue;
               
               
               
               //HERE WE COMPUTE THE COLLISION POINT COORDINATES...
               //*************************************************************************
               //term1 equals the obstacle slope TIMES the X offset of the mover's center from the X of the first extremity of the obstacle MINUS the mover's center Y offset from the Y coordinate of the obstacle first extremity
               double term1 = ((b.y - a.y)/ (b.x - a.x)) * (mover.pos.x-a.x) - (mover.pos.y - a.y);
               //deltaX equals the obstacle slope times the square root of term1 squared minus the radius of the mover squared
               
               double deltaX = cos( atan2(b.y - a.y, b.x - a.x) * sqrt(  (float)(term1 * term1 - mover.radius * mover.radius)    ));
               //if deltaX is NaN, we set its value to a random small number
               System.out.println(atan2(b.y-a.y,b.x-a.x));
               deltaX = Double.isNaN((double)deltaX) ? 0.5 + random(-0.5,0.5): deltaX;
               //the collision point is given below
               PVector coll = new PVector((float)(mover.pos.x - deltaX), (float)(a.y + ((b.y - a.y)/ (b.x - a.x)) * (mover.pos.x - deltaX - a.x)));
               //**************************************************************************
               
               ellipseMode(CENTER);
               
               noStroke();
               
               
               //now that we know the collision point coordinates
               if(sqrt((mover.pos.x - coll.x)*(mover.pos.x - coll.x) + (mover.pos.y - coll.y)*(mover.pos.y - coll.y) ) < mover.radius-40 )
               {
                   //collisione detected,
                   //HERE WE COMPUTE THE NEW DIRECTION AFTER THE COLLISION
                   //*************************************************************************
                   //WE WANT TO DECOMPOSE THE VELOCITY VECTOR IN TWO COMPONENTS VECTOR : THE PARALLEL AND THE ORTHOGONAL VECTOR TO THE OBSTACLE
                   //ONCE WE HAVE THIS TWO VECTORS, WE ROTATE THE ORTHOGONAL COMPONENT, WE OBTAIN THEIR X AND Y COMPONENTS, AND WE SUM THEM TO GET THE FINAL X AND Y VELOCITY COMPONENTS
                   //colseg is the vector representing the obstacle
                   PVector colseg = new PVector(b.x-a.x,b.y-a.y);
                    //<>//
                   
                   strokeWeight(2.0);
                   //we compute the dot product between the velocity of the mover and the obstacle vector
                   float dotT = mover.vel.y * colseg.y + mover.vel.x * colseg.x;
                   //dividing the dot product by the magnitude (not under sqrt) of the obstacle, we get the scalar projection of the velocity on the obstacle (the magnitude of the parallel component we are searching for)
                   dotT /= (colseg.x * colseg.x + colseg.y * colseg.y); 
                   
                   //we multiply this for the vector representing the obstacle, but we did not use the sqrt for the magnitude, so here vparl is the vectorial projection of the velocity on the 
                   //direction of the obstacle (THE PARALLEL COMPONENT)
                   PVector vparl = new PVector(colseg.x * dotT,colseg.y * dotT); 
                   
                   stroke(255,255,0,255);
                   line(coll.x,coll.y,coll.x+vparl.x *200,coll.y+vparl.y*200);
                   fill(255,255,0,255);
                   ellipse(coll.x+vparl.x *200,coll.y+vparl.y*200,10,10);
                   
                   
                   //WE ROTATE THE OBSTACLE OF PI/2 , USING A ROTATION MATRIX, AND WE DO AS BEFORE, OBTAINING THE VECTORIAL PROJECTION OF THE VELOCITY ON THE ORTHOGONAL DIRECTION OF THE OBSTACLE
                   PVector colSegRuot = new PVector( colseg.x * cos(-PI/2) + colseg.y * sin(-PI/2), colseg.x * -sin(-PI/2) + colseg.y * cos(-PI/2) );
                   
                   dotT = mover.vel.y * colSegRuot.y + mover.vel.x * colSegRuot.x;
                   dotT /= (colSegRuot.x * colSegRuot.x + colSegRuot.y * colSegRuot.y);
                   PVector vperp = new PVector(colSegRuot.x * dotT,colSegRuot.y * dotT);
                   vperp.x = vperp.x * cos(PI) + vperp.y * sin(PI);
                   vperp.y = vperp.x * -sin(PI) + vperp.y * cos(PI);
                   
                   stroke(0,255,255,255);
                   line(coll.x,coll.y,coll.x+vperp.x *200,coll.y+vperp.y*200);
                   fill(0,255,255,255);
                   ellipse(coll.x+vperp.x *200,coll.y+vperp.y*200,10,10);
                   
                   
                   //THE NEW VELOCITY IS THE SUM OF THE PARALLEL AND THE PERPENDICULAR VECTORS
                   //so we sum the x and y coordinates
                   mover.vel.x = (vparl.x + vperp.x) * 1.2;
                   mover.vel.y = (vparl.y+vperp.y) * 1.2;
                   
                   //we give for numerical reasons a new increment to the position
                   mover.pos.x = mover.pos.x + mover.vel.x * 1.0;
                   mover.pos.y = mover.pos.y + mover.vel.y * 1.0;
                   
                   //mover.pos = mover.pos.add(mover.vel.mult(1.0));
                   
                   strokeWeight(1.0);
                   noStroke();
                   
                   
                   fill(0,255,0); //collisione ellisse diventa verde
                   
                   
               }
               else
               {
                  fill(255,0,0); //altrimenti rossa
               }
               ellipse(coll.x,coll.y,50,50);
               
           // }//
         }
     
   }
   void disegnaOstacoli()
   {
      for(PVector[] el : ostacoli)
      {
         stroke(0);
         line(el[0].x,el[0].y,el[1].x,el[1].y); 
      }
   }
   
}

MoverClass mover;
CollisionChecker collChecker;

PVector t ;



void setup()
{
   size(800,600,P2D);
   mover = new MoverClass(new PVector(width/2,height/2),50,100);
   collChecker = new CollisionChecker();
  background(255);
  smooth();
  //ostacoli random
  /*for(int i=0;i<3;i++)
  {
     PVector t = new PVector(random(0,width),random(0,300));
     PVector t2 = new PVector(random(0,200),random(width-200,width));
     collChecker.ostacoli.add(new PVector[]{t,t2}); 
  }*/
}

void draw()
{
  // 
   noStroke();
   strokeWeight(1.0);
   fill(255,105);
   rect(-10,-10,width+10,height+10);
   
   
   //mover.applyForce(new PVector(0,10));
   mover.applyForce(new PVector(random(-20,20),random(-20,20)));
   mover.update();
   collChecker.disegnaOstacoli();
   collChecker.checkBordiLvl(mover);
   //collChecker.apply(mover, new PVector(0,10));
   mover.disegna();
   mover.clearAcc();
  
   
}

void mousePressed()
{
   if(t == null)
   {
      t = new PVector(mouseX,mouseY); 
   }
}

void mouseReleased()
{
    if(t != null)
    {
       collChecker.ostacoli.add(new PVector[]{t,new PVector(mouseX,mouseY)}); 
       t = null;
    }
}