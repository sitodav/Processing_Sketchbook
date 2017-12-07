void setup()
{
  size(500, 500);
  background(255);
  HashMap<String, String> rules = new HashMap<String, String>();
  rules.put("E","(-LE)(+LE)");
 
  //System.out.println(processaStringa(rules,t,2));
  toDraw = processaStringa(rules,toDraw,6);
}

String toDraw = "(EE)";
float lunghezza=40;
void draw()
{
  translate(width/2,height/2);
  background(255);
  disegnaStringa(toDraw,lunghezza);
  rotate(PI/2);
  disegnaStringa(toDraw,lunghezza);
  rotate(-PI);
  disegnaStringa(toDraw,lunghezza);
  
}

void disegnaStringa(String toDraw,float size)
{
   
   int maxParOpen = 0;
   int t = 0;
   int nParOpen = 0;
   
   for(int i=0;i<toDraw.length();i++)
   {
     if(toDraw.charAt(i) == '(')
     {
         t++;
     }
     else if(toDraw.charAt(i) == ')')
     {
       t--;
     }
     if(t > maxParOpen)
     {
        maxParOpen = t; 
     }
   }
   
   for(int i=0;i<toDraw.length();i++)
   {
      
     float tu = ( 1.0-((float)nParOpen/(float)maxParOpen) );
      switch(toDraw.charAt(i))
      {
         case 'L':
         {
          // stroke(0,255* tu-100 );
           stroke(0);
           fill(250,50);
           line(0,0,0,-size);
           noFill();
          // ellipse(0,0,6*tu*size,6*tu*size);
           translate(0,-size);
           break; 
         }
         case '-':
         {
           rotate(-PI/6);
           break; 
         }
         case '+':
         {
           rotate(PI/6);
           break; 
         }
         case '(':
         {
           nParOpen++;
           pushMatrix();
           break; 
         }
         case ')':
         {
           nParOpen--;
           popMatrix();
           break; 
         }
      }
        
      
   }
   
}

String processaStringa(HashMap<String, String> rules, String toProc, int lvlRim)
{
  if (lvlRim == 0)
    return toProc;
  for (String rule : rules.keySet())
  {
    toProc = toProc.replaceAll(rule, rules.get(rule));
  }

  return processaStringa(rules, toProc, lvlRim-1);
}