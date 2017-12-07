 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<script src="../sorgentiP5JS/p5.js"></script>
<script src="../sorgentiP5JS/p5.dom.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

<script>
	
	var canvas;
	var spawned = [];
	var spawner;
	
	
	function Particella(lettera,xc,yc,velocita,moveTo)
	{
		this.bounded = false;
		this.xc = xc; this.yc = yc; this.velocita = velocita;
		this.angleRot = 0;
		this.lettera = lettera;
		//this.lettera = String.fromCharCode(Math.floor(random(97,123))).toUpperCase();
		this.moveTo = moveTo;
		
		this.muovi=function(vectorTo)
		{
			this.angleRot += 0.05;	 
			this.xc += this.velocita.x * (vectorTo.x - this.xc) + random(-1,1) ;
			this.yc += this.velocita.y * (vectorTo.y - this.yc) + random(-1,1);
		}
		this.disegna = function(flag)
		{
			push();
				stroke(255);
				fill( 255 ,125);
				translate(this.xc,this.yc);
				//ellipse(0,0,15,15);
				rotate(this.angleRot);
				text(this.lettera,0,0);
				if(flag)
					console.log(xc,yc);
			pop();
			if(this.bounded)
			{
				stroke(255,0,0,100);
				line(this.xc,this.yc,mouseX,mouseY);
			}
		}
	}
	
	function Spawner(xc,yc,velocita,wordsToSpawn)
	{
		this.xc = xc; this.yc = yc; this.velocita = velocita < 1 ? velocita : 1;
		this.contatore = 0;
		this.MAX_TICKS = 500;
		this.wordsToSpawn = wordsToSpawn;
		this.spawnedParts = []; for(var i in this.wordsToSpawn) this.spawnedParts[i] = "";
		this.spawnedIndexes = []; for(var i in this.wordsToSpawn) {this.spawnedIndexes[i] = ""; /*for(var j=0; j<this.wordsToSpawn[i].length;j++) this.spawnedIndexes[i] += (j+" ");  this.spawnedIndexes[i] = this.spawnedIndexes[i].slice(0,-1)*/ }
		this.clock = function()
		{
			this.contatore++;
			if(this.contatore >= Math.floor(this.MAX_TICKS * (1-this.velocita)) )
			{
				var iParolaToSpawn = Math.floor(random(0,this.wordsToSpawn.length));
				
				if( this.wordsToSpawn[iParolaToSpawn].match(/^_*$/) /*this.wordsToSpawn[iParolaToSpawn].length == 0*/)
				{
					//rimuovo la parola e ne aggiungo una nuova
					this.wordsToSpawn.splice(iParolaToSpawn,1,"RANDOMWORD");
					this.spawnedParts.splice(iParolaToSpawn,1,"");					
				}
				else
				{
					var iLetteraToUse = -1;
					while( true )
					{
							
						var iLetteraToUse = Math.floor(random(0,this.wordsToSpawn[iParolaToSpawn].length));
						if(! (this.wordsToSpawn[iParolaToSpawn].charAt(iLetteraToUse) == '_') )
							break;
						//else console.log(this.wordsToSpawn[iParolaToSpawn].charAt(iLetteraToUse));
					}
					
					var letteraToUse = this.wordsToSpawn[iParolaToSpawn].charAt(iLetteraToUse);
					this.wordsToSpawn[iParolaToSpawn] = (this.wordsToSpawn[iParolaToSpawn].slice(0,iLetteraToUse)+"_"+this.wordsToSpawn[iParolaToSpawn].slice(iLetteraToUse+1)).toUpperCase();

					this.spawnedParts[iParolaToSpawn] += letteraToUse;
					this.spawn(letteraToUse,this.xc + random(-50,50),this.yc + random(-50,50),{x:0.01,y:0.01},{x:random(100,width-100), y:random(100,height-100)});
					
				}
				//console.log(this.wordsToSpawn);
				//console.log(this.spawnedIndexes);
				this.contatore = 0;
			}
		}
		this.spawn = function(lettera,x,y,vel,moveTo)
		{
			spawned.push(new Particella(lettera,x,y,vel,moveTo));
		}
	}
	
	function mouseDragged()
	{
		
		for(var i in spawned)
		{
			var dist = sqrt( (mouseX -  spawned[i].xc) * (mouseX -  spawned[i].xc) + (mouseY - spawned[i].yc) * (mouseY -  spawned[i].yc)  );
			if(dist < 100 && mouseButton == LEFT)
			{
				spawned[i].bounded = true;
			}
		}
		return false;
	}
	
	function mouseReleased()
	{
		for(var i in spawned)
		{
			spawned[i].bounded = false;
		}
	}
	
	
	function setup()
	{
		
		canvas = createCanvas(windowWidth,windowHeight);
		spawner = new Spawner(width/2.0,height/2.0,0.6,['CICCIA','PAPPA','CANE','CAVALLO','MUSICA']);
		background(0);
		ellipseMode(CENTER);
		textSize(22);
	}
	
	function draw()
	{
		
		//background(0);
		fill(0,100);
		rect(0,0,width,height);
		
		
		for(var i in spawned)
		{
			
			spawned[i].muovi(spawned[i].bounded ? {x: mouseX, y: mouseY } : spawned[i].moveTo);
			spawned[i].disegna(false);
		}
		spawner.clock();
		
		//disegno le parole da completare rimanenti
		push();
			
			//fill(255,100);
			translate(15,50);
			for(var i in spawner.wordsToSpawn)
			{
				var maxOsc = 6;
				var osc = maxOsc * (spawner.wordsToSpawn[i].match(/_/) != null ? spawner.wordsToSpawn[i].match(/_/).length : 0   / spawner.wordsToSpawn[i].length  );
				textSize(28 +  random(-osc,osc));
				fill(255, min((255 * spawner.wordsToSpawn[i].length/10.0),255) );
				text(spawner.wordsToSpawn[i].replace(/_/g,""),0,i*50);
				push();
					fill(255,0,0,255);
					textSize(28 + random(-1,1));
					translate(spawner.wordsToSpawn[i].length*25,0);
					text( (spawner.spawnedParts[i].match(/^_*$/)) ? "" : " // " + spawner.spawnedParts[i] ,0,i*50);
				pop();
				
				
			}
		pop();
		
	}

</script>

</body>
</html>