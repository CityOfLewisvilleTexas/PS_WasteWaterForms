<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Wastewater Plant Report View</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<!-- Links to a bootstrap style sheet -->
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<!-- Reference jquery library -->
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<!-- Reference javascript library -->
		<script type="text/javascript" src="https://www.google.com/jsapi"></script>
		
		<style type="text/css">
			html, body {
				height: 100%;
				width: 100%;
				margin: 10px;
				padding: 0;
				font-family: arial;
				color: grey;
			}	
			 			 
			
			html .ui-autocomplete {
				height: 250px;
			}

			@media print {
				html, body{margin-top: -20px;
					height: 50%;
					width: 90%;
				}
				table, th, td {
					font-size: .67em;
					text-align: center;
					height: 50%;
				}

				h2 {font-size: 0.70em;}
				h3 {font-size: 0.70em;}
			}
		
				
			
		</style>
	</head>
	<body>
		<div class="container">
		  <h2 id="headerTitle">City of Lewisville Plant Report for </h2>          
		  <table class="table table-striped table-hover table-bordered">
			<thead>
			  <tr>
				<th>Time</th>
				<th>Total Inf</th>
				<th>Total Eff</th>
				<th>PC Flow</th>
				<th>TC Flow</th>
				<th>VR Flow</th>
				<th>WW Flow</th>
				<th>PC Level</th>
				<th>TC Level</th>
				<th>VR Level</th>
				<th>WW Level</th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
				<td>12am</td>
				<td id="TotalInfluent12am"></td>
				<td id="TotalEffluent12am"></td>
				<td id="PCFlow12am"></td>
				<td id="TCFlow12am"></td>
				<td id="VRFlow12am"></td>
				<td id="WWFlow12am"></td>
				<td id="PCLevel12am"></td>
				<td id="TCLevel12am"></td>
				<td id="VRLevel12am"></td>
				<td id="WWLevel12am"></td>
			  </tr>
			  <tr>
				<td>2am</td>
				<td id="TotalInfluent2am"></td>
				<td id="TotalEffluent2am"></td>
				<td id="PCFlow2am"></td>
				<td id="TCFlow2am"></td>
				<td id="VRFlow2am"></td>
				<td id="WWFlow2am"></td>
				<td id="PCLevel2am"></td>
				<td id="TCLevel2am"></td>
				<td id="VRLevel2am"></td>
				<td id="WWLevel2am"></td>
			  </tr>
			 <tr>
				<td>4am</td>
				<td id="TotalInfluent4am"></td>
				<td id="TotalEffluent4am"></td>
				<td id="PCFlow4am"></td>
				<td id="TCFlow4am"></td>
				<td id="VRFlow4am"></td>
				<td id="WWFlow4am"></td>
				<td id="PCLevel4am"></td>
				<td id="TCLevel4am"></td>
				<td id="VRLevel4am"></td>
				<td id="WWLevel4am"></td>
			  </tr>
			  <tr>
				<td>6am</td>
				<td id="TotalInfluent6am"></td>
				<td id="TotalEffluent6am"></td>
				<td id="PCFlow6am"></td>
				<td id="TCFlow6am"></td>
				<td id="VRFlow6am"></td>
				<td id="WWFlow6am"></td>
				<td id="PCLevel6am"></td>
				<td id="TCLevel6am"></td>
				<td id="VRLevel6am"></td>
				<td id="WWLevel6am"></td>
			  </tr>
			  <tr>
				<td>8am</td>
				<td id="TotalInfluent8am"></td>
				<td id="TotalEffluent8am"></td>
				<td id="PCFlow8am"></td>
				<td id="TCFlow8am"></td>
				<td id="VRFlow8am"></td>
				<td id="WWFlow8am"></td>
				<td id="PCLevel8am"></td>
				<td id="TCLevel8am"></td>
				<td id="VRLevel8am"></td>
				<td id="WWLevel8am"></td>
			  </tr>
			  <tr>
				<td>10am</td>
				<td id="TotalInfluent10am"></td>
				<td id="TotalEffluent10am"></td>
				<td id="PCFlow10am"></td>
				<td id="TCFlow10am"></td>
				<td id="VRFlow10am"></td>
				<td id="WWFlow10am"></td>
				<td id="PCLevel10am"></td>
				<td id="TCLevel10am"></td>
				<td id="VRLevel10am"></td>
				<td id="WWLevel10am"></td>
			  </tr>
			  <tr>
				<td>12pm</td>
				<td id="TotalInfluent12pm"></td>
				<td id="TotalEffluent12pm"></td>
				<td id="PCFlow12pm"></td>
				<td id="TCFlow12pm"></td>
				<td id="VRFlow12pm"></td>
				<td id="WWFlow12pm"></td>
				<td id="PCLevel12pm"></td>
				<td id="TCLevel12pm"></td>
				<td id="VRLevel12pm"></td>
				<td id="WWLevel12pm"></td>
			  </tr>
			  <tr>
				<td>2pm</td>
				<td id="TotalInfluent2pm"></td>
				<td id="TotalEffluent2pm"></td>
				<td id="PCFlow2pm"></td>
				<td id="TCFlow2pm"></td>
				<td id="VRFlow2pm"></td>
				<td id="WWFlow2pm"></td>
				<td id="PCLevel2pm"></td>
				<td id="TCLevel2pm"></td>
				<td id="VRLevel2pm"></td>
				<td id="WWLevel2pm"></td>
			  </tr>
			   <tr>
				<td>4pm</td>
				<td id="TotalInfluent4pm"></td>
				<td id="TotalEffluent4pm"></td>
				<td id="PCFlow4pm"></td>
				<td id="TCFlow4pm"></td>
				<td id="VRFlow4pm"></td>
				<td id="WWFlow4pm"></td>
				<td id="PCLevel4pm"></td>
				<td id="TCLevel4pm"></td>
				<td id="VRLevel4pm"></td>
				<td id="WWLevel4pm"></td>
			  </tr>
			   <tr>
				<td>6pm</td>
				<td id="TotalInfluent6pm"></td>
				<td id="TotalEffluent6pm"></td>
				<td id="PCFlow6pm"></td>
				<td id="TCFlow6pm"></td>
				<td id="VRFlow6pm"></td>
				<td id="WWFlow6pm"></td>
				<td id="PCLevel6pm"></td>
				<td id="TCLevel6pm"></td>
				<td id="VRLevel6pm"></td>
				<td id="WWLevel6pm"></td>
			  </tr>
			   <tr>
				<td>8pm</td>
				<td id="TotalInfluent8pm"></td>
				<td id="TotalEffluent8pm"></td>
				<td id="PCFlow8pm"></td>
				<td id="TCFlow8pm"></td>
				<td id="VRFlow8pm"></td>
				<td id="WWFlow8pm"></td>
				<td id="PCLevel8pm"></td>
				<td id="TCLevel8pm"></td>
				<td id="VRLevel8pm"></td>
				<td id="WWLevel8pm"></td>
			  </tr>
			   <tr>
				<td>10pm</td>
				<td id="TotalInfluent10pm"></td>
				<td id="TotalEffluent10pm"></td>
				<td id="PCFlow10pm"></td>
				<td id="TCFlow10pm"></td>
				<td id="VRFlow10pm"></td>
				<td id="WWFlow10pm"></td>
				<td id="PCLevel10pm"></td>
				<td id="TCLevel10pm"></td>
				<td id="VRLevel10pm"></td>
				<td id="WWLevel10pm"></td>
			  </tr>
			   <tr>
				<td><strong>AVG</strong></td>
				<td id="TotalInfluentAVG"></td>
				<td id="TotalEffluentAVG"></td>
				<td id="PCFlowAVG"></td>
				<td id="TCFlowAVG"></td>
				<td id="VRFlowAVG"></td>
				<td id="WWFlowAVG"></td>
				<td id="PCLevelAVG"></td>
				<td id="TCLevelAVG"></td>
				<td id="VRLevelAVG"></td>
				<td id="WWLevelAVG"></td>
			  </tr>
			</tbody>
		  </table>
		  
		   <h3>Plant Wasting:</h3>            
		  <table class="table table-striped table-hover table-bordered">
			<thead>
			  <tr>
				<th>Time</th>
				<th>P1 Was</th>
				<th>2T1 Was</th>
				<th>2T2 Was</th>
				<th>2T3 Was</th>
				<th>2T4 Was</th>
				<th>P3 Was</th>
				<th>Time</th>
				<th>CL2 Res North</th>
				<th>CL2 Res South</th>
				<th>Eff Res</th>
				<th>CL2 Feed</th>
				<th>SO2 Feed</th>
			  </tr>
			</thead>
			<tbody>
			  <tr>
				<td>12am</td>
				<td id="P1Waste12am"></td>
				<td id="_2T1Waste12am"></td>
				<td id="_2T2Waste12am"></td>
				<td id="_2T3Waste12am"></td>
				<td id="_2T4Waste12am"></td>
				<td id="P3Waste12am"></td>
				<td>12am</td>
				<td id="CL2ResN12am"></td>
				<td id="CL2ResS12am"></td>
				<td id="EffRes12am"></td>
				<td id="CL2Feed12am"></td>
				<td id="SO2Feed12am"></td>
			  </tr>
			  <tr>
				<td>2am</td>
				<td id="P1Waste2am"></td>
				<td id="_2T1Waste2am"></td>
				<td id="_2T2Waste2am"></td>
				<td id="_2T3Waste2am"></td>
				<td id="_2T4Waste2am"></td>
				<td id="P3Waste2am"></td>
				<td>2am</td>
				<td id="CL2ResN2am"></td>
				<td id="CL2ResS2am"></td>
				<td id="EffRes2am"></td>
				<td id="CL2Feed2am"></td>
				<td id="SO2Feed2am"></td>
			  </tr>
			 <tr>
				<td>4am</td>
				<td id="P1Waste4am"></td>
				<td id="_2T1Waste4am"></td>
				<td id="_2T2Waste4am"></td>
				<td id="2T3Wase4am"></td>
				<td id="_2T4Waste4am"></td>
				<td id="P3Waste4am"></td>
				<td>4am</td>
				<td id="CL2ResN4am"></td>
				<td id="CL2ResS4am"></td>
				<td id="EffRes4am"></td>
				<td id="CL2Feed4am"></td>
				<td id="SO2Feed4am"></td>
			  </tr>
			  <tr>
				<td>6am</td>
				<td id="P1Waste6am"></td>
				<td id="_2T1Waste6am"></td>
				<td id="_2T2Waste6am"></td>
				<td id="_2T3Waste6am"></td>
				<td id="_2T4Waste6am"></td>
				<td id="P3Waste6am"></td>
				<td>6am</td>
				<td id="CL2ResN6am"></td>
				<td id="CL2ResS6am"></td>
				<td id="EffRes6am"></td>
				<td id="CL2Feed6am"></td>
				<td id="SO2Feed6am"></td>
			  </tr>
			  <tr>
				<td>8am</td>
				<td id="P1Waste8am"></td>
				<td id="_2T1Waste8am"></td>
				<td id="_2T2Waste8am"></td>
				<td id="_2T3Waste8am"></td>
				<td id="_2T4Waste8am"></td>
				<td id="P3Waste8am"></td>
				<td>8am</td>
				<td id="CL2ResN8am"></td>
				<td id="CL2ResS8am"></td>
				<td id="EffRes8am"></td>
				<td id="CL2Feed8am"></td>
				<td id="SO2Feed8am"></td>
			  </tr>
			  <tr>
				<td>10am</td>
				<td id="P1Waste10am"></td>
				<td id="_2T1Waste10am"></td>
				<td id="_2T2Waste10am"></td>
				<td id="_2T3Waste10am"></td>
				<td id="_2T4Waste10am"></td>
				<td id="P3Waste10am"></td>
				<td>10am</td>
				<td id="CL2ResN10am"></td>
				<td id="CL2ResS10am"></td>
				<td id="EffRes10am"></td>
				<td id="CL2Feed10am"></td>
				<td id="SO2Feed10am"></td>
			  </tr>
			  <tr>
				<td>12pm</td>
				<td id="P1Waste12pm"></td>
				<td id="_2T1Waste12pm"></td>
				<td id="_2T2Waste12pm"></td>
				<td id="_2T3Waste12pm"></td>
				<td id="_2T4Waste12pm"></td>
				<td id="P3Waste12pm"></td>
				<td>12pm</td>
				<td id="CL2ResN12pm"></td>
				<td id="CL2ResS12pm"></td>
				<td id="EffRes12pm"></td>
				<td id="CL2Feed12pm"></td>
				<td id="SO2Feed12pm"></td>
			  </tr>
			  <tr>
				<td>2pm</td>
				<td id="P1Waste2pm"></td>
				<td id="_2T1Waste2pm"></td>
				<td id="_2T2Waste2pm"></td>
				<td id="_2T3Waste2pm"></td>
				<td id="_2T4Waste2pm"></td>
				<td id="P3Waste2pm"></td>
				<td>2pm</td>
				<td id="CL2ResN2pm"></td>
				<td id="CL2ResS2pm"></td>
				<td id="EffRes2pm"></td>
				<td id="CL2Feed2pm"></td>
				<td id="SO2Feed2pm"></td>
			  </tr>
			   <tr>
				<td>4pm</td>
				<td id="P1Waste4pm"></td>
				<td id="_2T1Waste4pm"></td>
				<td id="_2T2Waste4pm"></td>
				<td id="_2T3Waste4pm"></td>
				<td id="_2T4Waste4pm"></td>
				<td id="P3Waste4pm"></td>
				<td>4pm</td>
				<td id="CL2ResN4pm"></td>
				<td id="CL2ResS4pm"></td>
				<td id="EffRes4pm"></td>
				<td id="CL2Feed4pm"></td>
				<td id="SO2Feed4pm"></td>
			  </tr>
			   <tr>
				<td>6pm</td>
				<td id="P1Waste6pm"></td>
				<td id="_2T1Waste6pm"></td>
				<td id="_2T2Waste6pm"></td>
				<td id="_2T3Waste6pm"></td>
				<td id="_2T4Waste6pm"></td>
				<td id="P3Waste6pm"></td>
				<td>6pm</td>
				<td id="CL2ResN6pm"></td>
				<td id="CL2ResS6pm"></td>
				<td id="EffRes6pm"></td>
				<td id="CL2Feed6pm"></td>
				<td id="SO2Feed6pm"></td>
			  </tr>
			   <tr>
				<td>8pm</td>
				<td id="P1Waste8pm"></td>
				<td id="_2T1Waste8pm"></td>
				<td id="_2T2Waste8pm"></td>
				<td id="_2T3Waste8pm"></td>
				<td id="_2T4Waste8pm"></td>
				<td id="P3Waste8pm"></td>
				<td>8pm</td>
				<td id="CL2ResN8pm"></td>
				<td id="CL2ResS8pm"></td>
				<td id="EffRes8pm"></td>
				<td id="CL2Feed8pm"></td>
				<td id="SO2Feed8pm"></td>
			  </tr>
			   <tr>
				<td>10pm</td>
				<td id="P1Waste10pm"></td>
				<td id="_2T1Waste10pm"></td>
				<td id="_2T2Waste10pm"></td>
				<td id="_2T3Waste10pm"></td>
				<td id="_2T4Waste10pm"></td>
				<td id="P3Waste10pm"></td>
				<td>10pm</td>
				<td id="CL2ResN10pm"></td>
				<td id="CL2ResS10pm"></td>
				<td id="EffRes10pm"></td>
				<td id="CL2Feed10pm"></td>
				<td id="SO2Feed10pm"></td>
			  </tr>
			  <tr>
				<td><strong>TOTAL</strong></td>
				<td id="P1WasteTTL"></td>
				<td id="_2T1WasteTTL"></td>
				<td id="_2T2WasteTTL"></td>
				<td id="_2T3WasteTTL"></td>
				<td id="_2T4WasteTTL"></td>
				<td id="P3WasteTTL"></td>
				<td><strong>AVG</strong></td>
				<td id="CL2ResNAVG"></td>
				<td id="CL2ResSAVG"></td>
				<td id="EffResAVG"></td>
				<td id="CL2FeedAVG"></td>
				<td id="SO2FeedAVG"></td>
			  </tr>
			</tbody>
		  </table>
		  
		 
		   <h3>Operators:</h3>            
		  <table class="table table-striped table-hover table-bordered">
			<tbody>
			  <tr>
				<td>1st Shift (11pm-7am)</td>
				<td id="FirstShift"></td>
			  </tr>
			  <tr>
				<td>2nd Shift (7am-3pm)</td>
				<td id="SecondShift"></td>
			  </tr>
			  <tr>
				<td>3rd Shift (3pm-11pm)</td>
				<td id="ThirdShift"></td>
			  </tr>
			</tbody>  
			</table>  
			
		<!--	  <br></br>
		   <h3>Current Readings:</h3>            
		  <table class="table table-striped table-hover table-bordered">
			<tbody>
			  <tr>
				<td id="columnchart_values"></td>
			  </tr>
			</tbody>  
		  </table> 	-->
		</div> 
		
		
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
		
		
	
	
	
	<script>
		var dateFull = window.location.href.slice(window.location.href.indexOf('=') + 1).split('&');
		var _date = dateFull[0];
		
	/*	google.load("visualization", "1", {packages:["corechart", 'bar']});
		google.setOnLoadCallback(getChart());*/
			
		$(document).ready(function(){
			
			init(_date); 
				
		});
		
		function init (_date){
			$.ajax({
					type: "POST",
					url: "http://eservices.cityoflewisville.com/citydata/?datasetid=PSOFIA_WWPlantReport&record=" + _date + "&oauthToken=" + OAUTH.access_token + "&datasetformat=jsonp&callback=?",
					contentType: "application/json; charset=utf-8",
					dataType: 'jsonp',
					success: function(e) {
						console.log(e)		
						$("#headerTitle").append(e.results[0].FieldValue);
						$("#FirstShift").append(e.results[0].FirstShift);
						$("#SecondShift").append(e.results[0].SecondShift);
						$("#ThirdShift").append(e.results[0].ThirdShift);
																		
						Object.keys(e.results).forEach(function(key)
						{	
							$("#" + e.results[key].FieldID).append(e.results[key].FieldValue);
						})
						
					}
			});	
		};
		 
			  
		/*function getChart() {
		 								  
			$.ajax({
					type: "POST",
					url: "http://eservices.cityoflewisville.com/citydata/?datasetid=PSOFIA_WWPChartCall&record=" + _date + "&datasetformat=jsonp&callback=?",
					contentType: "application/json; charset=utf-8",
					dataType: 'jsonp',
					success: function(e) {		
						
						var _info = [];
						
						Object.keys(e.results).forEach(function(key)
						{	
							_info.push(e.results[key].SUMorAVG);							
						})
												
						drawChart(_info);
					}
				});	
		};*/

		/*function drawChart(_info) {
			var data = google.visualization.DataTable(_info); 
						 
			var options = {
				width: 600,
				height: 400,
				legend: { position: 'top', maxLines: 3 },
				bar: { groupWidth: '75%' },
				isStacked: true,
			};
			var chart = new google.visualization.BarChart(document.getElementById("columnchart_values"));
			chart.draw(data, options);
		};*/
		
		
		
	</script>
	</body>
</html>