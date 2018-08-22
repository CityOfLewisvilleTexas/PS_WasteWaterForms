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
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		
		<style type="text/css">
			html, body {
				height: 100%;
				width: 100%;
				padding: 0;
				overflow: auto;
				font-family: arial;
				color: grey;
			}			
			
			#chartHolder {margin: 5px;}
			
		</style>
	</head>
	<body>
	
	<div class="container-fluid">
		<div class="row">
		<div class="col-lg-12"><h1>Wastewater Mixed Liquor Settleability</h1>
		</div>
		</div>
		
		<div class="row" id="queryRow">
			<div class="col-lg-12">
				<div class="input-group input-group-lg" >
					<label for="dateInput">Select Date and Shift: </label>
					<input type="date" id="dateInput" class="form-control"></input> 
					<select id="shiftInput" class="form-control">
						<option value="7-3p">7 am - 3 pm</option>
						<option value="3-11p">3 pm - 11 pm</option>
						<option value="11-7a">11 pm - 7 am</option>
					</select> 
					<span class="input-group btn">
						<button class="btn btn-secondary btn-lg" type="button" id="searchBtn"  >Search</button>
					</span>
				</div>
			</div>			
		</div>
		
	
		<div class="row">
			<div class="col-lg-4" id="plantOperator"><b>Plant Operator: </b></div>
			<div class="col-lg-4" id="dateOfSample"><b>Date: </b></div>
			<div class="col-lg-4" id="shiftReport"><b>Shift: </b></div>
		</div>
		
		<div class="row" id="chartHolder">
			
			<div class="col-lg-1 col-sm-3" id="P1N"> </div>
			<div class="col-lg-1 col-sm-3" id="P1S"> </div>
			<div class="col-lg-1 col-sm-3" id="2T1"> </div>
			<div class="col-lg-1 col-sm-3" id="2T2"> </div>
			<div class="col-lg-1 col-sm-3" id="2T3"> </div>
			<div class="col-lg-1 col-sm-3" id="2T4"> </div>
			<div class="col-lg-1 col-sm-3" id="3N"> </div>
			<div class="col-lg-1 col-sm-3" id="3S"> </div>
		</div>
	</div>
	
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script>
		google.load('visualization', '1.0', {'packages':['corechart']});
		google.setOnLoadCallback(init);
		
		function init (){
			//set variable with error message to show if no records found
			_h = "<div><h2>There were no records found matching your search criteria.</h2><button type='button' id='searchAgain' onclick='window.location.reload();'>Search Again</button></div>";
			
			$("#searchBtn").click(function(){
				$("#queryRow").hide();
				
				_d = $("#dateInput").val();
				_s = $("#shiftInput").val();
				
				getData(); 
				
			})
			
			
			//add double click event to all date inputs which allows current data populated 
			$('input[type="date"]').dblclick(function() {
				var now = new Date();

				var day = ("0" + now.getDate()).slice(-2);
				var month = ("0" + (now.getMonth() + 1)).slice(-2);

				var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
				
				$(this).val(today);
			});
		
		};
		
		function getData (){
			
			//Ajax call to get chart data for three prior shifts
			$.ajax({
				type: "POST",
				url: "http://eservices.cityoflewisville.com/citydata/?datasetid=WWSettle&Date_=" + _d + "&WorkShift=" + _s + "&oauthToken=" + OAUTH.access_token +"&datasetformat=jsonp&callback=?",  
					
				contentType: "application/json; charset=utf-8",
				dataType: 'jsonp',
				success: function(e) {
					
					if (e.results.length === 0){
						//No results for query
						
						$("#chartHolder").html(_h);						
						
						
					} else {
					
						$("#plantOperator").append(e.results[0].PlantOperator);
						$("#dateOfSample").append(e.results[0].Date);
						$("#shiftReport").append(e.results[0].Shift);
						
						//Build out charts
						//-------------------------- Plant 1 North -------------------------------------------------
						var data = new google.visualization.DataTable();
						data.addColumn("number", "Minutes");
						data.addColumn("number", "Plant 1N");
						data.addRows([
							[5, parseInt(e.results[0].Plant1N_5)],
							[10, parseInt(e.results[0].Plant1N_10)],
							[15, parseInt(e.results[0].Plant1N_15)],
							[20, parseInt(e.results[0].Plant1N_20)],
							[25, parseInt(e.results[0].Plant1N_25)],
							[30, parseInt(e.results[0].Plant1N_30)]
						]);
						
						var options =  {'title': 'Plant 1N',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart = new google.visualization.LineChart(document.getElementById('P1N'));
						chart.draw(data, options);
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 1 South -------------------------------------------------
						var data2 = new google.visualization.DataTable();
						data2.addColumn("number", "Minutes");
						data2.addColumn("number", "Plant 1S");
						data2.addRows([
							[5, e.results[0].Plant1S_5],
							[10, e.results[0].Plant1S_10],
							[15, e.results[0].Plant1S_15],
							[20, e.results[0].Plant1S_20],
							[25, e.results[0].Plant1S_25],
							[30, e.results[0].Plant1S_30]
						]);
						
						var options2 =  {'title': 'Plant 1S',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart2 = new google.visualization.LineChart(document.getElementById('P1S'));
						chart2.draw(data2, options2);
						
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 2T1 -------------------------------------------------
						var data3 = new google.visualization.DataTable();
						data3.addColumn("number", "Minutes");
						data3.addColumn("number", "Plant 2T1");
						data3.addRows([
							[5, e.results[0].Plant2T1_5],
							[10, e.results[0].Plant2T1_10],
							[15, e.results[0].Plant2T1_15],
							[20, e.results[0].Plant2T1_20],
							[25, e.results[0].Plant2T1_25],
							[30, e.results[0].Plant2T1_30]
						]);
						
						var options3 =  {'title': 'Plant 2T1',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart3 = new google.visualization.LineChart(document.getElementById('2T1'));
						chart3.draw(data3, options3);
						
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 2T2 -------------------------------------------------
						var data4 = new google.visualization.DataTable();
						data4.addColumn("number", "Minutes");
						data4.addColumn("number", "Plant 2T2");
						data4.addRows([
							[5, e.results[0].Plant2T2_5],
							[10, e.results[0].Plant2T2_10],
							[15, e.results[0].Plant2T2_15],
							[20, e.results[0].Plant2T2_20],
							[25, e.results[0].Plant2T2_25],
							[30, e.results[0].Plant2T2_30]
						]);
						
						var options4 =  {'title': 'Plant 2T2',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart4 = new google.visualization.LineChart(document.getElementById('2T2'));
						chart4.draw(data4, options4);
						
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 2T3 -------------------------------------------------
						var data5 = new google.visualization.DataTable();
						data5.addColumn("number", "Minutes");
						data5.addColumn("number", "Plant 2T3");
						data5.addRows([
							[5, e.results[0].Plant2T3_5],
							[10, e.results[0].Plant2T3_10],
							[15, e.results[0].Plant2T3_15],
							[20, e.results[0].Plant2T3_20],
							[25, e.results[0].Plant2T3_25],
							[30, e.results[0].Plant2T3_30]
						]);
						
						var options5 =  {'title': 'Plant 2T3',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart5 = new google.visualization.LineChart(document.getElementById('2T3'));
						chart5.draw(data5, options5);
						
											
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 2T4 -------------------------------------------------
						var data7 = new google.visualization.DataTable();
						data7.addColumn("number", "Minutes");
						data7.addColumn("number", "Plant 2T4");
						data7.addRows([
							[5, e.results[0].Plant2T4_5],
							[10, e.results[0].Plant2T4_10],
							[15, e.results[0].Plant2T4_15],
							[20, e.results[0].Plant2T4_20],
							[25, e.results[0].Plant2T4_25],
							[30, e.results[0].Plant2T4_30]
						]);
						
						var options7 =  {'title': 'Plant 2T4',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart7 = new google.visualization.LineChart(document.getElementById('2T4'));
						chart7.draw(data7, options7);
						
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 3N -------------------------------------------------
						var data8 = new google.visualization.DataTable();
						data8.addColumn("number", "Minutes");
						data8.addColumn("number", "Plant 3N");
						data8.addRows([
							[5, e.results[0].Plant3N_5],
							[10, e.results[0].Plant3N_10],
							[15, e.results[0].Plant3N_15],
							[20, e.results[0].Plant3N_20],
							[25, e.results[0].Plant3N_25],
							[30, e.results[0].Plant3N_30]
						]);
						
						var options8 =  {'title': 'Plant 3N',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart8 = new google.visualization.LineChart(document.getElementById('3N'));
						chart8.draw(data8, options8);
						
						//------------------------------------------------------------------------------------------
						//-------------------------- Plant 3S -------------------------------------------------
						var data6 = new google.visualization.DataTable();
						data6.addColumn("number", "Minutes");
						data6.addColumn("number", "Plant 3S");
						data6.addRows([
							[5, e.results[0].Plant3S_5],
							[10, e.results[0].Plant3S_10],
							[15, e.results[0].Plant3S_15],
							[20, e.results[0].Plant3S_20],
							[25, e.results[0].Plant3S_25],
							[30, e.results[0].Plant3S_30]
						]);
						
						var options6 =  {'title': 'Plant 3S',
										'width':150,
										'height':800,
										'legend':'none',
										'pointSize':10,
										'vAxis': {
											'viewWindowMode':'explicit',
											'viewWindow':{
												'max': 1000
											}
										}};
						
						var chart6 = new google.visualization.LineChart(document.getElementById('3S'));
						chart6.draw(data6, options6);
					}
				}
			})	
			
			
		};
						
	</script>
	</body>
</html>
	
		