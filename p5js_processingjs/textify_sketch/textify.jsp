<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<title>TEXTIFY</title>
	
	 
	</head>
	
	<body>
		 
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script> 
		<script src="../sorgentiP5JS/p5.min.js" ></script>
		<script src="../sorgentiP5JS/p5.dom.min.js" ></script> 
		 
		
		
		<body style="background-color:rgb(232, 236, 242)">

		    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
		        
		      
		      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
		        <form class="form-inline my-2 my-lg-0">
		          <input class="form-control mr-sm-2"  type="text" id="sentence" placeholder="sentence" style="min-width : 200px;" value="WRITEME">
		         
		         &nbsp;
		          <fieldset>
		          	<legend style="font-size:12px; color:rgba(255,255,255,1.0);">font size</legend>
		          	<input type="range" min="2" max="50" step="1" id="rangePixelsToLetter" />
		          </fieldset>
		           &nbsp;
		           &nbsp;
		          <button class="btn btn-outline-success my-2 my-sm-0" type="button" id="btngenerate">Generate</button>
		          
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           &nbsp;
		           		           &nbsp;
		           		           		           &nbsp;
		           		           		           &nbsp;
		           		           		           &nbsp;  &nbsp;
		           		           		           &nbsp;
		           		           		           &nbsp;  &nbsp;
		           		           		           &nbsp;
		           		           		           &nbsp;
		           		           		           &nbsp;&nbsp;
		           &nbsp;
		        	<font style="font-style:italic; font-size:15px;" color="white">Write your sentence and drop an image. Chose pixel size. Then generate! </font>
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
	var righe=[];
	var dimensionePixelToLetter=10;
	var input1;
	var parole=[];
	var coloriParole=[];
	var inputParola;
	var parolaDaUsare="WRITEME";
	var inputCheckbox1;
	var checked1;
	var originalImageFile;
	var immagineWidth;
	var immagineHeight;
	
	
	
	
	
	 
	
	
	
	$(function(){
		
		/*cambio sentence aggiorno valore variabile che mappa */
		$("#sentence").on("change",function(evt){
			parolaDaUsare = $(this).val();
		});
		
		/*lo stesso per il range */
		$("#rangePixelsToLetter").val(dimensionePixelToLetter);
		$("#rangePixelsToLetter").attr("title",dimensionePixelToLetter);
		$("#rangePixelsToLetter").on("change",function(){
			var valScelto = +($(this).val());
			dimensionePixelToLetter = valScelto;
			$("#rangePixelsToLetter").attr("title",dimensionePixelToLetter);
		});
		
		/*metto handler sul bottone genera */
		$("#btngenerate").on("click",function(evt){
			if(immagine == undefined || immagine == null)
			{
				alert("Drag an image in the black box");
				return;
			}
			if(parolaDaUsare.trim().length == 0)
			{
				alert("Write some words in the sentence box");
				return;
			}
			
			/*ci sta tutto, quindi posso generare */
			$("body").css("cursor","wait");	
			setTimeout(function(){  
				
				resizeCanvas(immagine.width,immagine.height,false); /*fai resize del canvas per farlo essere grande quanto immagine (non chiamare il redraw) */
				image(immagine, 0, 0); 
				computeFunz(); //lancia la trasformazione	
				centerCanvas();
				$("body").css("cursor","default");

			},2000);
			
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
					break;
			case 1:
					//background(0);
					 
					image(immagine,0,0);
					
					//window.scrollBy(0,200);
		}
		noLoop();
	} 
	 
	
	
	function centerCanvas() {
		  var x = (windowWidth - width) / 2;
		  
		  canvas.position(x, canvas.y);
	}
	
	function gotfile(c)
	{
		if("image" === c.type)
		{
			immagine=createImg(c.data).hide();
			immagine.attribute("crossorigin","Anonymous"); /*per evitare tainted canvas quando uso image() per disegnare immagine sul canvas */
			//image(immagine, 0, 0);
			stato = 1;
			setTimeout(function(){ /*altrimenti parte prima che effettivamente ce la fa a scaricarsi immagine */
				resizeCanvas(immagine.width,immagine.height,false ); /*parte draw */
				centerCanvas();
			},1000);
			
			//loop();
					
		}
		 
	}
	

	function getIntensityAt(c,b,d,a){
		return pixels[4*(b*d*width*d+c*d)+a]
	};
	
	function computeFunz()
	{
		parole=[];
		righe=[];
		coloriParole=[];
		//immagine=createImg(originalImageFile.data).hide();
		//image(immagine);
		loadPixels();
		for(var c=pixelDensity(),b=0;b<height;b+=dimensionePixelToLetter)
		{
			for(var d=[],a=0;a<width;a+=dimensionePixelToLetter)
			{
				for(var e=0,f=0,g=0,h=0;h<dimensionePixelToLetter;h++)
					for(var k=0;k<dimensionePixelToLetter;k++)
						try
						{
							e+=getIntensityAt(a+k,b+h,c,0),
							f+=getIntensityAt(a+k,b+h,c,1),
							g+=getIntensityAt(a+k,b+h,c,2)
						}
						catch(l)
						{
							console.log(l)
						}
						e/=dimensionePixelToLetter*dimensionePixelToLetter;
						f/=dimensionePixelToLetter*dimensionePixelToLetter;
						g/=dimensionePixelToLetter*dimensionePixelToLetter;
						try
						{
							d[Math.floor(a/dimensionePixelToLetter)]={x:e,y:f,z:g}
						}
						catch(l){}
			}
			righe.push(d);
			updatePixels()
		}
		
		for(b=0;b<righe.length;b++)
			for(a in d=righe[b],d)
				try
				{
					fill(d[a].x,d[a].y,d[a].z),
					rect(a*dimensionePixelToLetter,b*dimensionePixelToLetter,dimensionePixelToLetter,dimensionePixelToLetter)
				}
				catch(l){}
		console.log("TERMINATO CREATE MACROPIXELS");
		updatePixels();
		for(b=a=d=0;b<height;b+=dimensionePixelToLetter)
		{
			a= checked1?0:a;
			f=e=0;
			parole[d]="";
			coloriParole[d]=[];
			for(g=parolaDaUsare;e<width;)
				coloriParole[d][f]={x:getIntensityAt(e,b,c,0),y:getIntensityAt(e,b,c,1),z:getIntensityAt(e,b,c,2)},
				h=g[a%g.length],
				a+=1,
				parole[d]+=h,
				e+=dimensionePixelToLetter,f++;d++
		}
		loadPixels()
		textAlign(LEFT);
		textSize(dimensionePixelToLetter);
		background(0);
		for(b=c=0;b<parole.length;b++)
		{
			d=parole[b];
			try
			{
				for(e=a=0;e<d.length;e++)
					stroke(coloriParole[c][a].x,coloriParole[c][a].y,coloriParole[c][a].z),
					fill(coloriParole[c][a].x,coloriParole[c][a].y,coloriParole[c][a].z),
					text(d[e]+"",a*dimensionePixelToLetter,(c+1)*dimensionePixelToLetter),
					a++;c++
			}catch(l){}
		}
				stato=2
	}

	 
	</script>	
	
	</body>
	
</html>