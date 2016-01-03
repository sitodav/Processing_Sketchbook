void setup()
{
   size(1000,1000);
   background(0); 
   strokeWeight(2.5);
   stroke(255,255);
}

int maxFigli = 10;
int maxLivelli = 10;
ArrayList<ArrayList<PVector>> nodiAlbero = new ArrayList<ArrayList<PVector>>();
int sizeNodo = 10;
int spaziaturaMin = 5;

void draw()
{
    
    background(0);
    int yDist = mouseY;
    int xDist = mouseX;
    
    int nFigli = (int)(maxFigli * (xDist / (float)width));
    int nLivelli =(int) (maxLivelli * (yDist / (float)height));
    
    nodiAlbero.clear();
    //System.out.println("n livelli : "+nLivelli);
    for(int i=1;i<=nLivelli;i++)
    {
       
       nodiAlbero.add(new ArrayList<PVector>() );
       //System.out.println((width/(sizeNodo+2*spaziaturaMin))+" "+(int)pow(nFigli,i));
//       if( (width/(sizeNodo+2*spaziaturaMin)) >= (int)pow(nFigli,i) )
//       {
           System.out.println("SI");
           for(int j=1;j<=(int)pow(nFigli,i-1);j++)
           {   int spaziatura = width / ( (int)pow(nFigli,i-1)+1 );
               int xNodo = (j) * spaziatura;
               int yNodo = (i-1) * (height/nLivelli);  
               
               nodiAlbero.get(nodiAlbero.size()-1).add( new PVector((int)xNodo,(int)yNodo));
           }
    //   } 
    }
    //System.out.println("albero a " + nodiAlbero.size());
    int nLivello = 0;
    for(ArrayList<PVector> livello : nodiAlbero)
    {  
        
       int nNodo = 0;
       for(PVector nodo : livello)
       {
         if(nLivello == 0) // radice
           point((int)nodo.x,(int)nodo.y);
          else
          {
            //chi è il nodo padre ?
            int indNodoPadre = nNodo / nFigli;
            PVector nodoPadre =  nodiAlbero.get(nLivello-1).get(indNodoPadre);
            line( (int)nodoPadre.x,(int)nodoPadre.y,(int)nodo.x,(int)nodo.y );
          } 
          
          nNodo ++;
       }
      nLivello++; 
    }
    
    
    
    
}


