 


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	
<style>
	
	canvas {
    padding-top: 30px;
    margin: auto;
    display: block;
    width: 800px;
	} 
	
	ul {
    padding-top: 20px;
    margin: auto;
    display: block;
    width: 800px;
	}
	
</style>
</head>
<body  >
 									
								  
								
								  <div id="pnl0" class="panel-body visibile">
								    <canvas id="miosketch2" data-processing-sources="mech.pde"></canvas><br> 
								  </div>
									
									  <center>
									<!-- <form class="navbar-form navbar" role="search">
 									<div class="form-group">
															 
									   <input name="textUrl" type="text" class="form-control" placeholder="insert url here" aria-describedby="basic-addon1"><button onclick="intercettaChangeValueUrl()" type="button" class="btn btn-primary">GO</button>
								    </div>    
									</form> -->
									<h3>USE W-A-S-D TO MOVE, ARROWS AND SPACEBAR TO JUMP  &nbsp; </h3>
									</center>
									
									  
									  
									
								  

<script src="../sorgentiProcessingJS/processing.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	
	function printMsg(msg)
	{
		console.log('messaggio from processing sketch: '+msg);
	}
	
	/* 
	window.links = {}; */
	

	$(document).keydown(function(event){
		if(!$("#miosketch2").is(":focus"))
			return;
		var pIst = Processing.getInstanceById("miosketch2");
		//alert(String.fromCharCode(event.which));
		//alert(event.which)
		pIst.keyPressedNonSpecialDaJs(event.which);
		
	});
	$(document).keyup(function(event){
		if(!$("#miosketch2").is(":focus"))
			return;
		var pIst = Processing.getInstanceById("miosketch2");
		//alert(String.fromCharCode(event.which));
		pIst.keyReleasedNonSpecialDaJs(event.which);
		
	}); 
	
	/* $(document).ready(function()
			{
		var canvas = document.getElementsByTagName('canvas')[0];
		canvas.width  = 800;
		canvas.height = 600;
			});  */
</script>

</body>
</html>