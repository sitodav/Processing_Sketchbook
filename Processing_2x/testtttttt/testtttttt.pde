boolean[] bx = {
  false, true, false, true, false, true, false, true
};
boolean[] by = {
  false, false, true, true, false, false, true, true
};
boolean[] bz = {
  false, false, false, false, true, true, true, true
};
 
 
class Octree {
  boolean hasChilds;
  Octree[] childs;
  color c;
  PVector p;
  float s;
  int my_level;
  Octree(float is, PVector ip, boolean haveChilds, int level) {
    s = is;
    p = ip;
    hasChilds = haveChilds;
    my_level = level;
    if ( hasChilds ) {
      childs = new Octree[8];
      float half_s = s/2;
      for (int i=0; i<8; i++) {        
        childs[i] = new Octree(
        half_s, 
        new PVector(
        p.x+(bx[i]?half_s:0), 
        p.y+(by[i]?half_s:0), 
        p.z+(bz[i]?half_s:0)
          ), 
        my_level < 5 && random(1) < .5,
        my_level+1
          );
      }
    } else {
      c = color(random(255), random(255), random(255));
    }
  }
  void draw() {
    if ( hasChilds ) {
      for (int i=0; i<8; i++) {
        childs[i].draw();
      }
    } else {
      fill(c);
      pushMatrix();
      translate(p.x, p.y, p.z);
      translate(s/2, s/2, s/2);
      noStroke();
      box(s*.8);
      popMatrix();
    }
  }
}
 
Octree ot = new Octree( 200, new PVector(0, 0, 0), true, 0);
 
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
