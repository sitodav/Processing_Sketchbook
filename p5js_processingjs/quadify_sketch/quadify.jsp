<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<title>TEXTIFY</title>
	
	 
	</head>
	
	<body>
		 
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
		<script src="sorgentiP5JS/p5.min.js" ></script>
		<script src="sorgentiP5JS/p5.dom.min.js" ></script> 
		 
		
		
		<body style="background-color:rgb(232, 236, 242)">

		    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		        
		      
		      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
		        <form class="form-inline my-2 my-lg-0">
		          
		          
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp; 
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;  &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           		           &nbsp;
		           &nbsp;
		           <button class="btn btn-outline-success my-2 my-sm-0" type="button" id="btngenerate">Generate</button>
		           &nbsp; &nbsp;
		           <input type="checkbox" id="check_riempimento"/><font color="white">&nbsp;filling</font>
		        	&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
		           		           		           &nbsp; 
		        	<font style="font-style:italic; font-size:15px;" color="white">Drop an image and generate recursive quads! </font>
		        </form>
		        
		      </div>
		      
		      
		      
		      
		    </nav>
		
		    
		
		     
		
		      <hr>
			
		</body>
		
		
		
		
	<script >
	
	 
	
	var link0 = ""; /*qui link immagine arrivata */
	var canvas; /*canvas che creo con p5js*/
	/*setup di p5js che parte all'avvio */
	var stato=0;
	var immagine;
	var bot;
	var originalImageFile;
	var immagineWidth;
	var immagineHeight;
	
	var canvas;
    var img;
    var rects = [];
    var index = 0;
    var max_recur = 11 ;
    var sogliaMinimaPuntiNeri = 15;
    var sogliaMassimaGrey = 120;
    var conRiempimento = false;
	
	//var indiceLastDisegnato = 0;
	
	
	
	$(function(){
		
		
		
		$("#check_riempimento").on("change",function(){
			conRiempimento = $(this).prop("checked")+"" == "true";
		});
		/*metto handler sul bottone genera */
		$("#btngenerate").on("click",function(evt){
			if(img == undefined || img == null)
			{
				alert("Drag an image in the black box");
				return;
			}
			
			/*ci sta tutto, quindi posso generare */
			$("body").css("cursor","wait");	
			setTimeout(function(){  
				//indiceLastDisegnato = 0;
                resizeCanvas(img.width,img.height,false); /*fai resize del canvas per farlo essere grande quanto immagine (non chiamare il redraw) */
				centerCanvas();
				image(img, 0, 0); 
				loadPixels();

			},2000);
			setTimeout(function(){
				rects = [];
				computeFunz(); //lancia la trasformazione	
				$("body").css("cursor","default");
			},4000);			
		});
		 
		
	});
	
	
	function setup()
	{
		var br0 =document.createElement("br");
		$("body").append($(br0).clone());
		$("body").append($(br0).clone());
		$("body").append($(br0).clone());
		
		canvas=createCanvas(600,600); /*creo canvas */
		canvas.drop(gotfile);
		canvas.id( "miocanvas");
		centerCanvas();
		pixelDensity(1);
	}
	
	
	
	 
	function draw()
	{
		switch(stato){
			case 0:
					background(0);
					fill(255);
					textSize(21);
					textAlign(CENTER);
					text("DRAG & DROP IMAGE HERE", (width/2),(height/2));

					noLoop();
					break;
			case 1:
					//background(0);
					 
					image(img,0,0);
					
					//window.scrollBy(0,200);

					noLoop();
					break;
			/*case 2 :
				if(indiceLastDisegnato >= rects.length)
				{
					return;
					noLoop();
				}
				else
				{
					var rec = rects[indiceLastDisegnato];
					var minalpha = rec.grey > 220 ? 220 : rec.grey;
					fill(rec.grey,((255-minalpha)/255.0) * 25);
					stroke(rec.grey,((255-minalpha)/255.0) * 255);
					//noFill();
					rect(rec.punto.x,rec.punto.y,rec.width,rec.height);
					indiceLastDisegnato++;
					frameRate(frameRate()+10);
				}
		      */  
		        
				
		}
	} 
	 
	
	
	function centerCanvas() {
		  var x = (windowWidth - width) / 2;
		  
		  canvas.position(x, canvas.y);
	}
	
	function gotfile(c)
	{
		if("image" === c.type)
		{
			img=createImg(c.data).hide();
			img.attribute("crossorigin","Anonymous"); /*per evitare tainted canvas quando uso image() per disegnare img sul canvas */
			//image(immagine, 0, 0);
			stato = 1;
			setTimeout(function(){ /*altrimenti parte prima che effettivamente ce la fa a scaricarsi immagine */
				resizeCanvas(img.width,img.height,false ); /*parte draw */
				centerCanvas();
			},1000);
			
			//loop();
					
		}
		 
	}
	
 
	
	function computeFunz()
    {
        trasformaCanvasInGrigio();

        var pa = new Punto(1,1);
        var pb = new Punto(width-1,0);
        var pc = new Punto(width-1,height-1);
        var pd = new Punto(0,height-1);
        
        var deepcopy = [];
        for(var k = 0; k<pixels.length;k++)
        {
            deepcopy.push(pixels[k]);
        }
        
        quad_recurs(pa,pb,pc,pd,deepcopy,0);
        //updatePixels();
        background(255);
        for(var i in rects)
        {
            var rec = rects[i];
			var minalpha = rec.grey > 220 ? 220 : rec.grey;
            if(conRiempimento)
            {
            	fill(rec.grey,((255-minalpha)/255.0) * 25);	
            }
            else
            {
            	noFill();
            }
			stroke(rec.grey,((255-minalpha)/255.0) * 255);
			rect(rec.punto.x,rec.punto.y,rec.width,rec.height);
        }
        
		stato= 2;        
    }
    
    function quad_recurs(pa,pb,pc,pd,original_pixels_buff,recurs_lvl)
    {
        
        pa.x = +pa.x;
        pa.y = +pa.y;
        pb.x = +pb.x;
        pb.y = +pb.y;
        pc.x = +pc.x;
        pc.y = +pc.y;
        pd.x = +pd.x;
        pd.y = +pd.y;
        
        if( recurs_lvl > max_recur)
            return;
        
        
            var grigio_avg = 0;
            index++;
            
            var totali = 0;
                 
            
            for(var indy = pa.y; indy <= pd.y ; indy++)
            {
                for (var indx = pa.x; indx <= pb.x; indx++)
                {
                    var grey =  original_pixels_buff[(indy * width + indx) * pixelDensity()*4];
                    
                    grigio_avg += (grey != undefined && grey < 255 && grey > 0 ? grey : 0);
                    
                    if( grey < sogliaMassimaGrey)
                    {
                        totali++;
                        //fill(125,125,125);
                        //stroke(125,125,125);
                        //ellipse(indx,indy,5,5);
                     
                    }    
                }
            }
            
            
            if(totali  > sogliaMinimaPuntiNeri )
            {
            	grigio_avg =grigio_avg / ((pd.y - pa.y) * (pb.x - pa.x));
                //noStroke();
                //stroke(0);
                 //fill(+grigio_avg);
                //rect(pa.x,pa.y,pb.x-pa.x-1, pd.y - pa.y-1);
            
                rects.push(
                        {
                            punto : pa
                            ,width : (pb.x-pa.x-1 )
                            ,height : (pd.y - pa.y-1 )
                            ,grey : grigio_avg
                        });
            	
            	var acWd2 = parseInt((pb.x - pa.x )/ 2);
                var acHd2 = parseInt((pc.y - pb.y ) /2 ) -1 ;
                 
                
                for(var i = 0; i<2; i++)
                {
                    for(var j = 0; j<2;j++)
                    {
                        var pa0 = new Punto(pa.x+ j*acWd2 , pa.y + i*acHd2 );
                        var pb0 = new Punto(pa0.x+ acWd2 ,pa0.y );
                        var pc0 = new Punto(pb0.x,pb0.y + acHd2 );
                        var pd0 = new Punto(pa0.x, pa0.y + acHd2   );
                        quad_recurs(pa0,pb0,pc0,pd0,original_pixels_buff,recurs_lvl+1);
                    }
                }	
            }
            
        
    }
    
    
    
    
    function trasformaCanvasInGrigio()
    {
        for(var y = 0; y < height; y++)
        {
            for (var x = 0; x < width; x++)
            {
                var r = pixels[y * width * pixelDensity() * 4 + x*pixelDensity() * 4 + 0];
                var g = pixels[y * width * pixelDensity() * 4 + x*pixelDensity() * 4 + 1];
                var b = pixels[y * width * pixelDensity() * 4 + x*pixelDensity() * 4 + 2];
                var grey = (r+g+b) * 0.33;
                 
                set(x,y,color(grey));
            }
        }
        updatePixels();
    }
    
    
    function Punto(x,y)
    {
        this.x = x;
        this.y = y;
    }
	 
	</script>	
	
	</body>
	
</html>