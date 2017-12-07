PImage img; //<>//

ArrayList<PVector> punti ;
class NodoQuadTree
{
  PVector center;
  float size;
  NodoQuadTree[] figli = null;

  NodoQuadTree(PVector center, float size)
  {
    this.center = center;
    this.size = size;
  }


  public boolean isFoglia() { 
    return figli == null;
  }

  public void divide()
  {
    figli = new NodoQuadTree[4];
    float newSize = this.size * 0.5;
    for (int i=0; i<4; i++)
    {
      int iR = i / 2;
      int iC = i % 2;
      PVector newC = new PVector( this.center.x - newSize + iC * newSize + 0.5 * newSize, this.center.y - newSize + iR * newSize + 0.5 * newSize);
      figli[i] = new NodoQuadTree(newC, newSize);
    }
  }

  public void disegna()
  {
    if (isFoglia())
    {
      noFill();
      stroke( 255 - ( 255 * ( (width-20-size)/(width-20) ) ) );
      rect(center.x/*+random(-1, 1)*/, center.y/*+random(-1, 1)*/, this.size, this.size);
    } else
    {
      for (NodoQuadTree el : figli)
      {
        el.disegna();
      }
    }
  }

  public NodoQuadTree findClicked(float mouseX, float mouseY)
  {
    if (isFoglia())
    {
      //System.out.println(center.x+" "+center.y);
      return this;
    } else
    {
      int iR = mouseY > this.center.y ? 1 : 0;
      int iC = mouseX > this.center.x ? 1 : 0;
      return this.figli[iR*2+iC].findClicked(mouseX, mouseY);
    }
  }
}

NodoQuadTree root = null;

void setup()
{
  size(600, 800);
  //frameRate(30);
  img=loadImage("mara.jpg");
  img.resize(width, height);
  img.filter(GRAY);
  img.loadPixels();
  punti = new ArrayList<PVector>();
  int maxPs = 50;

  for (int i=0; i<img.height; i+=4)
  {
    for (int j=0; j<img.width; j+=4)
    {
      int nPs =(int)( maxPs * ( (255.0 - brightness(img.pixels[i*img.width + j])) / 1605.0f) ) ;
      for (int k = 0; k<nPs; k++)
      {
        punti.add(new PVector(  j+random(-2, 2), i+random(-2, 2)  ));
      }
    }
  }

  System.out.println("punti aggiunti");
  root = new NodoQuadTree(new PVector(width/2, height/2), -50+width);

  //partizionaPerTuttiPunti(root, punti);

  //System.out.println("partizionato");
  rectMode(CENTER);
}

void partizionaPerTuttiPunti(NodoQuadTree root, ArrayList<PVector> punti)
{
  for (PVector p : punti)
  {
    NodoQuadTree no = root.findClicked(p.x, p.y);
    no.divide();
  }
}


void partizionaPerPuntoSingolo(NodoQuadTree root, PVector p)
{
  NodoQuadTree no = root.findClicked(p.x, p.y);
  no.divide();
}

int cont=0;

void draw()
{
  background(255);
  root.disegna();
  fill(0);
  noStroke();
  ellipseMode(CENTER);
  if (punti != null && punti.size()>cont + 200 )
  {
    int o = 0; 
    while (o++<200)
    {
      PVector p = punti.get(cont);
      partizionaPerPuntoSingolo(root, p);
      cont++;
    }
  }
}

void mouseDragged()
{
  NodoQuadTree clicked = root.findClicked(mouseX, mouseY);
  clicked.divide();
}
void mouseClicked()
{
  NodoQuadTree clicked = root.findClicked(mouseX, mouseY);
  clicked.divide();
}