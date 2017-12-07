void draw()
{
  background(255);
  noStroke();
  
  for (int i =0;i<ps.size();i++)
  {
    PVector el = ps.get(i);
    float t = 1- ((0.5*i)/ (0.5 * (float)ps.size()));
    
    fill(0, 255 * t);
    ellipse(el.x, el.y, 5, 5);
    
    if(i%2 == 0)
    {
       stroke(0, 255 * t);
       line(el.x,el.y,ps.get(i+1).x,ps.get(i+1).y);  
       noStroke();
    }
  }
}

ArrayList<PVector> ps = new ArrayList<PVector>();
ArrayList<PVector[]> lines = new ArrayList<PVector[]>();
int nPs = 120;
PVector axS, axE;


void setup()
{


  axS = new PVector(width/2, 100);
  axE = new PVector(width/2, height-100);

  size(600, 600);
  background(255);
  initPs();
}

void initPs() {
  float porz = (axE.y - axS.y)/nPs;

  for (int i= 0; i<nPs; i++)
  {

    PVector pa = new PVector( axS.x - i* (200.0/nPs), i*porz + axS.y );
    PVector pb = new PVector( axS.x + i* (200.0/nPs), i*porz + axS.y );
    ps.add(pa);
    ps.add(pb);
    lines.add(new PVector[]{pa , pb });
  }
}