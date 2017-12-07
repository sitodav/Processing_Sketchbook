ArrayList<PVector> points ;
ArrayList<PVector> sorted;
int iMax;
float yMax;


void setup()
{
   size(600,600);
   ellipseMode(CENTER);
   points = new ArrayList<PVector>();
   iMax = -1;
   yMax = 0;
   textAlign(CENTER);
   textSize(30);
   
}

void mouseClicked()
{
   points.add(new PVector(mouseX,mouseY));
}

void keyPressed()
{
   if(iMax != -1)
   {
      iMax = -1;
      yMax = 0;
      sorted = null;
      points.clear();
      
   } 
   else
   {
     calcolaSecondoNuovoRoot();
   }  
}



void draw()
{
   background(255);
   int j = 0;
   
   stroke(0,255,0); fill(0,255,0);
   text("MOUSE CLICK FOR A NEW NODE.\nPRESS A KEY TO COMPUTE / RESET",width/2,100);
   noStroke();
   if(sorted == null)
   {
     for(PVector v : points)
        {  
           if(j == iMax)
           {
             fill(255,0,0);
           }
           else  
           {
             
             fill(0);        
           }
           
           ellipse(v.x,v.y,50,50);
           
           
           j++;
           
           
        }
   }
   else
   {
      
       stroke(255,0,0);
         noFill();
         ellipse(points.get(iMax).x,points.get(iMax).y,70,70); 
         noStroke();
         int o = 0;
         for(PVector v : sorted)
         {
            float val = 255 * (  o/ (float) sorted.size() ); 
            o++;
            fill(val);
            ellipse(v.x,v.y,50,50);
            /*stroke(val);
            line( v.x,v.y,points.get(iMax).x,points.get(iMax).y  );
            noStroke();*/
         }
         creaPercorso();
     
   }
}

void creaPercorso()
{
   int size = sorted.size();
   stroke(0);
   for(int i=0;i<size;i++)
   {
      line(sorted.get( (i+1)% size ).x,sorted.get( (i+1)%size ).y,sorted.get(i).x,sorted.get(i).y); 
   }
   
   noStroke();
}




void calcolaSecondoNuovoRoot( )
{
  
   
    
   int j = 0;
   for(PVector v : points)
   {
     
      if(v.y > yMax)
      {
         iMax = j;
         yMax = v.y;
      }
      else if(v.y == yMax && v.x < points.get(iMax).x)
      {
         yMax = v.y;
         iMax = j;
      }
      j++;
   }
   if(points.size() == 0) return;
   
   PVector scelto = points.get(iMax);
   PVector vect = null;
   
   sorted = new ArrayList<PVector>();
   sorted.add(scelto);
   for(int k=0;k<points.size()-1;k++)
   {
      if(k == iMax) continue;
      vect = new PVector( points.get(k).x-scelto.x, points.get(k).y - scelto.y );
      
      vect.x =  abs(vect.x) < 0.01 ? 0.01 * Math.signum( vect.x ) : vect.x ;
      
      int iLow = k;
      float minAngle = atan2(vect.y , vect.x);
      
      for(int f=k+1;f<points.size();f++)
      {
          if(f == iMax)
            continue;
          vect = new PVector( points.get(f).x-scelto.x, points.get(f).y - scelto.y );
          vect.x =  abs(vect.x) < 0.01 ? 0.01 * Math.signum( vect.x ) : vect.x ;
          float val = atan2( vect.y , vect.x );
          
          if( val < minAngle  )
          {
             iLow = f;
             minAngle = val;
          }
      }
      
      PVector t = points.get(iLow);
      points.set(iLow,points.get(k));
      points.set(k,t);
      sorted.add(t);
      //System.out.println(minAngle);      
   }
   //vect = new PVector( points.get(points.size()-1).x-scelto.x, points.get(points.size()-1).y - scelto.y );
   //vect.x =  abs(vect.x) < 0.01 ? 0.01 * Math.signum( vect.x ) : vect.x;
   //System.out.println( atan2(vect.y,vect.x) );
   sorted.add(points.get(points.size()-1));
   
}