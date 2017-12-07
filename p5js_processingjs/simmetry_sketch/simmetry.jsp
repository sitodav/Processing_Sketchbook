<html>

	<head>
		<title></title>
	</head>

	<body style="background-color: black;">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script> 
		<script src="../sorgentiP5JS/p5.min.js" > </script>
		 
		
		
		<script>
			
			function Cerchio(centro,ray,intervalsray,intervalsangle)
			{
				this.centro = centro;
				this.ray = ray;
				this.intervalsray = intervalsray;
				this.intervalsangle = intervalsangle;
				this.showgrid = false;
				this.i0Set = -1;
				this.i1Set = -1;
				this.kSet = -1;
				this.puntiUltimoDisegno = [];
				this.tuttiPunti = [];
				
				
				
				this.scaricaUltimiPunti = function()
				{	

					
					
					/*speculo, tutti centrati in centor*/
					var t = [];
					var t2 = [];
					t = this.puntiUltimoDisegno;
					
					for(var u = 0; u < this.nodi[this.kSet].length; u+=2)
					{
						var realu = ( this.i0Set + u ) % this.nodi[this.kSet].length;
						
						var rif = {x : this.nodi[this.kSet][realu].x //+ this.centro.x
								, y : this.nodi[this.kSet][realu].y //+ this.centro.y  
								};
						var norm = (rif.x * rif.x + rif.y * rif.y);
						
						for(var ind in t)
						{
							var p = t[ind];
							
							
														
							t2.push({x : p.x * cos(u * this.porzangle) - p.y * sin(u * this.porzangle) ,
								y : p.x * sin(u * this.porzangle) + p.y * cos(u * this.porzangle) });
							
							
							p = { x : centro.x - p.x , y : centro.y -p.y   };
							np = { x : p.x * cos( u * this.porzangle) - p.y * sin(u * this.porzangle)  
								, y : p.x * sin(u * this.porzangle) + p.y * cos(u * this.porzangle)}
							p = np;
							
							var dot = p.x * rif.x + p.y * rif.y;
							var res2 = { x : p.x - 2*(dot * rif.x) / norm 
										, y : p.y - 2*(dot * rif.y) / norm
										}
							var res3 = { x : p.x 
									, y : p.y 
									}
							//this.tuttiPunti.push({x : res2.x + this.centro.x , y : res2.y + this.centro.y });
							//this.tuttiPunti.push({x : res3.x + this.centro.x , y : res3.y + this.centro.y });
							noStroke();
							//fill(Math.random() * 255,Math.random() * 255,Math.random() * 255,120);
							fill(redc,greenc,bluec,opacityc);
							
							if(sqrt(res2.x * res2.x + res2.y * res2.y ) < this.ray )
								ellipse(res2.x + this.centro.x,res2.y + this.centro.y,4,4);
							
							if(sqrt(res3.x * res3.x + res3.y * res3	.y ) < this.ray )
								ellipse(res3.x + this.centro.x,res3.y + this.centro.y,4,4);
						}	
						
						t = t2;
					}
					
					
					this.puntiUltimoDisegno = [];
					//loop();
					
				}
				
				this.init = function()
				{
					this.porzray = this.ray / this.intervalsray;
					this.porzangle = (2.0 * PI) / this.intervalsangle;
					this.nodi = [];
					for(var k = 0; k<=this.intervalsray; k++)
					{
						var t = [];
						for(var i = 0; i<= this.intervalsangle;i++)
						{
							t.push({ x : k* this.porzray * cos(i * this.porzangle), y :  k*this.porzray * sin(i*this.porzangle)  });
						}
						this.nodi.push(t);
					}	
				}
				
				this.init();
				
				this.cercaSettore = function()
				{
					
					
					
					var a = {x : mouseX - this.centro.x, y : mouseY-this.centro.y};
					if( sqrt(a.x * a.x + a.y * a.y) > ray ) return;
					var found = false;
					for(var k = 1; k<=this.intervalsray && !found; k++)
					{
						var lastProiez = -1;
						for(var i = 0; i<= this.intervalsangle && !found ;i++)
						{
							var b = {x: this.nodi[k][i].x , y: this.nodi[k][i].y };
							var normb = {x : -b.y, y: b.x};
							push();
							
							translate(this.centro.x + this.nodi[k][i].x, this.centro.y+this.nodi[k][i].y);
							
							var proiez = a.x * normb.x + a.y * normb.y;
							
							if(lastProiez > 0 && proiez < 0)
							{
								var dista = sqrt( a.x * a.x + a.y * a.y );
								var distb = sqrt(b.x * b.x + b.y * b.y);
								
								if(dista < distb)
								{
									this.i0Set = i-1 >= 0 ? i-1 : nodi[k].length -1 ;
									this.i1Set = i;
									this.kSet = k;
									found = true;
								}
								
								
							}
							lastProiez = proiez;
							
							//line(0,0,normb.x,normb.y);
							
							pop();
						}
					}	
					
					 
				}
				
				
				 
				this.disegna = function()
				{
					var col = -1;
					var alpha = -1;
					if(this.showgrid)
					{
						col = 255;
						alpha = 55;
						
					}
					else
					{
						col = 255;
						alpha = 30;
					}
					
					push();
					translate(this.centro.x,this.centro.y);
					for(var k = 0; k< this.nodi.length;k++)
					{
						var t = this.nodi[k];
						for(var i = 0; i<t.length; i++)
						{
							push();
								fill(col,alpha);
								translate(t[i].x,t[i].y);
								
							/*	if( (i == this.i0Set || i == this.i1Set ) && k == this.kSet )
								{
									fill(0,255,0);
								}
								*/
								ellipse(0,0,10,10);
								
								stroke(col,alpha);
								var inext = (i+1) % t.length;
								line(0,0, t[inext].x - t[i].x, t[inext].y - t[i].y);
								
							pop();
						}
					}
					pop();
					
					var ultimi = this.nodi[this.nodi.length -1];
					push();
					translate(this.centro.x,this.centro.y);
					
					stroke(col,alpha);
					for(var i = 0; i< ultimi.length; i++)
					{
						line(0,0,ultimi[i].x,ultimi[i].y);
					}
					pop();
					
					/*
					noStroke();
					fill(255,125);
					for(var ind in this.tuttiPunti)
					{
						ellipse(this.tuttiPunti[ind].x,this.tuttiPunti[ind].y,4,4);
					}
					*/
					
					
				}
				
				this.mouseInNodo = function(upy,downy,leftx,rightx)
				{
					if(mouseX > leftx && mouseX < rightx && mouseY > downy && mouseY < upy)
					{
						return true;
					}
					return false;
				}
				
				 
				
				
				
			}
			

				
			var redc = 255;
			var greenc = 255;
			var bluec = 255;
			var opacityc = 255;
			
			function setup(){
				createCanvas(windowWidth*0.98,windowHeight*0.90);
				background(0);
				frameRate(500);
				cerchio = new Cerchio({x : width * 0.5, y : height * 0.5},300,1,10);
				background(0);
				noLoop();
				
				 
			}
			
			function draw()
			{
				console.log("disegno");
				background(0);
				push();
				stroke(255,150);
				fill(255,150);
				text("CLICK AND DRAG\nYOUR MOUSE INSIDE THE CIRCLE\nTO GENERATE RANDOM PATTERNS",150,150);
				pop();
				
				cerchio.disegna();
				noLoop();
				stroke(255);
			
			}
			
			 
			
			function mouseDragged()
			{
				cerchio.cercaSettore();
				cerchio.puntiUltimoDisegno.push({x : mouseX, y: mouseY});
				
				/*fill(255,125);
				noStroke();
				ellipse(mouseX,mouseY,4,4);
				*/
			}
			function mouseReleased()
			{
				cerchio.scaricaUltimiPunti();
				
			}
			
			 
			
			function keyPressed()
			{
				console.log(keyCode);
				/*switch(keyCode)
				{
				case 32 : cerchio.intervalsray = cerchio.intervalsray -1 > 1 ? cerchio.intervalsray - 1 : 1; 
					cerchio.init();
					//background(0);
					cerchio.disegna();
					//loop();
					break;
				case 67 : 
					cerchio.showgrid = !cerchio.showgrid; 
					//background(0);
					cerchio.disegna();
					//loop();
					break;
				case 68 :  
					loop();
					break;
				case 88 :  
					cerchio.intervalsangle = cerchio.intervalsangle + 2;
					cerchio.init();					
					loop();
					break;
				}*/
			}
					
			
			 
			
			
			
			
			
			
		</script>
		 
		<span align="left">
		<table>
			<tr>
				<td colspan="1" align="center"><font style="font-weight: bold;" color="white">Red</font></td>
				<td colspan="1" align="center"><font style="font-weight: bold;"color="white">Green</font></td>
				<td colspan="1" align="center"><font style="font-weight: bold;" color="white">Blue</font></td>
				<td  colspan="1"></td>
			</tr>
			<tr>
				<td colspan="1" style="position: relative; left: 35px;"><input value="255" name="rangered" type="range" min = "0" max = "255" /></td>
				<td colspan="1" style="position: relative; left: 35px;"><input value="255" name="rangegreen" type="range" min = "0" max = "255" /></td>
				<td colspan="1" style="position: relative; left: 35px;"><input value="255" name="rangeblue" type="range"  min = "0" max = "255"/></td>
				<td colspan="1" style="position: relative; left: 35px;"> <div id="colorprev" style="background-color:white; width: 100px; position: relative; left: 20px;">&nbsp;</div></td>
			</tr>

		</table>
		
		<script>
			function 
			aggiornaColorPrev()
			{
				$("#colorprev").css("background-color","rgba("+redc+","+greenc+","+bluec+","+(opacityc / 255.0)+")");
			}
		
			$(function(){
					
				$("[name='rangered']").on("input",function(){
					var valu = $(this).val();
						redc = valu;
					
					aggiornaColorPrev();
				});
				
				$("[name='rangegreen']").on("input",function(){
					var valu = $(this).val();
					greenc = valu;
						
					aggiornaColorPrev();
				});
				
				$("[name='rangeblue']").on("input",function(){
					var valu = $(this).val();

					bluec = valu;
					aggiornaColorPrev();
				});
				
				$("[name='rangeopacity']").on("input",function(){
					var valu = $(this).val();

					opacityc = valu;
					aggiornaColorPrev();
				});
			});
		</script>
		
		</span>
	</body>
	
</html>