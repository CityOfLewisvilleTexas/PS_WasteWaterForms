<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Wastewater Operations Report</title>
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
				padding: 10px;
				font-family: arial;
				color: grey;
			}	
			 
			/* IE 6 doesn't support max-height
			* we use height instead, but this forces the menu to always be this tall
			*/
			* html .ui-autocomplete {
				height: 250px;
			}
			
			.needsBorder, .needsBorder th, .needsBorder td {
				border: 1px solid black;
				border-collapse: collapse;
			}
			
			th, td {
				padding: 10px;
			}
			
			@media print {
				html, body{margin-top: -16px;
					height: 85%;
					width: 95%;
					margin-left: -10px;
				}
				table {
					font-size: .85em;
				}

				h2 {font-size: 1.50em;}
				h3 {font-size: 1.0em;}

			}

									
		</style>
	</head>
	<body>
		<div id="formBody">
			<div id="miscInfo">
				<h2>City of Lewisville Wastewater Treatment Operations Report</h2>
				<h4 id="Date"><strong>Date: </strong> </h4>
				<h4 id="Shift"><strong>Shift: </strong></h4>
				<h4 id="Operator"><strong>Operator: </strong></h4>
			<br></br>
			</div>
		<div>
			<table id="fullTable" style="border:none"; >
				<tr>
					<td colspan="3">
						<h4><strong>DO READINGS:</strong></h4>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<table id="doReadings" class="needsBorder">
							<thead>
							  <tr>
								<th><strong>Time</strong></th>
								<th colspan="3"><strong>1N</strong></th>
								<th colspan="3"><strong>1S</strong></th>
								<th colspan="3"><strong>2T1</strong></th>
								<th colspan="3"><strong>2T2</strong></th>
								<th colspan="3"><strong>2T3</strong></th>
								<th colspan="3"><strong>2T4</strong></th>
								<th><strong>3N</strong></th>
								<th><strong>3S</strong></th>
							  </tr>
							</thead>
							<tbody>
							  <tr>
								<td id="Time"></td>
								<td id="_1N_1"></td>
								<td id="_1N_2"></td>
								<td id="_1N_3"></td>
								<td id="_1S_1"></td>
								<td id="_1S_2"></td>
								<td id="_1S_3"></td>
								<td id="_2T1_1"></td>
								<td id="_2T1_2"></td>
								<td id="_2T1_3"></td>
								<td id="_2T2_1"></td>
								<td id="_2T2_2"></td>
								<td id="_2T2_3"></td>
								<td id="_2T3_1"></td>
								<td id="_2T3_2"></td>
								<td id="_2T3_3"></td>
								<td id="_2T4_1"></td>
								<td id="_2T4_2"></td>
								<td id="_2T4_3"></td>
								<td id="_3N"></td>
								<td id="_3S"></td>
							  </tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table class="needsBorder">
							<thead>
								<tr>
									<th colspan="2"><strong>SETTLEABILITY</strong></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><strong>1N</strong></td>
									<td id="SETTLE_1N"></td>
								</tr>
								<tr>
									<td><strong>1S</strong></td>
									<td id="SETTLE_1S"></td>
								</tr>
								<tr>
									<td><strong>2T1</strong></td>
									<td id="SETTLE_2T1"></td>
								</tr>
								<tr>
									<td><strong>2T2</strong></td>
									<td id="SETTLE_2T2"></td>
								</tr>
								<tr>
									<td><strong>2T3</strong></td>
									<td id="SETTLE_2T3"></td>
								</tr>
								<tr>
									<td><strong>2T4</strong></td>
									<td id="SETTLE_2T4"></td>
								</tr>
								<tr>
									<td><strong>3N</strong></td>
									<td id="SETTLE_3N"></td>
								</tr>
								<tr>
									<td><strong>3S</strong></td>
									<td id="SETTLE_3S"></td>
								</tr>
							</tbody>
						</table>
					</td>
					<td>
						<table class="needsBorder">
							<thead>
								<tr>
									<th colspan="2"><strong>CLARIFIER BLANKETS</strong></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><strong>1N</strong></td>
									<td id="CLARIFY_1N"></td>
								</tr>
								<tr>
									<td><strong>1S</strong></td>
									<td id="CLARIFY_1S"></td>
								</tr>
								<tr>
									<td><strong>2T1</strong></td>
									<td id="CLARIFY_2T1"></td>
								</tr>
								<tr>
									<td><strong>2T2</strong></td>
									<td id="CLARIFY_2T2"></td>
								</tr>
								<tr>
									<td><strong>2T3</strong></td>
									<td id="CLARIFY_2T3"></td>
								</tr>
								<tr>
									<td><strong>2T4</strong></td>
									<td id="CLARIFY_2T4"></td>
								</tr>
								<tr>
									<td><strong>3N</strong></td>
									<td id="CLARIFY_3N"></td>
								</tr>
								<tr>
									<td><strong>3S</strong></td>
									<td id="CLARIFY_3S"></td>
								</tr>
							</tbody>
						</table>
					</td>
					<td>
						<table class="needsBorder">
							 <thead>
							 <tr>
								<th colspan="3"><strong>WASTE TIMERS</strong></th>
							 </tr>
							 </thead>
							 <tbody>
							 <tr>
								<td></td>
								<td><strong>ON</strong></td>
								<td><strong>OFF</strong></td>
							 </tr>
							 <tr>
								<td><strong>Plant 1</strong></td>
								<td id="Plant1_ON"></td>
								<td id="Plant1_OFF"></td>
							 </tr>
							 <tr>
								<td><strong>Plant3</strong></td>
								<td id="Plant3_ON"></td>
								<td id="Plant3_OFF"></td>
							 </tr>
							 <tr>
								<td colspan="3"><strong>WASTE PER SHIFT</strong></td>
							 </tr>
							 <tr>
							 	<td></td>
								<td><strong>Gal to waste</strong></td>
								<td><strong>Actually wasted</strong></td>
							 </tr>
							  <tr>
								<td><strong>2T1</strong></td>
								<td id="_2T1_ON"></td>
								<td id="_2T1_OFF"></td>
							 </tr>
							 <tr>
								<td><strong>2T2</strong></td>
								<td id="_2T2_ON"></td>
								<td id="_2T2_OFF"></td>
							 </tr>
							 <tr>
								<td><strong>2T3</strong></td>
								<td id="_2T3_ON"></td>
								<td id="_2T3_OFF"></td>
							 </tr>
							 <tr>
								<td><strong>2T4</strong></td>
								<td id="_2T4_ON"></td>
								<td id="_2T4_OFF"></td>
							 </tr>
							 </tbody>
						</table>				
					</td>
				</tr>
				<tr>
					<table>
						<tr colspan="3">
							<td><h4><strong>LIST OF EQUPMENT:</strong></h4></td>
						</tr>					
						<tr>
							<table>
								<tr>
									<td><b>PC Pumps: </b></td> 
									<td id="PCPumps_1"> </td>
									<td id="PCPumps_2"> </td>
									<td id="PCPumps_3"> </td>
									<td id="PCPumps_4"> </td>
									<td id="PCPumps_5"> </td>
									<td id="PCPumps_6"> </td>
								</tr>
								<tr>
									<td><b>Bar Screen: </b></td>
									<td id="BarScreen"></td>
								</tr>
								<tr>
									<td><b>Fine Screens: </b></td>
									<td id="FineScreens_1"></td>
									<td id="FineScreens_2"></td>
									<td id="FineScreens_3"></td>
									<td id="FineScreens_4"></td>
									<td id="FineScreens_5"></td>
								</tr>
								<tr>
									<td><b>BTF Control Panel: </b></td>
									<td id="PH"><b>PH: </b></td>
									<td id="GPM48"><b>GPM: </b></td>
									<td id="ExhaustFan"><b>ExhaustFan: </b></td>
									<td id="NutrientPump"><b>Nutrient Pump: </b></td>
									<td id="RecircPump"><b>Recirculation Pump: </b></td>
								</tr>
								<tr>
									<td><b>Compactor Control Panel #1: </b></td>
									<td id="PressCCP1"><b>Press: </b></td>
									<td id="PressZoneCCP1"><b>Press Zone Wash: </b></td>
									<td id="PressFORCCP1"><b>Press: </b></td>
									<td id="SluiceValveCCP1"><b>Sluice Valve: </b></td>
								</tr>
								<tr>
									<td><b>Compactor Control Panel #2: </b></td>
									<td id="PressCCP2"><b>Press: </b></td>
									<td id="PressZoneCCP2"><b>Press Zone Wash: </b></td>
									<td id="PressFORCCP2"><b>Press: </b></td>
									<td id="SluiceValveCCP2"><b>Sluice Valve: </b></td>
								</tr>
								<tr>
									<td><b>North Grit Unit: </b></td>
									<td id="PaddleDrive51"><b>Paddle Drive: </b></td>
									<td id="GritPump51"><b>Grit Pump: </b></td>
								</tr>
								<tr>
									<td><b>South Grit Unit: </b></td>
									<td id="PaddleDrive52"><b>Paddle Drive: </b></td>
									<td id="GritPump52"><b>Grit Pump: </b></td>
								</tr>							
								<tr>
									<td><b>P1 Blowers: </b></td>
									<td id="P1Blowers_1"></td>
									<td id="P1Blowers_1SCFM"><b>SCFM: </b></td>
									<td id="P1Blowers_2"></td>
									<td id="P1Blowers_2SCFM"><b>SCFM: </b></td>
									<td id="P1Blowers_3"></td>
									<td id="P1Blowers_3SCFM"><b>SCFM: </b></td>
								</tr>
								<tr>
									<td><b>P1 Return: </b></td>
									<td id="P1Return_1"></td>
									<td id="P1Return_2"></td>
									<td id="P1Return_FLOW"><b>FLOW: </b></td>
								</tr>
								<tr>
									<td><b>P1 Waste: </b></td>
									<td id="P1Waste"></td>
								</tr>
								<tr>
									<td><b>P2 Blowers: </b></td>
									<td id="P2Blowers_1"></td>
									<td id="P2Blowers_1SCFM"><b>SCFM: </b></td>
									<td id="P2Blowers_2"></td>
									<td id="P2Blowers_2SCFM"><b>SCFM: </b></td>
									<td id="P2Blowers_3"></td>
									<td id="P2Blowers_3SCFM"><b>SCFM: </b></td>
									<td id="P2Blowers_4"></td>
									<td id="P2Blowers_4SCFM"><b>SCFM: </b></td>
									<td id="P2Blowers_5"></td>
									<td id="P2Blowers_5SCFM"><b>SCFM: </b></td>
									<td id="P2Blowers_6"></td>
									<td id="P2Blowers_6SCFM"><b>SCFM: </b></td>
								</tr>
								<tr>
									<td><b>P2 Return: </b></td>
									<td id="P2Return_1a"></td>
									<td id="P2Return_1b"></td>
									<td id="P2Return_1c"></td>
									<td id="P2Return_2a"></td>
									<td id="P2Return_2b"></td>
									<td id="P2Return_2c"></td>
									<td id="P2Return_3a"></td>
									<td id="P2Return_3b"></td>
									<td id="P2Return_3c"></td>
									<td id="P2Return_4a"></td>
									<td id="P2Return_4b"></td>
									<td id="P2Return_4c"></td>
									<td id="P2Waste"><b>Waste: </b></td>
								</tr>
								<tr>
									<td><b>T1: </b></td>
									<td id="T1FLOW"><b>Flow: </b></td>
									<td id="T1Waste" ><b>Waste: </b></td>
									<td><b>T2: </b></td>
									<td id="T2FLOW"><b>Flow: </b></td>
									<td id="T2Waste"><b>Waste: </b></td>
								</tr>
								<tr>
									<td><b>T3: </b></td>
									<td id="T3FLOW"><b>Flow: </b></td>
									<td id="T3Waste"><b>Waste: </b></td>
									<td><b>T4: </b></td>
									<td id="T4FLOW"><b>Flow: </b></td>
									<td id="T4Waste"><b>Waste: </b></td>
								</tr>
								<tr>
									<td><b>P3 Blowers: </b></td>
									<td id="P3Blowers_1"></td>
									<td id="P3Blowers_1SCFM"><b>SCFM: </b></td>
									<td id="P3Blowers_2"></td>
									<td id="P3Blowers_2SCFM"><b>SCFM: </b></td>
									<td id="P3Blowers_3"></td>
									<td id="P3Blowers_3SCFM"><b>SCFM: </b></td>
								</tr>
								<tr>
									<td><b>P3 Return: </b></td>
									<td id="P3Return_1"></td>
									<td id="P3Return_2"></td>
									<td id="P3Return_3"></td>
									<td id="P3ReturnFLOW"><b>FLOW: </b></td>
									<td id="P3Waste"><b>Waste: </b></td>									
								</tr>
								<tr>
									<td><b>Recirc Pumps: </b></td>
									<td id="RecircPumps_1"></td>
									<td id="RecircPumps_2"></td>
								</tr>
								<tr>
									<td><b>Plant Water: </b></td>
									<td id="PlantWater_1"></td>
									<td id="PlantWater_2"></td>
									<td id="PlantWater_3"></td>
									<td id="PlantWater_4"></td>
									<td id="PlantWater_5"></td>
									<td id="PlantWater_6"></td>
									<td id="HydroPSI"><b>Hydro PSI: </b></td>
								</tr>
								<tr>
									<td><b>Filter Pumps: </b></td>
									<td id="FilterPumps_1"></td>
									<td id="FilterPumps_2"></td>
									<td id="FilterPumps_3"></td>
									<td id="CompPSI"><b>CompPSI: </b></td>
								</tr>
								<tr>
									<td><b>Digester Blowers: </b></td>
									<td id="DigesterBlowers_6"></td>
									<td id="DigesterBlowers_6SCFM"><b>SCFM: </b></td>
									<td id="DigesterBlowers_7"></td>
									<td id="DigesterBlowers_7SCFM"><b>SCFM: </b></td>
									<td id="DigesterBlowers_8"></td>
									<td id="DigesterBlowers_8SCFM"><b>SCFM: </b></td>
									<td id="DigesterBlowers_9"></td>
									<td id="DigesterBlowers_9SCFM"><b>SCFM: </b></td>
									<td id="DigesterBlowers_10"></td>
									<td id="DigesterBlowers_10SCFM"><b>SCFM: </b></td>
									<td id="DigesterBlowers_11"></td>
									<td id="DigesterBlowers_11SCFM"><b>SCFM: </b></td>
								</tr>
								<tr>
									<td><b>Belt Press: </b></td>
									<td id="BeltPress"></td>
									<td id="FPM"><b>FPM: </b></td>
									<td><b>Press Pumps: </b></td>
									<td id="PressPumps_1"></td>
									<td id="PressPumps_2"></td>
									<td id="PressPumps_3"></td>
									<td id="GPM"><b>GPM: </b></td>
								</tr>
								<tr>								
									<td id="Polymer"><b>Polymer: </b></td>
									<td id="GPH"><b>GPH: </b></td>
									<td><b>Head of Plant: </b></td>
									<td id="HeadOfPlant_1"></td>
									<td id="HeadOfPlant_2"></td>
									<td id="HeadOfPlant_3"></td>
								</tr>
								<tr>
									<td><b>Sand Filters: </b></td>
									<td id="SandFilters_1"></td>
									<td id="SandFilters_2"></td>
									<td id="SandFilters_3"></td>
									<td id="SandFilters_4"></td>
									<td id="SandFilters_5"></td>
								</tr>
								<tr>
									<td><b>Contact Basin: </b></td>
									<td id="ContactBasin"></td>
									<td><b>CL2 Actuator Control Box: </b></td>
									<td id="CL2AllLightsGreen"></td>
									<td id="CL2North"><b>North: </b></td>
									<td id="CL2South"><b>South: </b></td>
								</tr>
								<tr>
									<td><b>SO2 Actuator Control Box: </b></td>
									<td id="SO2AllLightsGreen"></td>
									<td id="SO2East"><b>East: </b></td>
								</tr>
								<tr>
									<td><b>Chlorinators: </b></td>
									<td id="Chlorinators_1"></td>
									<td id="Chlorinators_2"></td>
									<td id="Chlorinators_3"></td>
									<td id="Chlorinators_4"></td>
									<td id="ChlorNorth"><b>North: </b></td>
									<td id="ChlorSouth"><b>South: </b></td>
								</tr>
								<tr>
									<td><b>Sulfonators: </b></td>
									<td id="Sulfonators_1"></td>
									<td id="Sulfonators_2"></td>
									<td id="Sulfonators_3"></td>
									<td id="SulfonatorEast"><b>East: </b></td>
									<td id="SulfonatorWest"><b>West: </b></td>
								</tr>
								<tr>
									<td><b>Effluent Sampler: </b></td>
									<td id="EffluentSampler"></td>
								</tr>
							</table>
						 
						</tr>
					</table>	
				</tr>
				<tr>
					<table >
						<tr colspan="3">
							<td><h4><strong>EQUIPMENT OUT-OF-SERVICE:</strong></h4></td>
						</tr>					
						<tr>
							<td id="EquipmentOOS"></td>
						</tr>
					</table>	
				</tr>
				<tr>
					<table >
						<tr colspan="3">
							<td><h4><strong>NOTES/COMMENTS:</strong></h4></td>
						</tr>					
						<tr>
							<td id="NotesComments"></td>
						</tr>
					</table>	
				</tr>
				<tr >
					<td colspan="3"><h4><strong>BEFORE ENTERING ANY DRY WELL, THE FOLLOWING INFORMATION MUST BE DOCUMENTED:</strong></h4></td>
				</tr>
				<tr>
					<table>
						<tr> <td colspan="3"><strong><u>PRAIRIE CREEK EAST:</u></strong></td>
						</tr>
						<tr><td colspan="2">Are exhaust fans operational?</td><td id="PCE_fans"></td>
						</tr>
						</tr>
						<tr><td colspan="2">Did you verify safe atmospheric conditions on the RKI gas detector?</td><td id="PCE_RKI"></td>
						</tr>
					</table>
				</tr>
				<tr>
					<table>
						<tr> <td colspan="3"><strong><u>PRAIRIE CREEK WEST:</u></strong></td>
						</tr>
						<tr><td colspan="2">Are exhaust fans operational?</td><td id="PCW_fans"></td>
						</tr>
						</tr>
						<tr><td colspan="2">Did you verify safe atmospheric conditions on the RKI gas detector?</td><td id="PCW_RKI"></td>
						</tr>
					</table>
				</tr>
				<tr>
					<table>
						<tr> <td colspan="3"><strong><u>PLANT 1 RETURN BUILDING:</u></strong></td>
						</tr>
						<tr><td colspan="2">Are exhaust fans operational?</td><td id="P1RB_fans"></td>
						</tr>
						</tr>
						<tr><td colspan="2">Did you verify safe atmospheric conditions on the RKI gas detector?</td><td id="P1RB_RKI"></td>
						</tr>
					</table>
				</tr>
				<tr>
					<table>
					<tr><th colspan="3"><h4 style="align:center"><strong><u>RKI ALARM SETPOINTS</u></strong></h4></th>
					</tr>
					<tr>
						<table>
						<tr>
							<td><strong>Oxygen</strong> (Alarms @ 19.4 OR 23.6) </td> <td id="OxygenAlarms"></td>
							<td><strong>Methane</strong> (Alarms @ 10% LEL)</td> <td id="MethaneAlarms"></td>
							<td><strong>H2S</strong> (Alarms @ 10 PPM)</td> <td id="H2SAlarms"></td>
						</tr>
						</table>
					</tr>
					</table>
				
					<table>
					<tr><th colspan="3"><h4 style="align:center"><strong><u>SHIFT READINGS</u></strong></h4></th>
					</tr>
					<tr>
						<td>
							<table class="needsBorder">
								<tr colspan= "3"><strong>PC EAST DRY WELL</strong></tr>
								<tr><td><strong>OXYGEN</strong></td><td id="PCEDWOxygen"></td><td>%VOL</td></tr>
								<tr><td><strong>METHANE</strong></td><td id="PCEDWMethane"></td><td>%LEL</td></tr>
								<tr><td><strong>H2S</strong></td><td id="PCEDWH2S"></td><td>PPM</td></tr>
							</table>
						</td>
						<td>
							<table class="needsBorder">
								<tr colspan= "3"><strong>PC WEST DRY WELL</strong></tr>
								<tr><td><strong>OXYGEN</strong></td><td id="PCWDWOxygen"></td><td>%VOL</td></tr>
								<tr><td><strong>METHANE</strong></td><td id="PCWDWMethane"></td><td>%LEL</td></tr>
								<tr><td><strong>H2S</strong></td><td id="PCWDWH2S"></td><td>PPM</td></tr>
							</table>
						</td>
						<td>
							<table class="needsBorder">
								<tr colspan= "3"><strong>PLANT 1 RETURN</strong></tr>
								<tr><td><strong>OXYGEN</strong></td><td id="P1ROxygen"></td><td>%VOL</td></tr>
								<tr><td><strong>METHANE</strong></td><td id="P1RMethane"></td><td>%LEL</td></tr>
								<tr><td><strong>H2S</strong></td><td id="P1RH2S"></td><td>PPM</td></tr>
							</table>
						</td>
					</tr>
					</table>
				</tr>
			</table>

		
				
		</div>
				
		</div>
		
	<!-- For oauth -->
	<form id="form1" runat="server"></form>
	
	
	
	<script>
		
		
	
		$(document).ready(function(){
			var formFull = window.location.search.slice(window.location.search.indexOf('=') + 1).split('&');
			var form = formFull[0];
			var _rn = formFull[1].slice(formFull[1].indexOf('=') + 1).split('&');
			var form_storage = "form" 
			var _URL 
			
			$.ajax({
				type: "GET",
				url: "http://eservices.cityoflewisville.com/citydata/?datasetid=PSOFIA_WWOperationReport&form=" + form + "&RecordNumber=" + _rn + "&oauthToken=" + OAUTH.access_token +"&datasetformat=jsonp&callback=?",
				contentType: "application/json; charset=utf-8",
				dataType: 'jsonp',
				success: function(e) {
					
					var _ckbox = "";
					
					Object.keys(e.results).forEach(function(key)
						{	
							if (e.results[key].FieldType == "CHECKBOX"){
								
								if (e.results[key].FieldValue == "true"){
									//if the checkbox was true
									_ckbox = "<input type='checkbox' value='" + e.results[key].FieldValue + "' checked >" + e.results[key].FieldName;
									
								} else {
									//if the checkbox was false
									_ckbox = "<input type='checkbox' value='" + e.results[key].FieldValue + "'>" + e.results[key].FieldName;
								}
							
								$("#" + e.results[key].FieldID).append(_ckbox);
								
								
							} else {
								$("#" + e.results[key].FieldID).append(e.results[key].FieldValue);
							}
						})
				
									
				}
			});	
			
			
		});
		
	</script>
	</body>
</html>
	
		