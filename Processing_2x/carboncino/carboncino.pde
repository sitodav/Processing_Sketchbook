
ArrayList<PVector>  coda = new ArrayList<PVector>();

void setup()
{
 
 size(600,600);
 background(255);
 coda.add(new PVector(mouseX,mouseY));
}


void draw()
{
  
  
}


float angle = 0.0f;

void mouseDragged()
{
  
   strokeWeight(0.5);
   if(true)
   {
     PVector prec = coda.get(0);
     
     if (abs(prec.x - mouseX) > 2 || abs( prec.y - mouseY) > 2 ) 
     {
       System.out.println("SI");
       coda.add( new PVector(mouseX,mouseY) );
     }
     
     int actual = 0;
     final float maxDist = 50;
     final float minDist = 50;
     float alpha = 255;
     
     for(int i = coda.size()-1; i>= 0; i--)
     { 
       actual ++ ;
       if(mouseButton == RIGHT){
         if( abs(mouseX - coda.get(i).x) + abs(mouseY - coda.get(i).y)  > maxDist || abs(mouseX - coda.get(i).x) + abs(mouseY - coda.get(i).y)  < minDist   )
           continue;
       }
       else if(mouseButton == LEFT){
         if( abs(mouseX - coda.get(i).x) + abs(mouseY - coda.get(i).y)  > maxDist )
           continue;
       }
       stroke(  0, (int)(alpha * (abs(mouseX - coda.get(i).x) + abs(mouseY - coda.get(i).y))/(5*maxDist))  );
     line(mouseX,mouseY,coda.get(i).x,coda.get(i).y); 
       
      
     }
     
     
   }
    
}
