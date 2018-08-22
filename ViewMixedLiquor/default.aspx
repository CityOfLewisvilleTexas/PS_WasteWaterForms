<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>


<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Wastewater Mixed Liquor Settleability</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<!-- <script type="text/javascript" src="https://www.google.com/jsapi"></script> -->
    	<script src="https://unpkg.com/vue/dist/vue.js"></script>
    	<link rel="stylesheet" type="text/css" href="style.css" media="screen" />
    	<!-- google charts -->
    	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		
	</head>
	<body>
	<div id="toolbar">
		<div id="toolbar-title">Wastewater Mixed Liquor Settleability</div>
	</div>

	<div id="app" class="container-fluid" :class="isLoaded">

		<div id="loader" v-bind:class="{ inactive: !isLoading }"></div>

		<div id="container" v-bind:class="{ inactive: !isLoaded }">
			<div>
				<div class="info" id="plantOperator"><b>Plant Operator:</b> {{ PlantOperator }}</div>
				<div class="info" id="dateOfSample"><b>Date: </b>{{ Date }}</div>
				<div class="info" id="shiftReport"><b>Shift: </b>{{ Shift }}</div>
			</div>
			
			<div class="row" id="chartHolder">
				
				<div class="chart card" id="P1N"> </div>
				<div class="chart card" id="P1S"> </div>
				<div class="chart card" id="2T1"> </div>
				<div class="chart card" id="2T2"> </div>
				<div class="chart card" id="2T3"> </div>
				<div class="chart card" id="2T4"> </div>
				<div class="chart card" id="3N"> </div>
				<div class="chart card" id="3S"> </div>
				<!-- class="col-lg-1 col-sm-3" -->
			</div>
		</div>
		<div id='error' v-bind:class="{ inactive: !isError }">
			<h2>There were no records found matching this record number:<br></h2>
			<h3>{{ recordnumber }}</h3>
			<br><br>
			<button type='button' id='searchAgain' v-on:click="getData(true, false, true)">Try Again</button>
		</div>
	</div>
	
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script type="text/javascript" src="app.js"></script>
	</body>
</html>
	
		