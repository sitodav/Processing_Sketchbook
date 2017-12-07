
class BottoneRettangolare
{
  int x,y,w,h;
  boolean clicked = false;
  int r,g,b,alpha;
  
  public BottoneRettangolare(int x,int y,int w,int h,int r,int g,int b,int alpha)
  {
    this.x = x; this.y = y; this.w = w; this.h = h; this.r = r; this.g = g; this.b = b; this.alpha = alpha;
  }
  
  boolean checkClick()
  {
      if( mousePressed && mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h )
      {
        clicked = true;
      }
      else 
      {
        clicked = false;
      }
      return clicked;
  }
  
  void paintMe()
  {
      fill(r,g,b,alpha);
      rect(x,y,w,h);
  }

}

ArrayList<BottoneRettangolare> bottoniRettangolari = new ArrayList<BottoneRettangolare>();


void initLayout()
{
 
   background(255);
   fill(255,255,255);
   stroke(0);
   rect(20,20, width-40,height-200);
   
   noFill();
   rect(10,10, width-20,height-180);
   line(20,300,width-20,300);
   fill(0,0,0,20);
   rect(20,300,width-40,220);
   
   
   bottoniRettangolari.add(new BottoneRettangolare(80,50,50,200,200,200,200,50));
   
}


void setup()
{
  size(700,700);
  initLayout();
  
    
  
}



void draw()
{
  
  for(BottoneRettangolare el : bottoniRettangolari)
    el.paintMe();
}
