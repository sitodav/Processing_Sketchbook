import processing.video.*;

Capture video;

PImage img1, img2;
PImage imgT;
int r = 5;
int n;
void setup()
{
  n=1;
  
  //for(String s : Capture.list())
    //System.out.println(s);
  size(660,900);
  
  //video = new Capture(this,800,600,Capture.list()[1]); 
  //video.start();
  
  
  
  
  imgT = loadImage("foto.jpg");
  imgT.resize(width,height);
  //for (int i=0; i<1; i++)
    //  miximages(imgT,0.5);
  
  
    //for (int i=0; i<1; i++) //applying 4 times a moving mean kernel (smoothing)
    //  convoluzione(imgT, new PVector(3, 3), new float[]{1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0}, 0);
  
    edgeDetectionGradiente(imgT, new PVector(3, 3), new float[]{-1, 0, 1, -2, 0, 2, -1, 0, 1}, new float[]{-1, -2, -1, 0, 0, 0, 1, 2, 1}, 10); //edge detection using sobel kernels for x and y derivatives (gradient)
    
    image(imgT, 0, 0); 
  
  
  noLoop();
}

void miximages(PImage img1,float soglia)
{
  //img1.loadPixels();

  for (int i=10; i<img1.height-10; i++)
  {
    for (int j=10; j<img1.width-10; j++)
    {
      if (random(0, 1) > soglia)
      {
        float xo = random(0, r);
        float yo = random(0, r);
        color t = img1.pixels[i*img1.width + j];
        img1.pixels[i*img1.width + j] =  color(random(0,1)*red(img1.pixels[i*img1.width+j]) );
        
        
      }
    }
  }
  img1.updatePixels();
}

void draw()
{
  
  /*
  if(video.available())
  {
     video.read();
     PImage tImg = video.copy();
     tImg.resize(width,height);
     
     for (int i=0; i<1; i++)
      miximages(tImg,0.5);
  
  
    for (int i=0; i<1; i++) //applying 4 times a moving mean kernel (smoothing)
      convoluzione(tImg, new PVector(3, 3), new float[]{1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0,1/9.0}, 0);
  
    edgeDetectionGradiente(tImg, new PVector(3, 3), new float[]{-1, 0, 1, -2, 0, 2, -1, 0, 1}, new float[]{-1, -2, -1, 0, 0, 0, 1, 2, 1}, 10); //edge detection using sobel kernels for x and y derivatives (gradient)
    
    image(tImg, 0, 0); 
      
  }
  
  */
  
}





/***routine per image processing ***********************************************/

void rgb2Gray(PImage img) //used to store in each of the three channels of a PImage, the same value obtained as the mean of the 3 original channels (R+G+B)/3
{
  img.loadPixels();
  for (int i=0; i<img.width*img.height; i++)
  {
    int iR = i / img.width;
    int iC = i % img.width;
    color c= img.get(iC, iR);
    float red = red(c);
    float green = green(c);
    float blue = blue(c);
    float v = 0.3333 * (red+green+blue);
    img.pixels[i] = color(v, v, v);
  }
  img.updatePixels();
}








void edgeDetectionGradiente(PImage img, PVector sizeKernel, float[] kernelX, float[] kernelY, float sogliaEdge)
{

  PImage xDer = img.copy();
  PImage yDer = img.copy();
  convoluzione(xDer, sizeKernel, kernelX, sogliaEdge);
  convoluzione(yDer, sizeKernel, kernelY, sogliaEdge);

  img.loadPixels();
  for (int i=(int)(sizeKernel.y /2.0); i<= img.height - (sizeKernel.y /2.0); i++)
  {
    for (int j=(int)(sizeKernel.x /2.0); j<=  img.width - (int)(sizeKernel.x /2.0); j++) 
    {
      float t = red(xDer.get(j, i));  
      float t2 = red(yDer.get(j, i));

      float vToSet = sqrt( t*t + t2*t2);
      vToSet = abs(vToSet) > sogliaEdge ? abs(vToSet) : .0 ;
      img.pixels[i*img.width + j] = color(vToSet, vToSet, vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
    }
  }
  img.updatePixels();
}

void convoluzione(PImage img, PVector sizeKernel, float[] kernel, float soglia)
{
  img.loadPixels();

  for (int i=(int)(sizeKernel.y /2.0); i< img.height - (sizeKernel.y /2.0); i++) //<>//
  {
    for (int j=(int)(sizeKernel.x /2.0); j<  img.width - (int)(sizeKernel.x /2.0); j++) 
    {
      float t = 0;  

      for (int ii= - (int)(sizeKernel.y /2.0); ii<= (int)(sizeKernel.y /2.0); ii++)
      {
        for (int jj=- (int)(sizeKernel.x /2.0); jj<=(int)(sizeKernel.x /2.0); jj++)
        {
          t += red(img.get(j+jj +1  , i+ii +1)) * kernel[((ii+ (int)(sizeKernel.y /2.0))*(int)sizeKernel.x+ jj + (int)(sizeKernel.x /2.0)  )];
          
          if(i==height / 2 && j == width/2 )
          {
             println( "pixel ("+i+","+j+")"+ " ii:"+ii+" jj:"+jj+" "+ +(i+ii)+","+(j+jj)+" "+red(img.get((int)(j+jj+0)  , (int)(i+ii+0) )) + " * "+ kernel[((ii+ (int)(sizeKernel.y /2.0))*(int)sizeKernel.x+ jj + (int)(sizeKernel.x /2.0)  )] ); 
          }
        }
      }
      float vToSet = t; 
      vToSet = abs(vToSet) > soglia ? abs(vToSet) : .0 ;
      img.pixels[i*img.width + j] = color(vToSet, vToSet, vToSet); //...BUT if we do not updatePixels() we still have the old values in img.get(x,y)
    }
  }
  img.updatePixels(); //in this way we flush from img.pixels[] to > img
}