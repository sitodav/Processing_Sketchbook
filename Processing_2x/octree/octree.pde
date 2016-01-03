boolean[] offx = {
  false, true, false, true, false, true, false, true
};
boolean[] offy = {
  false, false, true, true, false, false, true, true
};
boolean[] offz = {
  false, false, false, false, true, true, true, true
};
final float MAX_LVL = 4;

Octree ot = new Octree( 200, new PVector(0, 0, 0), 0);
 
void setup() {
  size(400, 400, P3D);
}
 
void draw() {
  background(0);
  translate(width/2, height/2, 0);
  rotateY(map(mouseX, 0, width, -PI, PI));    
  rotateX(map(mouseY, 0, height, -PI, PI));
  translate(-100, -100, -100);
  ot.draw();
}


class Octree
{
    float size;
    int lvl;
    PVector center;
    Octree[] figli;
    color c;
    
    public Octree(float size,PVector center, int lvl)
    {
      this.size = size; this.lvl = lvl; this.center = center;
      
      if(lvl <= MAX_LVL && random(1.0) < .5 )
      {
        figli = new Octree[8];
        for(int i=0;i<8;i++)
        {
          figli[i] = new Octree(size/2, new PVector(center.x + (offx[i] ? size/2 : 0) , center.y + (offy[i] ? size/2 : 0), center.z + (offz[i] ? size/2 : 0)),lvl+1);
        }    
      }
      else {
          c = color(random(255), random(255), random(255));
        }
      
    }
    
     void draw() 
     {
      if ( figli != null ) {
        for (int i=0; i<8; i++) {
          figli[i].draw();
        }
      } else {
        fill(c);
        pushMatrix();
        translate(center.x, center.y, center.z);
        translate(size/2, size/2, size/2);
        noStroke();
        box(size*.8);
        popMatrix();
      }
    }
  
}
