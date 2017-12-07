<html>

	<head>
		<title></title>
	</head>

	<body style="background-color: black;">
		<script src="../sorgentiP5JS/p5.min.js" >
		</script>
		
		 
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script> 
		
		<script>
			
			function Nodo(i,j,dimensionality)
			{
				this.i = i;
				this.j = j;
				this.d = dimensionality;
				this.weights = [];
				
				for(var k = 0; k< this.d; k++)
				{
					this.weights[k] = Math.random();	
				}
				
				this.activate = function(x)
				{
					var tot = 0;
					for(var k = 0; k<this.d;k++)
					{
						tot += (this.weights[k]*x[k]);
					}
					return tot;
				}
				
				this.distanceTo = function (vect)
				{
					offy = vect.i - this.i;
					offx = vect.j - this.j;
					return Math.sqrt(offx * offx + offy*offy);
				}
				
				this.updateWeights = function(update)
				{
					for(var k = 0; k< this.d;k++)
					{
						this.weights[k] = this.weights[k] + update[k];
					}
				}
				
				
				
			}
			
			function SOM(w,h,dimensionality,startingSigma, startingLearning, clockModule, dataset , epochs)
			{
				this.startingSigma = startingSigma;
				this.epochs = epochs;
				this.clockModule = clockModule;
				this.startingLearning = startingLearning;
				this.clockModule = clockModule;
				this.clock = 0;
				this.w = w;
				this.h = h;
				this.d = dimensionality;
				this.dataset = dataset;
				var nodi = [];
			
				for(var y = 0; y<this.h; y++)
				{
					t = [];
					for(var x = 0; x< this.w;x++)
					{
						t.push(new Nodo(y,x,this.d)); 
					}
					nodi.push(t);
				}
				this.nodi = nodi;
				
				this.computeSigma = function()
				{
					return this.startingSigma * (Math.exp(  -1.0 * (  this.clock / 10000  )    ));
				}
				this.computeLearning = function()
				{
					return this.startingLearning * (Math.exp( -1.0 * (this.clock / 10000)));
				}
				this.neighborhoodFunc = function(nodoa, nodob)
				{
					var distanceNodi = nodoa.distanceTo(nodob);
					return this.computeLearning() * Math.exp(  -0.5 * ( distanceNodi * distanceNodi / this.computeSigma() )    );
				}
				
				this.stopTrain = function()
				{
					clearInterval(this.trainHandler);
				}
				this.startTrain = function()
				{
					this.clock = 0;
					this.dataset = dataset;
					this.lastDatasetInd = 0;
					this.lastEpoch = 0;
					
					SOM_ = this;
					this.trainHandler = setInterval(function(){
						
						
						
						
						if(SOM_.lastDatasetInd >= SOM_.dataset.length)
						{
							SOM_.lastDatasetInd = 0;
							SOM_.lastEpoch = SOM_.lastEpoch +1;
							console.log("epoch "+SOM_.lastEpoch+" terminated");
						}
						
								
						if(SOM_.lastEpoch >= SOM_.epochs)
						{
							SOM_.stopTrain();
							console.log("Epochs terminati, stop !");
							return;
						}
							
								
						SOM_.clock = SOM_.clock +1;
						if(SOM_.clock % SOM_.clockModule != 0 )
							return;		
						
						/*competitive phase*/
						var maxActivate = 0;
						var maxNode = null;
						for (var y = 0; y < SOM_.h; y++) {
							for (var x = 0; x < SOM_.w; x++) {
								
								var act = SOM_.nodi[y][x]
										.activate(dataset[SOM_.lastDatasetInd]);
								if(isNaN(act))
									console.log("nan");
								if (act > maxActivate) {
									maxNode = SOM_.nodi[y][x];
									maxActivate = act;
								}
							}
						}

						/*cooperative phase */
						for (var y = 0; y < SOM_.h; y++) {
							for (var x = 0; x < SOM_.w; x++) {
								var neighOutput = SOM_.neighborhoodFunc(
										SOM_.nodi[y][x], maxNode);
								var scattervector = [];
								var diffvector = [];
								for (var k = 0; k < SOM_.d; k++) {
									diffvector[k] = dataset[SOM_.lastDatasetInd][k]
											- SOM_.nodi[y][x].weights[k];
									scattervector[k] = diffvector[k]
											* neighOutput;
									if(isNaN(scattervector[k]))
										console.log("SCATT");
								}

								SOM_.nodi[y][x].updateWeights(scattervector);

							}
						}
						
						SOM_.lastDatasetInd = SOM_.lastDatasetInd +1;
						

					},100);

				}
			}

			var SOM;
			function setup() {
				createCanvas(windowWidth * 0.98, windowHeight * 0.90);
				background(0);
				frameRate(500);

				background(0);

				/*var dataset = [ [ 0.5, 0.0, 0.0 ], [ 0.7, 0.0, 0.0 ],
						[ 0.0, 0.8, 0.0 ], [ 0.0, 0.9, 0.0 ],
						[ 0.0, 0.7, 0.0 ], [ 0.0, 0.0, 0.8 ],
						[ 0.0, 0.0, 0.6 ], [ 0.0, 0.0, 0.7 ] ];*/
				
						var dataset = [ [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],[ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ],
						                [ 0.0, 0.8, 0.0 ],[ 0.0, 0.0, 0.8 ]];
				SOM = new SOM(10, 7, 3, 0.9, 0.9, 1, dataset,1000);
				SOM.startTrain();

			}

			function draw() {
				if(SOM == undefined)
					return;
				background(0);
				push();	
					stroke(255, 150);
					fill(255, 150);
					ellipseMode(CENTER);
					var offsetX = (width-50) / SOM.w;
					var offsetY = (height-50) / SOM.h;
					
					for(var i = 0; i< SOM.h; i++)
					{
						for(var j = 0; j< SOM.w; j++)
						{
							push();
								stroke(SOM.nodi[i][j].weights[0]* 255,SOM.nodi[i][j].weights[1]* 255,SOM.nodi[i][j].weights[2] * 255,150);
								fill(SOM.nodi[i][j].weights[0]* 255,SOM.nodi[i][j].weights[1]* 255,SOM.nodi[i][j].weights[2] * 255,150);
								
								ellipse(100 + j * offsetX, 50 + i * offsetY, offsetX * 0.3, offsetY * 0.3  );
							pop();
						}
					}
				pop();

				//noLoop();

			}
		</script>
		 
	</body>
	
</html>