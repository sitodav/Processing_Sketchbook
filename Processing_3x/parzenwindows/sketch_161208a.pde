void setup()
{
   size(600,500);
   background(0);
  
  amb = new Ambiente((int)(2.0/3 * height),5);
  
  
  
  
}

Ambiente amb;


void draw()
{
  background(0);
  amb.disegna();
  
   amb.addP((double)((random(width)) - 200 + random(400)),10.0);
}

void mouseClicked()
{
  amb.addP(mouseX,10.0);  
}

class Ambiente
{
    
    ArrayList<PVector> punti = new ArrayList<PVector>();
    int hBarra ;
    double step;
    double[] probvals;
    
    public Ambiente(int hB,double step)
    {
       this.hBarra = hB; 
       probvals = new double[(int)((float)width/step)];
       this.step = step;
    }
    
    public void disegna()
    {
        stroke(255);
        strokeWeight(2.0);
        line(0,hBarra,width,hBarra);
        line(mouseX,hBarra-20, mouseX,hBarra+20);
        for(PVector p : punti)
        {
           pushMatrix();
           translate(p.x,p.y);
           fill(255,0,0);
           stroke(255,0,0);
           ellipse(0,0,2,2);
           popMatrix();
        }
        
        fill(255);
           stroke(255);
       // System.out.println(step);
        for(int i = 1; i< probvals.length; i++)
        {
         //if(i>10) System.out.println("valuto per "+(i*step + step*0.5)+" val:"+probvals[i]);
            pushMatrix();
              //translate((float)(i* step + 0.5 * step),(float)( hBarra - probvals[i] * 2000));
              //ellipse(0,0,2,2);
              line((float)((i-1)* step + 0.5 * step),(float)( hBarra - probvals[i-1] * 1000* (punti.size()/10) ),  (float)((i)* step + 0.5 * step),(float)( hBarra - probvals[i] * 1000 * (punti.size()/10) ));
            popMatrix();
        }
    }
    
    public void addP(double x,double v)
    {
        punti.add(new PVector((float)x,(float)hBarra));
        computeParzen(v);
    }
    
    public void computeParzen(double v)
    {
        for(int i = 0; i< probvals.length;i++)
        {
            
            int k = 0;
            for(PVector p : punti)
            {
                k+= parzWind(i * (step) + (0.5*step ), p.x,v);
            }
            probvals[i] = k/(punti.size() * v);
        }
    }
    
    private int parzWind(double xCent, double xTest, double h)
    {
        return abs((float)(xCent - xTest))/h < 0.5 ? 1 : 0;
    }
    
}