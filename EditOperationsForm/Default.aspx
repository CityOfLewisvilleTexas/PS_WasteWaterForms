
<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Edit Operations Reports</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
		<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
		<style type="text/css">
			html, body {
				height: 100%;
				width: 100%;
				margin: 10px;
				padding: 0px;
				overflow: auto;
				font-family: arial;
				color: grey;
			}	
			 
			/* IE 6 doesn't support max-height
			* we use height instead, but this forces the menu to always be this tall
			*/
			* html .ui-autocomplete {
				height: 250px;
			}
		
			
			
		</style>
	</head>
	<body>
	<div class="jumbotron" id="titleHeader" >
		<p>To Edit a Report, select the Edit button to the left of the record.</p>
		</div>
	<div class="container">
		<table id="reports" class="table table-striped table-hover table-bordered">
			<tr>
			<th>View Report</th>
			<th>Edit Report</th>
			<th>Report Name</th>
			<th>Report Information</th>
			<th>Report ID</th>
			<th>Date Created</th>
			<th>Submitted By</th>
			</tr>
		</table>
		
	</div>
	
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
	
	
	<script>
	
	
		$(document).ready(function(){
			
			var formFull = window.location.search.slice(window.location.search.indexOf('=') + 1).split('&');
			var form = formFull[0];
			
			init(form); 
									
		});
		
		function init (form){
			$.ajax({
					type: "POST",
					url: "http://eservices.cityoflewisville.com/citydata/?datasetid=PSOFIA_EditForm&oauthToken=" + OAUTH.access_token +"&formID=" 
							+ form + "&datasetformat=jsonp&callback=?",
					contentType: "application/json; charset=utf-8",
					dataType: 'jsonp',
					success: function(e) {
						var _x = "<h2>Most Recent <strong>" + e.results[0].FormName + "</strong> Records</h2>"
						
						$("#titleHeader").prepend(_x);
						
						Object.keys(e.results).forEach(function(key)
						{	
							$("#reports").append(e.results[key].HTML);
						})
						
						
					}
			});	
		};
		
	</script>
	</body>
</html>
	
		