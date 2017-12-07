void setup()
{
   size(600,600);
   background(0,0);
   PImage img = loadImage("C:/Users/davide/Pictures/face.jpg");
   img.resize(600,600);
   image(img,0,0); 
}

int size = 50;

void draw()
{
   if(!mousePressed)
      return;
   
   PImage img = get();
   
   int x = mouseX;
   int y = mouseY;
   
   loadPixels();
   img.loadPixels();
   
   for(int i = - size/2; i <= size/2; i++ )
   {
     for(int j = - size/2; j <= size/2; j++ )
     {
         if(i+y < 0 || i+y >=height || j+x<0 || j+x>= width)
            continue; 
         
         color out = blur(x+j,i+y,3,img);
         pixels[(i+y) * width + (j+x)] = out;
         //set(x+j,y+i,out);
     }  
     
     
     
   }
   updatePixels();
       
    
}

color blur(int x,int y,int size, PImage img)
{
  
  double r = 0, g = 0, b = 0 ;
  int n = 0;
  for(int i = -size;i<=size;i++)
   {
      for(int j= -size; j<=size;j++)
      {
         if(i+y < 0 || i+y >=height || j+x<0 || j+x>= width)
            continue; 
         n++;
         color c = img.pixels[(x+j) + width * (y+i)];
         r += red(c);
         g += green(c);
         b += blue(c);
         
      }
   } 
   
   r /= n; g /=n; b /= n;
   
   return color((int)(r),(int)(g),(int)(b));
}
