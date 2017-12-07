PImage img;

void setup()
{
   
   size(1000,1000);
   img = loadImage("b.jpg");
    
   rgb2Gray(img);
   image(img,0,0,img.width,img.height);   
   
   for(int i=0;i<4;i++) //applying 4 times a moving mean kernel (smoothing)
     convoluzione(img,new PVector(3,3), new float[]{1.0/9,1.0/9,1.0/9,1.0/9,1.0/9,1.0/9,1.0/9,1.0/9,1.0/9}, 0);
   
   edgeDetectionGradiente(img,new PVector(3,3), new float[]{-1,0,1,-2,0,2,-1,0,1}, new float[]{-1,-2,-1,0,0,0,1,2,1}, 60); //edge detection using sobel kernels for x and y derivatives (gradient)
   
   image(img,0,0);
   
}

void draw()
{
  
}


/***routine per image processing ***********************************************/

void rgb2Gray(PImage img) //used to store in each of the three channels of a PImage, the same value obtained as the mean of the 3 original channels (R+G+B)/3
{
  img.loadPixels();
  for(int i=0;i<img.width*img.height;i++)
   {
      int iR = i / img.width;
      int iC = i % img.width;
      color c= img.get(iC,iR);
      float red = red(c);
      float green = green(c);
      float blue = blue(c);
      float v = 0.3333 * (red+green+blue);
      img.pixels[i] = color(v,v,v);
   }
   img.updatePixels();
}
 







void edgeDetectionGradiente(PImage img, PVector sizeKernel, float[] kernelX, float[] kernelY, float sogliaEdge)
{
    
    PImage xDer = img.copy();
    PImage yDer = img.copy();
    convoluzione(xDer,sizeKernel,kernelX,sogliaEdge);
    convoluzione(yDer,sizeKernel,kernelY,sogliaEdge);
    
    img.loadPixels();
    for(int i=(int)(sizeKernel.y /2.0); i<= img.height - (sizeKernel.y /2.0);i++)
     {
         for(int j=(int)(sizeKernel.x /2.0); j<=  img.width - (int)(sizeKernel.x /2.0);j++) 
         {
               float t = red(xDer.get(j,i));  
               float t2 = red(yDer.get(j,i));
               
               float vToSet = sqrt( t*t + t2*t2);
               vToSet = abs(vToSet) > sogliaEdge ? abs(vToSet) : .0 ;
               img.pixels[i*img.width + j] = color(vToSet,vToSet,vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
              
         }
     }
     img.updatePixels();
    
}

void convoluzione(PImage img, PVector sizeKernel,float[] kernel,float soglia)
{
   img.loadPixels();
   
   for(int i=(int)(sizeKernel.y /2.0); i<= img.height - (sizeKernel.y /2.0);i++)
   {
       for(int j=(int)(sizeKernel.x /2.0); j<=  img.width - (int)(sizeKernel.x /2.0);j++) 
       {
             float t = 0;  
             
             for(int ii= - (int)(sizeKernel.y /2.0) ;ii<= (int)(sizeKernel.y /2.0);ii++)
             {
                for(int jj=- (int)(sizeKernel.x /2.0);jj<=(int)(sizeKernel.x /2.0);jj++)
                {
                    t += red(img.get(j+jj + (int)(sizeKernel.x /2.0) , i+ii + (int)(sizeKernel.y /2.0))) * kernel[((ii+ (int)(sizeKernel.y /2.0))*(int)sizeKernel.x+ jj + (int)(sizeKernel.x /2.0)  )];
                    
                }
             }
             float vToSet = t; 
             vToSet = abs(vToSet) > soglia ? abs(vToSet) : .0 ;
             img.pixels[i*img.width + j] = color(vToSet,vToSet,vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
            
       }
   }
   img.updatePixels(); //in this way we flush from img.pixels[] to > img
   
}