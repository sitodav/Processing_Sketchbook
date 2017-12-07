void setup()
{
 size(700,700);
 background(0);
 rectMode(CENTER);
 fill(125,125,0); 
  
}

int[][] mappa = null;
ArrayList<PVector> listaPunti = new ArrayList<PVector>();;

float angle = 0.0f;
int size = 100;
int maxAlpha = 100;
int incrementoPulse = 20;

void draw()
{
  
  
}


void mousePressed()
{
 mappa = new int[height][width]; 
 listaPunti.clear(); 
}

void mouseDragged()
{
   
   
   
   
   
   color start = get(mouseX,mouseY);
   int r = (int)red(start);
   int g = (int)green(start);
   int b = (int)blue(start);
   
   espandi(mouseY,mouseX,125,125,125,r,g,b,size);
   
}

void espandi(int i,int j,int nr,int ng,int nb,int sr,int sg,int sb,int dist)
{
   
   if(dist==0)
      return;
   if(i<0 || i>=height || j<0 || j>=width)
      return;
   if(mappa[i][j] >= dist)
      return; 
   
    
//   
   mappa[i][j]= dist;   
   listaPunti.add(new PVector(j,i));
   
   int step = (int)(1+Math.random()*dist);
   espandi(i,j+step,nr,ng,nb,sr,sg,sb,dist-step);
   //step = (int)(1+Math.random()*dist);
   espandi(i,j-step,nr,ng,nb,sr,sg,sb,dist-step);
   //step = (int)(1+Math.random()*dist);  
   espandi(i+step,j,nr,ng,nb,sr,sg,sb,dist-step);
   //step = (int)(1+Math.random()*dist);
   espandi(i-step,j,nr,ng,nb,sr,sg,sb,dist-step);
   

  
    angle = angle +0.1f;
  
   
  
   rectMode(CENTER);
   noStroke();
   int alpha = (int)(maxAlpha*((float)dist/size)) ;
   fill(nr,ng,nb,alpha);
   
    
   rect(j+(int)(Math.random()*(20)),i+(int)(Math.random()*20),2,2); 
  
}

void mouseReleased()
{ 

  int x =mouseX;
  int y = mouseY;
  
  for(int i=0;i<listaPunti.size();i+=incrementoPulse)
  {
    stroke(255, (int)(maxAlpha / 12) * ((float)i/listaPunti.size()) );
     
    line(x,y,listaPunti.get(i).x, listaPunti.get(i).y);
    
  }
  
}

 
