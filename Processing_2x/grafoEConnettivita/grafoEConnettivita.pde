int[][] matConn;
ArrayList<PVector> nodi = new ArrayList<PVector>(); 
int maxNodi = 50;
int raggioNodo = 50;
boolean isTracingEdge;
int indSourceEdge;
int nNodi = 0;


void setup()
{
   
   size(1500,400);
   background(0,0); 
   ellipseMode(CENTER);
   matConn = new int[50][50];
}

void draw()
{
  background(0);
  
  disegnaGuiEMatriceConn();
  
  fill(255,255,255,125);
  stroke(255,255,255,255);
  
  PFont font = createFont("Georgia", 28 );
  textFont(font);
  textAlign(CENTER, CENTER); 
  
  
  for(int i=0;i<nodi.size();i++)
  {  
     
     PVector p = nodi.get(i);
     
     fill(255,255,255,125);
     ellipse(p.x,p.y,raggioNodo,raggioNodo);
     fill(255);
     text(i+"",p.x,p.y-raggioNodo);
  }
  
  
  strokeWeight(3);  
  stroke(255,255,255,255);
  for(int j=0;j<nNodi;j++)
  {
     for(int i=0;i<nNodi;i++)
     {
        if(matConn[i][j] > 0)
        {
           stroke(255,255,255,255);
           line(nodi.get(j).x,nodi.get(j).y,nodi.get(i).x,nodi.get(i).y);
           
        } 
     }
  } 
  
  if(isTracingEdge)
  {  
     strokeWeight(3);  
     stroke(255,255,255,255);
     PVector sourceP = nodi.get(indSourceEdge);
     line(sourceP.x,sourceP.y,mouseX,mouseY); 
  }
  
}

void mouseReleased()
{
   if(isTracingEdge)
   {
       int i = 0;
       int x = mouseX, y= mouseY;
       if(x> width/2 + 150)
         return;
       for(PVector p: nodi)
       {
         if( sqrt( (x-p.x)*(x-p.x) + (y-p.y)*(y-p.y) ) < raggioNodo  && i != indSourceEdge)
         {
            //crea edge in conn
            matConn[i][indSourceEdge] = 1;
            System.out.println("connesso "+indSourceEdge+" con "+i);
            
         }
         i++;
       }
       isTracingEdge = false;
   } 
}
  

void mousePressed()
{
    int x = mouseX,y=mouseY;
    if(x> width/2 + 150)
         return;
    int i = 0;
    for(PVector p: nodi)
    {
        if( sqrt( (x-p.x)*(x-p.x) + (y-p.y)*(y-p.y) ) < raggioNodo )
        {
            indSourceEdge = i;
            isTracingEdge = true;
            return;
        }
        i++;
    }
}

void mouseClicked()
{
   int x = mouseX, y = mouseY;
   if(x> width/2 + 150)
         return;
   for(PVector p : nodi)
   {
        if( sqrt( (x-p.x)*(x-p.x) + (y-p.y)*(y-p.y) ) < raggioNodo )
          return;
   }     
   nNodi++;
   PVector toAdd = new PVector(x,y,0);
   nodi.add(toAdd);
   //aggiungi nodo in connett
}


void disegnaGuiEMatriceConn()
{
 
  PVector a = new PVector(width/2 + 200, 50 , 0),
  b = new PVector(width, 50, 0),
  c= new PVector(width,height),
  d= new PVector(width/2+200,height);
  
   //gui----
  fill(255,255,255,125);
  rectMode(CORNER);
  rect(a.x,a.y,c.x,c.y);
  strokeWeight(5);
  stroke(125,125,125);
  
  //------- 
  float widthMat = b.x - a.x ;
  float heightMat = d.y -a.y ;
  float xOff = widthMat / (float)nNodi;
  float yOff = heightMat / (float)nNodi;
  rectMode(CENTER);
  noFill();
  strokeWeight(1);
  stroke(255,255,255,200);
  float sizeFont = 32 * (maxNodi-nNodi)/(float)maxNodi;
  PFont font = createFont("Georgia", sizeFont );
  textFont(font);
  textAlign(CENTER, CENTER); 
  
  for(int i=0;i<nNodi;i++)
  {
     stroke(255,255,255,125);
     //rect(a.x-30 , a.y + i*yOff + 0.4*yOff,50,50);   
     text(i+"",a.x-30 , a.y + i*yOff + 0.4*yOff);
  }
  
  sizeFont = 32 * (maxNodi-nNodi)/(float)maxNodi;
  font = createFont("Georgia", sizeFont );
  textFont(font);
  textAlign(CENTER, CENTER); 
  
  
  
  for(int i=0;i<nNodi;i++)
  {
     for(int j=0;j<nNodi;j++)
     {  fill(255,255,255,125);
        rect(a.x+j*xOff+0.5*xOff,a.y+i*yOff +0.5*yOff, xOff,yOff);  
        fill(0);
        text(matConn[i][j]+"",a.x+j*xOff+0.5*xOff,a.y+i*yOff+0.4*yOff);
     }
     
  }
   
  
}





