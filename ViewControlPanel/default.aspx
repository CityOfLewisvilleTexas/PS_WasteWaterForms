<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %> 


<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Control Panel Worksheet</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		
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
			<div class="col-lg-6"><h1>CITY OF LEWISVILLE - CONTROL PANEL WORKSHEET - (PLANT)</h1></div>
			<div class="col-lg-4"><h3>MONTH/YEAR: <span id="reportMonth"></span></h3></div>
			<div class="col-lg-2"><h4><b>**To be read at 8:00 AM</b></h4></div>
		</div>

		<div class="row" id="queryRow">
			<p>Select a month to review from the list below.</p>
		
		<div class="col-xs-4">
			<select id="Months" class="form-control" >
				<option value="1">January</option>
				<option value="2">February</option>
				<option value="3">March</option>
				<option value="4">April</option>
				<option value="5">May</option>
				<option value="6">June</option>
				<option value="7">July</option>
				<option value="8">August</option>
				<option value="9">September</option>
				<option value="10">October</option>
				<option value="11">November</option>
				<option value="12">December</option>
			</select>
		</div>	
		<div class="col-xs-4">
			<select id="Years" class="form-control">
				<option value="currentyr"></option>
				<option value="lastyr"></option>
			</select>
			
		</div>
		<div class="col-xs-4">
			<input class="btn btn-info" type="button" value="Search" id="Searching"></input>		
		</div>
		</div>
		
		<div class="row" id="tablediv">
			
			
		</div>
	</div>
	
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
	
	<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
	<script>
		
		$(document).ready(function(){
			//Get the current year to populate the select box
			var currentYear = (new Date).getFullYear();
			
			//Populate the select box for year with the current year and previous year
			$("#Years option:first").text(currentYear);
			$("#Years option:first").val(currentYear);
			$("option[value='lastyr']").text(currentYear-1);
			$("option[value='lastyr']").val(currentYear-1);		
			
			//When button is clicked, trigger function to call data through ajax
			$("#Searching").click(function(){
				getData();
			});	
		});
		
		
		function init (){
		
		};
		
		function getData (){
			
			//get month and year from select boxes
			var _mo = $("#Months").val();
			var _yr = $("#Years").val();
			
			
			$.ajax({
				type: "POST",
				url: "http://eservices.cityoflewisville.com/citydata/?datasetid=wwControlPanel_=" + _mo + "&Year=" + _yr + "&oauthToken=" + OAUTH.access_token +"&datasetformat=jsonp&callback=?",  
					
				contentType: "application/json; charset=utf-8",
				dataType: 'jsonp',
				success: function(e) {
					
					console.log(e);
					
				}
			})	
			
			
		};
						
	</script>
	</body>
</html>
	
		