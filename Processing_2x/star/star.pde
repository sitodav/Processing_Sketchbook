void setup()
{
  
  size(500,500);
  background(0);
  
}


float r1 = 50;
float r2 = 95;
int n = 5;
float pulse = 0.0f;
float porz = 2 * PI / n;
float angle = 0.0f;


void draw()
{
  //background(0);
  noStroke();
  fill(255 * pulse ,25);
  pushMatrix();
  translate(mouseX,mouseY);
  rotate(angle);
 for(int i=0;i<n;i++){
    beginShape();
    vertex(0,0);
    vertex(r1 * cos(-porz*0.5+ i*porz),r1*sin(-porz*0.5 + i*porz));
    vertex(r2 * cos(i*porz),r2*sin(i*porz));
    vertex(r1 * cos(porz * 0.5 + i * porz),r1 *sin(porz * 0.5 + i * porz));
    endShape(CLOSE); 
    pulse = pulse + 0.01f;
    pulse = pulse - (int) ( pulse/6 ) * 6;
    r2 = 95 * cos(pulse);
    //angle += 0.01;
 } 
 popMatrix();
 
 

}



