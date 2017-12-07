import processing.video.*;
import gab.opencv.*;
import java.awt.Rectangle;
OpenCV opencv;
Capture cam;

void setup()
{
 size(640,480);
 opencv = new OpenCV(this,width,height);
 opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
 String[] cameras = Capture.list();
 cam = new Capture(this,cameras[2]); 
 cam.start();
}

void draw()
{
  Rectangle[] faces = null;
 if(cam.available())
 {
    cam.read();
    opencv.loadImage(cam);
    faces = opencv.detect();
    noFill();
    image(opencv.getInput(), 0, 0);//image(cam,0,0,640,480);
  stroke(0, 255, 0);
  strokeWeight(3);
  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
 }
 
 
 
 
}
