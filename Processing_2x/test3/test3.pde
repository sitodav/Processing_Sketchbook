void setup()
{
  size(800,800);
  background(0);
  ellipseMode(CENTER);
  noStroke();
  mat = new int[height][width];
}

int[][] mat ;
float velDisc = 10;
ArrayList<PVector> scie = new ArrayList<PVector>();
ArrayList<Integer> segni = new ArrayList<Integer>();

void draw()
{
   fill(0,25);
   rect(0,0,width,height);
   noFill(); 
   
   aggiorna();
   disegna();
     
   if(mousePressed)
   {
     aggiungi();
   }
}



void aggiungi()
{
   scie.add(new PVector(mouseX,mouseY));
   segni.add(1);
}

void aggiorna()
{
 
   for(int i=0;i<scie.size();i++)
   {
      PVector p = scie.get(i);
     
     
      p.x = p.x + random(5) - random(5);
      p.y += segni.get(i) * velDisc;
      if(p.y > height || p.y<0)
        scie.remove(i);
      
      if ( ((int)p.x < width && (int)p.x>0) && ((int)p.y < height  && (int)p.y > 0) )
      {
        
        mat[(int)p.y][(int)p.x] = mat[(int)p.y][(int)p.x] > 0 ? mat[(int)p.y][(int)p.x]-1 : mat[(int)p.y][(int)p.x];
        
        p.x = p.x - ( -1 * random(3) ) * mat[(int)p.y][(int)p.x];
        p.y = p.y - ( -1 * random(3) ) * mat[(int)p.y][(int)p.x];
        
        mat[(int)p.y][(int)p.x] += 1;
      }
      else
      {
        segni.set(i, segni.get(i) * -1 );
        return;
      }
   } 
  
  System.out.println(scie.size());
}

void disegna()
{
  fill(255,105);
  
    for(PVector el : scie)
     {
        
        ellipse(el.x,el.y,30,30);
        
     } 
  
}
