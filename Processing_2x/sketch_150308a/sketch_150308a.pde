
//gli input dagli slider dovrebbero sempre arrivare normalizzati tra 0 e 1
//tutte le funzioni dei pennelli, anche i costruttori, prendono i valori tra 0 e 1, e li moltiplicano internamente per denormalizzarli
//l'input del colore arriva come esadecimale senza # e viene convertito in rgb (a meno che non si usi colore random e in quel caso vengono generate le componenti rgb)

abstract class Pennello
{
  public float maxSize;
  public float minSize;
  public int segnoPulse = 1;
  
  public boolean attivo = false;
  public float xc,yc,size,incrementoRotazione;
  public float angle;
  public float incrementoPulse;
  
  
  int rF,gF,bF,rS,gS,bS;
  public boolean activeFill = false;
  public boolean activeStroke = true;
  public boolean randomFillColor = false;
  public boolean randomStrokeColor = false;

  public abstract void disegna();
  public abstract void seguiMouse();
  public abstract void ruota();
  public abstract void pulsa();
  public abstract void resetPosizionePennello();
  
  
  public abstract void aggiornaSize(float size);
  public abstract void aggiornaIncrementoPulse(float nuovo);
  public abstract void aggiornaIncrementoRotazione(float nuovo);
 
 
 
  public void attiva() { attivo = true; }
  public void disattiva() {attivo = false; }
  public void aggiornaColoreFill( int r,int g,int b) {  rF= r; gF=g; bF=b;  }
  public void aggiornaColoreStroke(int r,int g,int b) {  rS= r; gS=g; bS=b; }
  public void attivaFill() {activeFill = true; }
  public void disattivaFill() {activeFill = false;}
  public void attivaStroke() {activeStroke = true;}
  public void disattivaStroke() {activeStroke = false;}
  public void attivaRandomFillColor() {randomFillColor = true; }
  public void disattivaRandomFillColor() {randomFillColor = false; }
  public void attivaRandomStrokeColor() {randomStrokeColor = true; }
  public void disattivaRandomStrokeColor() {randomStrokeColor = false; }  
  
  
}

public class QuadratoRotante extends Pennello
{  
  //costanti usate per denormalizzare l'input che è tra 0 e 1
  public static final float MAX_ROTAZIONE = 1.0f;
  public static final float MAX_PULSE = 0.5f;
  public static final float MAX_SIZE = 500;
  
  
  
  public QuadratoRotante(float xc,float yc,float size,float incrementoRotazione,float incrementoPulse,int rF,int gF,int bF,int rS,int gS,int bS)
  {  
    this.xc = xc; this.yc = yc; this.size = MAX_SIZE * size; this.incrementoRotazione = MAX_ROTAZIONE * incrementoRotazione; this.incrementoPulse = MAX_PULSE * incrementoPulse;
    maxSize = 2 * this.size;
    minSize = this.size * 0.5;
    this.rF= rF; this.gF= gF; this.bF = bF;
    this.rS = rS; this.gS = gS; this.bS = bS;
  }
  
 
  
  public void aggiornaIncrementoPulse(float nuovo)
  {
    incrementoPulse = MAX_PULSE * nuovo;
  }
  
  
  public void aggiornaIncrementoRotazione(float nuovo)
  {
     incrementoRotazione = MAX_ROTAZIONE * nuovo; // l'incremento di questa specifica forma sarà tra 0 e 0.2
  }
  
  
  public void aggiornaSize(float size)
  {
     this.size = size * MAX_SIZE;  //il size di questa specifica forma sarà tra 0 e 1000
     maxSize = this.size * 2;
     minSize = this.size * 0.5;
     segnoPulse = 1;
  }
  
  
  
  public void disegna()
  {
    if(!attivo)
        return;
    if(activeStroke)
    {
     if(randomStrokeColor)
         stroke(random((angle % 6)*100 +10 ),random((angle % 6) *100+10),random((angle % 6) *100+10),255); //questo pennello, genera in questo modo i colori random
     else
         stroke(rS,gS,bS);
    }
    else
      noStroke();
      
    if(activeFill)
    {
      if(randomFillColor)
        fill(random((angle % 6)*100 +10 ),random((angle % 6) *100+10),random((angle % 6) *100+10),50);
      else
        fill(rF,gF,bF);
    }
    else
     noFill(); 

    pushMatrix();
      translate(xc,yc);
      rotate(angle);
      rectMode(CENTER);
      rect(0,0,size,size);
    popMatrix();
      
  }
  
  public void ruota()
  {
    angle = angle + incrementoRotazione;
    
  }
  
  public void pulsa()
  {
    if(size > maxSize)
    {
    segnoPulse = -1; 
  }
  if( size < minSize )
  {
    size = minSize;
    segnoPulse = +1;
  }
  
    size = size + segnoPulse * size * incrementoPulse;
  }
  
  
  public void resetPosizionePennello()
  {
    angle = 0.0f;
    segnoPulse = 1;
    size = minSize * 2 ; 
  }
  
  public void seguiMouse()
  {  
     
    this.xc = mouseX;
    this.yc = mouseY;
  }
   
  
  public void attiva() { attivo = true; }
  public void disattiva() {attivo = false; }
  public void attivaFill() {activeFill = true; }
  public void disattivaFill() {activeFill = false;}
  public void attivaStroke() {activeStroke = true;}
  public void disattivaStroke() {activeStroke = false;}
}


ArrayList<Pennello> pennelli = new ArrayList<Pennello>();




/* queste funzioni sono chiamate da javascript nella pagina per modificare stato dei pennelli ------------------------------------------*/
public void attivaPennello(int i)
{
    pennelli.get(i).attiva();
}

public void disattivaPennello(int i)
{
  pennelli.get(i).disattiva();
}

public void aggiornaSizePennello(int i,int size)
{
  pennelli.get(i).aggiornaSize(size);
  
}
 
public void aggiornaIncrementoPulsePennello(int i,float nuovo)
{
   pennelli.get(i).aggiornaIncrementoPulse(nuovo); 
}


public void aggiornaIncrementoRotazionePennello(int i,float nuovo)
{
  pennelli.get(i).aggiornaIncrementoRotazione(nuovo);
}

public void aggiornaColoreStrokePennello(int i,int r,int g,int b)
{
  pennelli.get(i).aggiornaColoreStroke(r,g,b);
}

public void aggiornaColoreFillPennello(int i,int i,int r,int g,int b)
{
  pennelli.get(i).aggiornaColoreFill(r,g,b);
}

 public void attivaFillPennello(int i) 
 {
   pennelli.get(i).attivaFill();
 }
 
 public void disattivaFillPennello(int i) 
 {
   pennelli.get(i).disattivaFill();
 } 
 
 public void attivaStrokePennello(int i) 
 { 
   pennelli.get(i).attivaStroke();
 }
 
 public void disattivaStrokePennello(int i) 
 { 
   pennelli.get(i).disattivaStroke();
 }

public void pulisciSchermo()
{
  background(0);
}

public void attivaRandomFillColorPennello(int i)
{
   pennelli.get(i).attivaRandomFillColor(); 
}

public void disattivaRandomFillColorPennello(int i)
{
   pennelli.get(i).disattivaRandomFillColor(); 
}

public void attivaRandomStrokeColorPennello(int i)
{
   pennelli.get(i).attivaRandomStrokeColor(); 
}

public void disattivaRandomStrokeColorPennello(int i)
{
   pennelli.get(i).disattivaRandomStrokeColor(); 
}



/*-------------------------------------------------------------------------------------------*/


void setup()
{
   size(1000,400);
   background(0);
   pennelli.add(new QuadratoRotante(200,200,20/100,20/100,0.0,255,255,255,255,255,255));
   /*pennelli.get(0).attiva();
   pennelli.get(0).attivaRandomStrokeColor();
   pennelli.get(0).attivaFill();
   pennelli.get(0).attivaRandomFillColor();*/
   
   pennelli.add(new QuadratoRotante(200,200,20/100,20/100,0.0,255,255,255,255,255,255));
   //pennelli.get(1).attiva();
   
   
}


void draw()
{
   for (Pennello pen : pennelli )
   {
       pen.seguiMouse();
       
       
       if(mousePressed)
       {
          pen.ruota();
          pen.pulsa();
          pen.disegna();
         
       }
       else
       {
          pen.resetPosizionePennello();
       }
   }
}






