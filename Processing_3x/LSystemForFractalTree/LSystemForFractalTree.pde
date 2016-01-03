class Rule
{
   String what ;
   String with;
   public Rule(String replaceWhat, String replaceWith)
   {
     what = replaceWhat; with = replaceWith;
   }
   
   public String apply(String base)
   {
     StringBuffer sb = new StringBuffer(""); //<>//
     int i = 0;
     while (i<base.length())
     {
       if(i+what.length()-1 < base.length() &&  base.substring(i,i+what.length()).indexOf(what) != -1)
       {
          sb.append(with);
          i+= what.length();
       }
       else
       {
          sb.append(base.charAt(i)); 
          i++;
       }
       
     }
     return sb.toString();
   }
}

class DisegnatoreGrammatica
{
    ArrayList<PVector[]> linee ;  
  
    public void generaLinee(String toDraw,float lunghezzaSegmenti, float angleRotazioni)
    {
      linee = new ArrayList<PVector[]>();
      
      for(int i=0;i<toDraw.length();i++)
      {
         char c = toDraw.charAt(i);
         switch(c)
         {
            //case 'G':
            case 'F' :
              scale(0.8);
              //
              
              
              PVector a = new PVector(modelX(0,0,0),modelY(0,0,0));
              PVector b = new PVector(modelX(0,0,0),modelY(0,0,0)-lunghezzaSegmenti);
              linee.add(new PVector[]{a,b});
              System.out.println(a.x+" "+a.y+" "+a.z);
              translate(0,-lunghezzaSegmenti);
              
            break;
          
            case '-':
              rotate(-angleRotazioni);
            break;
            case '+':
              rotate(angleRotazioni);
            break;
            case ']':
              popMatrix();
            break;
            case '[':
              pushMatrix();
            break;
         }
      }
      for(PVector[] v : linee)
      {
         pushMatrix();
         translate(v[0].x,v[0].y);
         line(0,0,v[1].x-v[0].x,v[1].y-v[0].y);
         popMatrix();
      }
      
    }
    public void disegna(String toDraw,float lunghezzaSegmenti, float angleRotazioni)
    {
      for(int i=0;i<toDraw.length();i++)
      {
         char c = toDraw.charAt(i);
         switch(c)
         {
            case 'F':
              scale(0.8);
              line(0,0,0,-lunghezzaSegmenti);
              translate(0,-lunghezzaSegmenti);
             
              
            break;
            case 'G':
              scale(0.8);
              line(0,0,0,-lunghezzaSegmenti);
            break;
            case '-':
              rotate(-angleRotazioni);
            break;
            case '+':
              rotate(angleRotazioni);
            break;
            case ']':
              popMatrix();
            break;
            case '[':
              pushMatrix();
            break;
         }
      }
    }
}

Rule rule1;
String actualBase;
DisegnatoreGrammatica disegnatore;
int generazioneAttuale = 1;
int maxGen = 10;

void setup()
{
   rule1 = new Rule("F","F[+F[+G][-G]][-F[+G][-G]]"); //<>//
   actualBase = "F";
   disegnatore = new DisegnatoreGrammatica();
   size(1000,1000,P2D);
   background(255);
   stroke(0);
   strokeWeight(4);
   frameRate(2);
}

void mouseClicked()
{
  actualBase = rule1.apply(actualBase);
 
}

void draw()
{
  
  fill(255,150);
  rect(0,0,width,height);
  pushMatrix();
  translate(width/2,height);
  disegnatore.disegna(actualBase,200,PI/6);//disegna(actualBase,200,PI/6);
  popMatrix();
}