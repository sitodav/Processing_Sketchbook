//----------------------------------------CLASSI------------------------------------------------------------------
class Addendo
{
  float data;
  public Addendo(){}
  public Addendo(float data)
  {
    this.data = data;
  }
  public void setData(float data){this.data = data;}
  public float getData(){return data;}
  
}

abstract class Funzione extends Addendo
{
  public abstract Addendo calcolami();
}

class Somma extends Funzione
{
  Addendo argo1,argo2;
  public Somma(Addendo argo1, Addendo argo2) { this.argo1 = argo1; this.argo2 = argo2; }
    public Addendo calcolami() 
    { 
      float a = argo1 instanceof Funzione ? ((Funzione)argo1).calcolami().getData() : argo1.getData();
      float b = argo2 instanceof Funzione ? ((Funzione)argo2).calcolami().getData() : argo2.getData();
     
      return new Addendo( a + b );
    }
}

class Moltiplicazione  extends Funzione
{
  Addendo argo1,argo2;
  public Moltiplicazione(Addendo argo1, Addendo argo2) { this.argo1 = argo1; this.argo2 = argo2; }
    public Addendo calcolami() { 
      
      float a = argo1 instanceof Funzione ? ((Funzione)argo1).calcolami().getData() : argo1.getData();
      float b = argo2 instanceof Funzione ? ((Funzione)argo2).calcolami().getData() : argo2.getData();
      
      return new Addendo(a*b); 
  
    }
}

class Seno extends Funzione
{
  Addendo argo1;
  public Seno(Addendo argo1) { this.argo1 = argo1; }
  public Addendo calcolami() 
  {
    float a = argo1 instanceof Funzione ? ((Funzione)argo1).calcolami().getData() : argo1.getData();
    return new Addendo((float)Math.sin(a)); 
  }
  
}

class Coseno extends Funzione
{
  Addendo argo1;
  public Coseno(Addendo argo1) { this.argo1 = argo1; }
  public Addendo calcolami() 
  {
    float a = argo1 instanceof Funzione ? ((Funzione)argo1).calcolami().getData() : argo1.getData();
    return new Addendo((float)Math.cos(a)); 
  }
  
}

class Potenza  extends Funzione
{
  Addendo argo1, argo2;
  public Potenza(Addendo argo1, Addendo argo2) { this.argo1 = argo1; this.argo2 = argo2;}
  public Addendo calcolami() 
  {
    float a = argo1 instanceof Funzione ? ((Funzione)argo1).calcolami().getData() : argo1.getData();
    float b = argo2 instanceof Funzione ? ((Funzione)argo2).calcolami().getData() : argo2.getData();
    return new Addendo((float)Math.pow((double)a,b));  
  
  }
}


//---------------------------------------------------------------------------------












Addendo angle; //questo è il parametro
Funzione formulaPerX, formulaPerY;
float yMaxSpost;
float xMaxSpost;
PVector centroVista;
int nPunti;
int zNeed ;
PVector[] guide;
int totStartLength;
int nChiamateFunzione;
int quandoCambioFunzioneX;
Funzione[] funzioniPerX;
int quandoCambioFunzioneY;
Funzione[] funzioniPerY; 

void setup()
{
  size(1000,800,OPENGL);
  //hint(DISABLE_OPTIMIZED_STROKE);

  angle = new Addendo(0.0f); //questo è il parametro
  formulaPerX, formulaPerY;

  yMaxSpost = 100;
  xMaxSpost = 100;
  zNeed = 600;
  centroVista = new PVector(width/2,height/2,zNeed); 
  nPunti = 400;
  
  guide = new PVector[nPunti];
  totStartLength = 10000;
  nChiamateFunzione = 0;
  quandoCambioFunzioneX = 200;
  quandoCambioFunzioneY = 200;
  
  funzioniPerX = new Funzione[]{
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(xMaxSpost), new Coseno( angle ) )   ),
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(xMaxSpost), new Seno( angle ) )   ),
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(xMaxSpost), new Moltiplicazione(new Seno(angle),new Coseno(angle)) ) ) 
        };

   
  funzioniPerY = new Funzione[]{
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(yMaxSpost), new Seno( angle ) )   ),
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(yMaxSpost), new Coseno( angle ) )   ),
          new Somma( new Addendo((float)width/2.0f), new Moltiplicazione(new Addendo(yMaxSpost), new Moltiplicazione(new Seno(angle),new Coseno(angle)) ) )
        };
  
  
  
  for(int i=0;i<nPunti;i++)
  {
     float stepZ = totStartLength / (float)nPunti;
     
     formulaPerX = funzioniPerX[0];
     formulaPerY = funzioniPerY[0];  
     guide[i] = new PVector(formulaPerX.calcolami().getData(), formulaPerY.calcolami().getData(), -1 * stepZ * i + zNeed); 
     
     angle.setData(angle.getData()+0.1);
     //angle+=0.1;
  }
   stroke(255);  
   rectMode(CENTER); 
   noFill();
   
}

void draw()
{
  
  background(0);
  
  
  PVector c = guide[0];
  pushMatrix();
  translate(centroVista.x,centroVista.y,centroVista.z );

  //------------------------------------------ per ruotare punto di vista verso successivo punto
  float a = - guide[1].z + guide[0].z;
  float b = guide[1].x - guide[0].x;
  float r = sqrt( a*a + b*b ); 
  float angleT  = asin( b / r );
  rotateY(-angleT);
  //------------------------------------------
  
  for(int i = guide.length-1; i>=0;i--)
  {
    PVector p = guide[i];
    pushMatrix();
      translate(c.x-p.x,c.y-p.y,p.z-c.z );
      float alpha = 0.05 * 255 ;
      //fill(255, alpha ) ;
      
      //System.out.println(alpha);
      //box(100,100,1);
      rect(0,0,200,200);
      //sphere(50);
    popMatrix();
      
  }
  popMatrix();
  
  aggiungiPuntoGuida();
  
 
}

void aggiungiPuntoGuida()
{
   for(int i=0;i<guide.length-1;i++)
   {
       guide[i] = guide[i+1];
   }
   
   
   int indiceFunzioneX = (nChiamateFunzione / quandoCambioFunzioneX ) % funzioniPerX.length;
   int indiceFunzioneY = (nChiamateFunzione / quandoCambioFunzioneY ) % funzioniPerY.length;
   nChiamateFunzione++; 
   formulaPerX = funzioniPerX[1];
   formulaPerY = funzioniPerY[1];
   guide[guide.length-1] = new PVector(formulaPerX.calcolami().getData(),formulaPerY.calcolami().getData() , guide[guide.length-1].z - totStartLength/(float)nPunti  );
   angle.setData(angle.getData() + 0.1);
   
   
  
}