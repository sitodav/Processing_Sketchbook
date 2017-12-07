<html>

	<head>
		
	</head>

<body>
	<script src="../sorgentiP5JS/p5.min.js"></script>
	<script src="../sorgentiP5JS/p5.dom.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	
	<!-- <input type="text" value="write me" id="inputText1"/>
	<input type="text" value="write me too" id="inputText2"/>
	 -->
	<script>
	var canvas1;
	var inputText1;
	var inputText2;
	

	function Input(x,y,valore,idI)
	{
		this.x = x;
		this.y = y;
		this.input = createInput(valore);
		this.input.position(x,y);
		this.input.id(idI);
		
	}
	
	function Particella(x,y,colore,movToX,movToY,lettera)
	{
		this.x = x;
		this.y = y;
		this.colore = colore;
		this.movToY = movToY;
		this.movToX = movToX;
		this.lettera = lettera;
	}
	
	Particella.prototype.muovi = function()
	{
		this.x = this.x + 0.05*(this.movToX - this.x);
		this.y = this.y + 0.05 * (this.movToY - this.y)  -4 +random(8) ;
		if(Math.abs(this.movToX - this.x) < 2 && Math.abs(this.movToY - this.y) < 10 )
		{
			this.movToY = this.y;
			this.movToX = this.x;
			return true;
		}
	}
	
	
	
	var spawned = [];
	var oldSize = 0;
	
	function setup()
	{
		//noStroke();
		strokeWeight(0);
		textStyle(BOLD);
		textAlign(CENTER);
		canvas1 = createCanvas(windowWidth-20,600);
		var input1 = new Input(250,250,'','input1');
		var input2 = new Input(1000,250,'','input2');
		inputText = input1;
		inputText2 = input2;
		//input2.input.position(500,400);
		//inputText1 = select("#inputText1");
		//inputText1.position(250,250);
		//input
		$("#input1").on('input',function(){
				if(String($(this).val()).length == 0)
				{	
					oldSize = String($(this).val()).length;
					return;
				}	
				if(String($(this).val()).length > oldSize)
				{
					var lastLetter = String($(this).val())[String($(this).val()).length-1];
					spawn(input1.x ,input1.y,color(random(255)),input2.x-25,input2.y,lastLetter);
				}
				
				console.log(oldSize);
			
		});
		
	}
	
	
	function spawn(x,y,colore,movToX,movToY,lastLetter)
	{
		spawned.push( new Particella(x,y,colore,movToX,movToY,lastLetter) );
	}
	
	function draw()
	{
		elsToRemove = [];
		background(0);
		for(i in spawned)
		{
			if(spawned[i].muovi())
			{
				elsToRemove.push(i);
			}
			push();
				translate(spawned[i].x,spawned[i].y);
				fill(spawned[i].colore);
				textSize(30);
				//ellipse(0,0,25,25);
				text(spawned[i].lettera,0,0);
			pop();
		}
		for(ind in elsToRemove)
		{
			inputText2.input.value( inputText2.input.value( )+spawned[ind].lettera );
		}
		for(ind in elsToRemove)
		{
			spawned.splice(elsToRemove[i],1);
		}
	}
	
	</script>


</body>

</html>