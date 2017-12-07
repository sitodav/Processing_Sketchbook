void setup()
{
   background(0);
   size(1000,1000); 
}

float stepAngle = 0.05;
float incrementoRotazione = 1.0;
float size = 1.5;
int nSegmenti = 100;
float alpha = 10;
float incrementoPulse = 0.1;

void draw()
{
   if(!mousePressed)
    return;
   
   PVector vecchio= new PVector(pmouseX,pmouseY);
   PVector nuovo= new PVector(mouseX,mouseY);
   
   float offy = vecchio.y - nuovo.y;
   float offx = vecchio.x - nuovo.x;
   
   
   float angle = atan2 ( offy , offx );
   float modulo = sqrt( offy*offy + offx*offx ) * size ;
   
   float tAngle = angle + incrementoRotazione;
   
   pushMatrix();
   translate(mouseX,mouseY);
   while (tAngle > angle - incrementoRotazione)
   {
     float compx1 = modulo * cos(tAngle);
     float compy1 = modulo * sin(tAngle);   
     float stepSegmentoX = compx1 / nSegmenti;
     float stepSegmentoY = compy1 / nSegmenti;
     float stepAlpha = alpha / nSegmenti;
     strokeWeight(3.0);
     
     
     for(int i=0;i<nSegmenti-1;i++)
     {
       stroke(255,i * stepAlpha);
       line(i*stepSegmentoX,i*stepSegmentoY, (i+1)*stepSegmentoX + (float)Math.random()*i*stepSegmentoX * incrementoPulse, (i+1)*stepSegmentoY +(float)Math.random()*i*stepSegmentoY*incrementoPulse);
       
     } 
     
     tAngle = tAngle - stepAngle;
     
     //line(0,0,compx1,compy1);
   }
   popMatrix();
  
      
 
    
}
