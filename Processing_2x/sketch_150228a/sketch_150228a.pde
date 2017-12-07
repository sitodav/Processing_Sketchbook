float angle = 0.0f;
int windW = 500, windH = 500;


void setup(){
  background(0);
  size(windW,windH);
}

void draw(){
  
  fill(0,0,0,10);
  rect(0,0,width,height);
  
  
  noFill();
  stroke(255);
  pushMatrix();
    translate(width/2,height/2);
    rotate(angle);
    rectMode(CENTER);
    rect(xc, , sqrW,sqrH);
    angle = angle + 0.1;
  popMatrix();
}




