void setup()
{
   String[] stringhe = loadStrings("C:/Users/davide/Documents/Visual Studio 2012/Projects/Project3/Debug/output.txt"); 
   
   int w = stringhe[0].split(" ").length;
   int h = stringhe.length;
   
   size(1000,500);
   System.out.println(w+" "+h);
   
   int horStep = width / w;
   int verStep = height / h;
   int i = 0;
   
   for(String el: stringhe)
   {
     String[] numeriRiga = el.split(" ");
     for(int j = 0; j< numeriRiga.length; j++){
         double val = Integer.parseInt(numeriRiga[j]) / 65535.0;
         fill((int)(255 * val));
         rect(0 + horStep * j, 0 + verStep * i, 0 + (j+1)* horStep, 0 + (i+1)*verStep);
          System.out.print(Integer.parseInt(numeriRiga[j])+" ");
     }
     i++;
     
     
     
   }
}
