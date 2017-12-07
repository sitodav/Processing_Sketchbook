import java.util.HashMap;
import java.util.ArrayList;

//***********************************************************************************************
//***********************************************************************************************
//***********************************************************************************************



 

//***********************************************************************************************
//***********************************************************************************************
//***********************************************************************************************
PVector pl = null;
int spintaGravity = 0;
float angleX = 0.0f, angleY = 0.0f;
float spost = 50;


ArrayList<Livello> livelli = new ArrayList<Livello>();


HashMap<Integer,Boolean> keyCodeEvents = new HashMap<Integer,Boolean>();
HashMap<Short,Boolean> keyEvents = new HashMap<Short, Boolean> ();
HashMap<String,UrlPagina> crawledPages; //chiavi gli url delle pagine che abbiamo FISICAMENTE visitato (crawled)

//***********************************************************************************************
//***********************************************************************************************
//***********************************************************************************************




void svuotaCrawledPages()
{
	
	crawledPages.clear();
}

void aggiungiCrawledPage(String urlPagina,String[] links) //ATTENZIONE, JS GLI PASSA UN ARRAY MA SI ACCEDE CON NOTAZIONE JS IN JAVA (NON SO PERCHE' CON ARRAY[CHIAVE] )
{															//QUESTO PER LE STRUTTURE DATI PASSATE DA JS ALLO SKETCH (PER TUTTE LE ALTRE NO)
	
	
	
	UrlPagina nuovaCrawled = new UrlPagina(urlPagina);
	
	ArrayList<String> tempUrls = new ArrayList<String>();
	for(String urlK : links)
	{	
		
		nuovaCrawled.addPaginaRaggiungibile(urlK);
	}
	
	crawledPages.put(urlPagina,nuovaCrawled);
	//e aggiungo tutte le raggiungibili, se non esistevano già (quando le aggiungo la prima volta si suppone non siano state visitate
	//quindi esse non avranno le informazioni sulle pagine che da queste si possono raggiungere...
	for(String urlK : links)
	{
		if(!crawledPages.containsKey(urlK)) //visto che sto aggiungendo come pagina raggiungibile, e non come pagina crawled, se già esiste non posso sovrascriverla poichè potrei perdere info sulla stessa pagina inserita perchè crawled
		{
			UrlPagina tPag = new UrlPagina(urlK);
			crawledPages.put(urlK,tPag);
		}
	}
	
	
	//printMsg("----------------IO SKETCH HO RICEVUTO STRUTTURA NUOVA PAGINA CRAWLED: "+urlPagina+"\n");
	//printMsg("----------------FINO AD ORA LE PAGINE INDICIZZATE SONO:\n");
	//Stampiamo in console browser riassunto della struttura
	for(String urlPag : crawledPages.keySet())
	{
		String msg = "per :";
		UrlPagina pag = crawledPages.get(urlPag);
		msg+=pag.url+" le raggiungibili sono : ";
		for(String t : pag.raggiungibiliDaQuesto.keySet())
		{
			msg+="["+t+"]";
		}
		printMsg(msg);
	}
}

void setup()
{
    size(1000,700,P3D);
    background(0);
    rectMode(CENTER);
    pl = new PVector(width/2,100 +height/2,-1.0);
    mv = new PVector(0,0,0);
    crawledPages = new HashMap<String,UrlPagina>();
    
          
     for(int i=0;i<2;i++)
     { float offx = 0;
       if(i==0)
       {
           offx = 0;
       }
       else
       {
           offx = -1 * random(6000);
       }
       PVector fl = new PVector(-200 + offx ,0, (i+1)*-10000 ), fr = new PVector(200 + offx,0, (i+1) * -10000), nl = new PVector(-200 + offx ,0, -1 *i*10000 - 4000 ), nr = new PVector(200 + offx,0, -1*i * 10000 - 4000 );    
       //System.out.println(nr.z);
       livelli.add(new Livello(fl,fr,nl,nr,20));
     }
     
}
	

/*
void mouseMoved()
{
   angleY = 0.3*2*PI* (mouseX - width/2) /  (float)(width/2);
   angleX = 0.3*2*PI * (mouseY - height/2) / (float)(height/2);
}*/

PVector mv;

void draw()
{  background(0);
   keyBuffering();

   checkGravity();
   pushMatrix();
    translate(pl.x,pl.y,pl.z);
    
     
    
    
   pushMatrix();
     //rotateX(-PI*0.5);
     rotateX(angleX);
     rotateY(angleY);
     
     translate(-mv.x,mv.y,-mv.z);
     
     //rotateX(angleX);
     fill(255);
     //rect(0,0,400,2000);
     //disegnaLivello();
     
          for(Livello  liv : livelli)
	     {
	      
	       liv.disegna();
	             
	     }
     
   popMatrix();
   
   
   
   popMatrix();
}

/*
void disegnaLivello()
{
  float xOff = floorWidth / celleFloor;
  float yOff = floorHeight / celleFloor;
  noFill();
  stroke(0,255,0);
  
  for(int i = -(int)(celleFloor * 0.5); i<(int)( celleFloor * 0.5); i++)
  {
     
     for(int j= - (int)(celleFloor * 0.5); j< (int)(celleFloor * 0.5); j++)
     {
          //rect(j* xOff + xOff*0.5, i*yOff + yOff * 0.5, xOff,yOff);   
         beginShape();
            vertex(j*xOff,0,i*yOff);
            vertex((j+1)*xOff, 0 ,i*yOff);
            vertex((j+1)*xOff,0,(j+1)*yOff);
            
            //vertex(j*xOff,0,(i+1)*yOff);
            
         endShape(); 
     } 
  }
  
}*/
 
void keyBuffering()
{
 
   float t = spost * cos(angleY);
   float t2 = spost * cos(0.5*PI - angleY);
   float t3 = spost * cos(PI*0.5 - angleY);
   float t4 = spost * cos(angleY);
  
    
    
    for(Integer tKeyCode : keyCodeEvents.keySet() )
    {   
          if( (int)tKeyCode == UP)
          {
            angleX = angleX < (PI/5.0f) ? angleX + 0.05 : angleX ;
            
          }
          if((int)tKeyCode==DOWN)
          {
            angleX = angleX > -(PI/5.0f) ? angleX - 0.05 : angleX ;
          }
          if((int)tKeyCode==LEFT)
          {
            angleY -= 0.1;
          }
          if((int)tKeyCode==RIGHT)
          {
            angleY += 0.1;
          }
          
          
    }      
        
    for(Short tKeyStr : keyEvents.keySet() )
    {    
            char tKey = (char)tKeyStr;
            if(tKey== 'w' || tKey== 'W')
            { 
              mv.z -= t; mv.x +=t2; 
            }
            if(tKey== 's' || tKey== 'S')
            { 
              mv.z += t; mv.x -=t2; 
            }
            if(tKey== 'a' || tKey== 'A')
            { 
              mv.z -= t3; mv.x -=t4; 
            }
            if(tKey== 'd' || tKey== 'D' )
            { 
              mv.z += t3; mv.x +=t4; 
            }
            if(tKey == ' ')
            { float yPavimento = 0;
              
              if((int)mv.y == (int)yPavimento)
              {
                 
                 
                mv.y = yPavimento;
                spintaGravity = 60;
              }
            }   
   }  
        
        
  
}


void checkGravity()
{
  
      
  
    float yPavimento = 0;
     
    mv.y += spintaGravity;
    spintaGravity--;
    if(  mv.y < yPavimento + 1)
    {
       spintaGravity = 0;
      mv.y = yPavimento; 
    }
}
  

void keyPressed() //per gli special soltanto parte
{
//      if(key==CODED)
        keyCodeEvents.put(keyCode,true);
//      else
//        keyEvents.put(key+"",true);    
}


void keyReleased() //per gli special soltanto parte
{
//      if(key==CODED)
        keyCodeEvents.remove(keyCode);
//      else
//        keyEvents.remove(key+"");    
}

//per i non special, dobbiamo chiamarlo da javascript 

public void keyPressedNonSpecialDaJs(String key)
{
	 //key = key.toLowerCase();
	 keyEvents.put(key+"",true);

}

public void keyReleasedNonSpecialDaJs(String key)
{

	// key = key.toLowerCase();
	 keyEvents.remove(key+"");

}


/*************************************************************************************/

/****************************************************************************************/



//***********************************************************************************

class UrlPagina
{
	public String url;
	HashMap<String,Boolean> raggiungibiliDaQuesto = new HashMap<String,Boolean>(); //chiave: url pagina raggiungibile, valore : textvis della pagina raggiungibile
	
	public UrlPagina(String url)
	{
		this.url = url;
	}
	public void addPaginaRaggiungibile(String url)
	{
		//printMsg("aggiungo "+url+" "+textVis);
		raggiungibiliDaQuesto.put(url, true);
	}
}


//***********************************************************************************
class Livello
{
  public PVector farLeft, farRight, nearLeft,nearRight;
  int nPunti;
  public Livello(PVector farLeft, PVector farRight, PVector nearLeft, PVector nearRight,int nPunti)
  {
    this.farLeft = farLeft; this.farRight = farRight; this.nearLeft = nearLeft; this.nearRight = nearRight;
    this.nPunti = nPunti;
  }
  
  public void disegna()
  {
     noFill();
     stroke(0,255,0);
     
   
     
     pushMatrix();
        
        PVector center = new PVector( 0.5*( farRight.x + farLeft.x), 0, 0.5 * (farLeft.z + nearLeft.z) );
        //System.out.println(nearLeft.z);
       
       translate(center.x,center.y,center.z);
       // translate(center.x,0,-4000);
        float stepZ = (+farLeft.z - nearLeft.z) / (float)nPunti;
        float stepX = (farRight.x - farLeft.x) / (float)nPunti;
        //System.out.println("fl: "+farLeft+" nl: "+nearLeft+" stepZ"+stepZ);
        
        for(int i= (int)(-nPunti * 0.5);i<= (int)(nPunti * 0.5); i++)
        {
          for(int j=(int)(-nPunti * 0.5); j<=(int)(nPunti*0.5);j++)
          {
             
            //translate(j*stepX + 0.5 * stepX,0,i*stepZ + stepZ * 0.5);
            beginShape();
              //System.out.println(center.z+" "+i*stepZ);
              vertex(j*stepX,0,i*stepZ);
              vertex((j+1)*stepX,0,i*stepZ);
              vertex((j+1)*stepX,0,(i+1)*stepZ);
              vertex(j*stepX,0,(i+1)*stepZ);
            endShape(CLOSE);
                       
          }
        }
        
     popMatrix(); 
  }
  
}
