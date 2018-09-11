"use strict";
// google.charts.load('current', { 'packages': ['corechart'] });
google.charts.load('current', { 'packages': ['line', 'table'] });
google.charts.setOnLoadCallback(googleReady);
var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
];
var d = new Date();
var quickChart;

// Vue!
var app = new Vue({
    el: "#app",

    data: {

        showTotals: false,

        now: monthNames[d.getMonth()] + ' ' + d.getFullYear(),
        day1: '[Error]',
        day2: '[Error]',
        day3: '[Error]',
        wasteDay1: '???',
        wasteDay2: '???',
        wasteDay3: '???',
        isLoading: false,
        isLoadingGraph: false,
        isLoadingDoReadings: true,
        isLoadingTotals: true,
        isLoadingWaste: true,
        isLoadingAmm: true,
        isLoadingAmmDo: true,
        isLoaded: false,
        error: false,
        isPanel: true,
        menuBtnClass: 'arrow_back',
        headerSelect: '',
        quickChartData: {},
        doReadingsData: {},
        doReadingsDataByDay: {},
        doReadingsData2: [],
        doReadingsData3: [],
        showWasteDetails: { a: false, b: false, c: false },
        showAmmDetails: false,
        plantWasteTotals: [],
        plantNames: ['Date', 'Shift', '1N_1', '1N_2', '1N_3', '1S_1', '1S_2', '1S_3', '2T1_1', '2T1_2', '2T1_3', '2T1_Actually_Wasted', '2T1_ToBe_Wasted', '2T2_1', '2T2_2', '2T2_3', '2T2_Actually_Wasted', '2T2_ToBe_Wasted', '2T3_1', '2T3_2', '2T3_3', '2T3_Actually_Wasted', '2T3_ToBe_Wasted', '2T4_1', '2T4_2', '2T4_3', '2T4_Actually_Wasted', '2T4_ToBe_Wasted', '_3N', '_3S'],
        totals: {
            CL2Average: '---',
            CurrentRun: '---',
            Effluent: '---',
            Influent: '---',
            SO2Average: '---'
        },
        ammoniaThirtyDays: [],
        doReadings: [],

        // this format is used for the visual graphs.
        // sql column,      display name,       units (optional)        subtitle (optional)
        headers: [
            ['TotalInfluent', 'Total Influent', 'Millions of gal/day', 'x1000'],
            ['PrairieCreek', 'Prairie Creek', 'Millions of gal/day', 'x1000'],
            ['TimberCreek', 'Timber Creek', 'Millions of gal/day', 'x1000'],
            ['TotalEffluent', 'Total Effluent', '', 'x1000'],
            ['PeakFlow', '2 Hour Peak Flow', 'Millions of gal/day', 'x1000'],
            ['HeadPlant', 'Head of Plant', '', ''],
            ['Rainfall', 'Rainfall', 'Inches', ''],

            ['INF2T1', 'Plant 2T1 INF.', '', 'x1000'],
            ['INF2T2', 'Plant 2T2 INF.', '', 'x1000'],
            ['INF2T3', 'Plant 2T3 INF.', '', 'x1000'],
            ['INF3', 'Plant 3 INF.', '', 'x1000'],

            ['RAS1', 'Plant 1 RAS.', '', 'x1000'],
            ['RAS2T1', 'Plant 2T1 RAS.', '', 'x1000'],
            ['RAS2T2', 'Plant 2T2 RAS.', '', 'x1000'],
            ['RAS2T3', 'Plant 2T3 RAS.', '', 'x1000'],
            ['RAS2T4', 'Plant 2T4 RAS.', '', 'x1000'],
            ['RAS3', 'Plant 3 RAS.', '', 'x1000'],

            ['WAS1', 'Plant 1 WAS.', '', 'x1000'],
            ['WAS2T1', 'Plant 2T1 WAS.', '', 'x1000'],
            ['WAS2T2', 'Plant 2T2 WAS.', '', 'x1000'],
            ['WAS2T3', 'Plant 2T3 WAS.', '', 'x1000'],
            ['WAS2T4', 'Plant 2T4 WAS.', '', 'x1000'],
            ['WAS3', 'Plant 3 WAS.', '', 'x1000'],
        ],
      wasteData: [],
      ammGrabAvg: 0,
      ammCompAvg: 0,
      ammoniaFiveDays: [],
    },

    methods: {

        seeTotals: function() {
            this.showTotals = true;
        },

        // open new form
        fabClick: function() {
            console.log('fab click');
        },

        // search for new date based on Selects
        searchTotals: function() {

            axios.post('https://query.cityoflewisville.com/v2/', {
                webservice: 'Public Services/Waste Water/SO2CL2Averages'
            }).then(function(results) {
                app.isLoadingTotals = false;
                if (results.data[0][0].length < 1) app.error = true;
                else {
                    app.totals = results.data[0][0];
                    app.round('totals');
                }
            });
        },

        searchGraphs: function() {

            if (app.isLoadingGraph) return

            if (this.headerSelect == '') {
                alert('Please choose a header');
            } else {

                // hacky smh
                document.getElementById('graph').innerHTML = '<div id="graph-loader" class="loader" v-bind:class="{ hidden : !isLoadingGraph }"></div>';
                quickChart = null;
                app.isLoadingGraph = true;

                axios.post('https://query.cityoflewisville.com/v2/', {
                    webservice: 'Public Services/Waste Water/Control Panel Worksheet',
                    reportNum: 47,
                    Month: d.getMonth() + 1,
                    Year: d.getFullYear()
                }).then(function(results) {
                    // save data
                    app.quickChartData = results.data[0];
                    app.drawQuickChart();
                    app.isLoadingGraph = false;
                  
                    
                });
            }
        },

        searchDOReadings: function() {
            console.time('timer');
            this.isLoadingDoReadings = true;
            axios.post('https://query.cityoflewisville.com/v2/', {
                webservice: 'Public Services/Waste Water/OperationsReport',
            }).then(function(results) {
                app.isLoadingDoReadings = false;
                app.doReadingsData = results.data[0];
                app.doData = Object.assign([], results.data[0]);
                console.log(app.doData)
                if (app.doReadingsData.length > 0) app.splitDoDataByDay();
            }).catch(function(e) {
                console.log(e);
            });
        },

        searchWaste: function() {
            this.isLoadingWaste = true;

            axios.post('https://query.cityoflewisville.com/v2/', {
                webservice: 'Public Services/Wastewater/View WW Plant Report',
                record: '54e4f738a83f4d14b6e72dd254cf1404'
            }).then(function(data) {

                app.isLoadingWaste = false;

                // get the totals
                app.plantWasteTotals = data.data
                app.wasteData = Object.assign([], data.data);
                console.log('Waste Data:')
                //console.log(JSON.stringify(app.wasteData))
                app.plantWasteHourly = Object.assign([], data.data)

                // filter : totals only
                app.filterWasteTotals()

                // get the waste numbers
                // app.plantWasteHourly = data.data[0].filter(function(a) {
                //     return a.FieldID.includes('Waste');
                // })
                // .map(function(a, b) {
                //     return { FieldID: a.FieldID, FieldValue: a.FieldValue };
                // });

            }).catch(function(e) {
                //alert('Something went wrong. Check log.');
                console.log(e);
            })
        },
        searchAmm: function() {
            this.isLoadingAmm = true;

            axios.post('https://query.cityoflewisville.com/v2/', {
                webservice: 'Public Services/Wastewater/viewWWAmmoniaFiveDays',
            }).then(function(data) {
                app.isLoadingAmm = false;

                app.ammoniaFiveDays = data.data[0];
                
                console.log(data.data);
                app.avgAmm();

            }).catch(function(e) {
                //alert('Something went wrong. Check log.');
                console.log(e);
            })
        },
        searchAmmDO_30: function() {
            this.isLoadingAmmDo = true;

            axios.post('https://query.cityoflewisville.com/v2/', {
                webservice: 'PublicServices/Wastewater/viewAmmoniaDo30Days',
            }).then(function(data) {
                app.isLoadingAmmDo = false;

                app.ammoniaThirtyDays = data.data[0];
                
                console.log(data.data);
                //app.avgAmm();
              app.chartAmmDO();

            }).catch(function(e) {
                //alert('Something went wrong. Check log.');
                console.log(e);
            })
        },
        chartAmmDO: function() {
          var self = this;
          
          // entry point to call 
          google.charts.load('current', {'packages':['corechart']});
          google.charts.setOnLoadCallback(drawChart);
          
          // transform array of objects to multideminsional array for google charts
          function parseData() {
            let data =[];
            
            self.ammoniaThirtyDays.forEach((day, idx) => {
              if (idx === 0) {
                // set column names
                data.push(Object.keys(day));
              }
              // set row values
              data.push(Object.values(day));
            });
            return data;
          }
          
          // callback to draw chart
          function drawChart() {
            var data = google.visualization.arrayToDataTable(parseData());
            
            // chart customizations
            var options = {
              chart: {
                title: 'Ammonia and DO 30 Days',
                //subtitle: 'Ammonia Avg Daily, DO From _3 Avg Daily'
                legend: {position: 'bottom'}
              },
              height: 400,
              hAxis: {
                viewWindowMode: 'explicit',
                viewWindow: {
                  min: 1,
                  max: 31
                }
              }
            };
            
            var chart = new google.visualization.LineChart(document.getElementById('graph'));
            
            // draw chart on callback call:
            chart.draw(data, options);
          }
        },
        checkAmm2pm: function() {
          let now = new Date();
          
          return (now.getHours() >= 14 && (this.ammoniaFiveDays[this.ammoniaFiveDays.length - 1].effcomposite !== ''))
        },

        splitDoDataByDay: function() {
            console.timeEnd('timer');

            // split data up by date
            this.doReadingsDataByDay = this.doReadingsData.reduce(function(acc, val) {
                console.log("Date: " + val.Date);
                
                if (val.Date in acc) {
                    acc[val.Date].push(val)
                    return acc
                } else {
                    acc[val.Date] = [val]
                    return acc
                }
            }.bind(this), {});

            console.log(this.doReadingsDataByDay);


            this.drawDoTable();
        },

        filterWasteTotals: function() {
            // only totals, certain fields, and sorted by plant name
            for (var i in this.plantWasteTotals) {
                this.plantWasteTotals[i] = this.plantWasteTotals[i].filter(function(a) {
                        //if (/EffCompositeAVG|EffGrabAVG/.test(a.FieldID)) app.ammonia.push(a);
                        return /TTL/.test(a.FieldID); //a.FieldID.includes('TTL')
                    }).map(function(a, b) {
                        return { Date: a.Date, FieldID: a.FieldID.replace('_', 'P'), FieldValue: a.FieldValue };
                    }).sort(function(a, b) {
                        return a.FieldID > b.FieldID;
                    });
              
                    // .filter(function(a) {
                    //     return a.FieldID.includes('TTL');
                    // }).map(function(a, b) {
                    //     return { FieldID: a.FieldID, FieldValue: a.FieldValue };
                    // });
            }

            // WHY DOES THIS WORK?
            setTimeout(function() {
                app.drawWasteTable();
            }, 5);

            // console.log(this.selectedEls)
            console.log('wasteTotals:')
            console.log(this.plantWasteTotals);
        },
      
        avgAmm: function() {
          var self = this;
          var compCount = 0, grabCount = 0, compTotal = 0, grabTotal = 0;
          
          self.ammoniaFiveDays.forEach((day, idx) => {
            let grab = parseFloat(day.effgrab) || '';
            let comp = parseFloat(day.effcomposite) || '';
            //console.log(comp)
            if (!comp == '') {
              compTotal += comp;
              compCount++;
            }
            if (!grab == '') {
              grabTotal += grab;
              grabCount++;
            }
            
          });
          
          self.ammCompAvg = (compTotal / compCount).toFixed(2);
          self.ammGrabAvg = (grabTotal / grabCount).toFixed(2);
        },

        drawQuickChart: function() {
            // for total influent
            if (app.headerSelect == 'TotalInfluent') {
                for (var j = 0; j < this.quickChartData.length; j++) {
                    this.quickChartData[j].TotalInfluent = parseFloat(this.quickChartData[j].PrairieCreek) + parseFloat(this.quickChartData[j].TimberCreek);
                }
            }

            // google graph options
            quickChart = new google.charts.Line(document.getElementById('graph'));
            var chartData = new google.visualization.DataTable();
            chartData.addColumn('number', 'Day');

            // chart customizations
            var options = {
                chart: {
                    title: app.titleHelper(app.headerSelect),
                    subtitle: app.subtitleHelper(app.headerSelect)
                },
                height: 400,
                hAxis: {
                    viewWindowMode: 'explicit',
                    viewWindow: {
                        min: 1,
                        max: 31
                    }
                }
            };

            // check if there is a flow and reading field
            if (app.isFlowAndReading(app.headerSelect)) {

                chartData.addColumn('number', 'Reading');
                chartData.addColumn('number', 'Flow');

                // fill data
                for (var i = 0; i < this.quickChartData.length; i++) {
                    var reading = this.quickChartData[i][app.headerSelect + '_r'];
                    var flow = this.quickChartData[i][app.headerSelect + '_f'];
                    chartData.addRow([i + 1, parseFloat(reading), parseFloat(flow)]);
                }

            } else {

                chartData.addColumn('number', app.yAxisHelper(app.headerSelect));
                // fill data
                for (var i = 0; i < this.quickChartData.length; i++) {
                    var value = this.quickChartData[i][app.headerSelect];
                    chartData.addRow([i + 1, parseFloat(value)]);
                }
            }
            // this.drawQuickChart(chartData, quickChart);
            quickChart.draw(chartData, google.charts.Line.convertOptions(options));
        },

        drawDoTable: function() {

            // loop through days in data
            var c = 1;
            for (var day in this.doReadingsDataByDay) {
                if (this.doReadingsDataByDay.hasOwnProperty(day)) {

                    // each do readings table
                    var table = document.getElementById('table' + c.toString());
                    
                    // remove the old data (except the headers)
                    $('#table' + c.toString()).find('tr:gt(0)').remove();
                    this['day' + c.toString()] = day;

                    // loop through shifts in day
                    for (var i in this.doReadingsDataByDay[day]) {

                        var row = table.insertRow(-1);

                        // loop through fields in shift
                        for (var field in this.doReadingsDataByDay[day][i]) {
                            if (this.doReadingsDataByDay[day][i].hasOwnProperty(field)) {

                                var cell = row.insertCell(-1);
                                cell.innerHTML = this.doReadingsDataByDay[day][i][field];
                            }
                        }

                    }
                    hScroller('table' + c.toString());

                }
                c++;
            }
        },

        drawWasteTable: function() {

            // each day in the totals
            for (var day in this.plantWasteTotals) {

                // get table
                var table = document.getElementById('waste-table' + (Number(day) + 1));
                var row = table.insertRow(-1);

                // each total within the day
                for (var total in this.plantWasteTotals[day]) {
                    var cell = row.insertCell(-1);
                    cell.innerHTML = this.plantWasteTotals[day][total].FieldValue;
                }
                var cell = row.insertCell(0)
                cell.innerHTML = '<b>Total</b>';
            }

            // add tbody to the tables
            var tbody1 = document.createElement('tbody')
            tbody1.setAttribute('id', 'waste-table-details1')
            document.getElementById('waste-table1').appendChild(tbody1)

            var tbody2 = document.createElement('tbody')
            tbody2.setAttribute('id', 'waste-table-details2')
            document.getElementById('waste-table2').appendChild(tbody2)

            var tbody3 = document.createElement('tbody')
            tbody3.setAttribute('id', 'waste-table-details3')
            document.getElementById('waste-table3').appendChild(tbody3)

            // each day in the hourly details
            for (var day in this.plantWasteHourly) {

                if (day == 0) this.wasteDay1 = this.plantWasteHourly[day][0].Date
                else if (day == 1) this.wasteDay2 = this.plantWasteHourly[day][0].Date
                else if (day == 2) this.wasteDay3 = this.plantWasteHourly[day][0].Date

                // get table
                var table2 = document.getElementById('waste-table-details' + (Number(day) + 1));

                

                // loop through hours of day 
                for (var hour = 0; hour < 24; hour += 2) {
                    
                    // cells/values for each row
                    var cell0, cell1, cell2, cell3, cell4, cell5, cell6;
                    var v1 = '',
                        v2 = '',
                        v3 = '',
                        v4 = '',
                        v5 = '',
                        v6 = '';
                  
                    // get the formatted hour
                    var hourStr = '';
                    if (hour % 12 == 0 && hour < 12) hourStr = "12am"
                    else if (hour % 12 == 0) hourStr = "12pm"
                    else if (hour < 12) hourStr = (hour % 12).toString() + 'am'
                    else hourStr = (hour % 12).toString() + 'pm'

                    // new row for each hour
                    var row = table2.insertRow(-1)

                    // loop through data
                    for (var i in this.plantWasteHourly[day]) {
                        // console.log(this.plantWasteHourly[day][i])

                        // copy field name and value
                        var s = this.plantWasteHourly[day][i].FieldID
                        var v = this.plantWasteHourly[day][i].FieldValue

                        if (s.includes(hourStr) && s.includes('P1')) v1 = v
                        else if (s.includes('2T1Waste' + hourStr)) v2 = v
                        else if (s.includes('2T2Waste' + hourStr)) v3 = v
                        else if (s.includes('2T3Waste' + hourStr)) v4 = v
                        else if (s.includes('2T4Waste' + hourStr)) v5 = v
                        else if (s.includes('P3Waste' + hourStr)) v6 = v
                    }

                    // populate row
                    cell0 = row.insertCell(-1);
                    cell0.innerHTML = hourStr
                    cell1 = row.insertCell(-1);
                    cell1.innerHTML = v1
                    cell2 = row.insertCell(-1);
                    cell2.innerHTML = v2
                    cell3 = row.insertCell(-1);
                    cell3.innerHTML = v3
                    cell4 = row.insertCell(-1);
                    cell4.innerHTML = v4
                    cell5 = row.insertCell(-1);
                    cell5.innerHTML = v5
                    cell6 = row.insertCell(-1);
                    cell6.innerHTML = v6

                }

                // build row
                // var row2 = table2.insertRow(-1);
                // for (var i = 0; i < 7; i++) {
                //     var cell2 = row2.insertCell(-1);
                //     cell2.innerHTML = 'tester';
                // }
            }

            console.log(this.plantWasteTotals)
        },

        isFlowAndReading: function(header) {

            if (
                header.includes('TotalEffluent') ||
                header.includes('HeadPlant') ||
                header.includes('INF') ||
                header.includes('RAS') ||
                header.includes('WAS')
            ) {
                return true;
            } else {
                return false;
            }

        },

        // takes a header and returns the units it uses
        yAxisHelper: function(header) {
            for (var i = 0; i < this.headers.length; i++) {
                if (this.headers[i][0] == header) return this.headers[i][2];
            }
            return 'Header error';
        },

        // takes a header and returns the subtitle if it exists
        subtitleHelper: function(header) {
            for (var i = 0; i < this.headers.length; i++) {
                if (this.headers[i][0] == header) return this.headers[i][3];
            }
            return '';
        },

        // takes a header and returns the title
        titleHelper: function(header) {
            for (var i = 0; i < this.headers.length; i++) {
                if (this.headers[i][0] == header) return this.headers[i][1];
            }
            return '';
        },

        // round to .xxxx
        round: function(foo) {
            Object.keys(app[foo]).forEach(function(key, index) {
                var val = parseFloat(app[foo][key]);
                app[foo][key] = val.toFixed(3);
            });
        },

        togglePanel: function() {
            this.isPanel = !this.isPanel;
            this.menuBtnClass = (this.menuBtnClass == 'menu') ? 'arrow_back' : 'menu';
        },

        toggleWasteTable: function(n) {
            switch (n) {
                case 0:
                    this.showWasteDetails.a = !this.showWasteDetails.a;
                    break;
                case 1:
                    this.showWasteDetails.b = !this.showWasteDetails.b;
                    break;
                case 2:
                    this.showWasteDetails.c = !this.showWasteDetails.c;
                    break;
                default:
                    break;
            }
            // this.showWasteDetails[n] = !this.showWasteDetails[n];
            // console.log(this.showWasteDetails[n]);
        },
      
        toggleAmmTable: function() {
              this.showAmmDetails = !this.showAmmDetails;
        },

        // checks for numeric table data
        isNumeric: function(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        },

        addPanelOption: function(li) {
            if (!li.displayText) return;

            var frame = '<li>';
            frame += (li.newLink) ? '<a class="a-btn" href="' + li.newLink + '" target="_blank"><i class="material-icons">add</i></a>' : '';
            frame += (li.searchLink) ? '<a class="a-btn" href="http://eservices.cityoflewisville.com/WastewaterForms/viewControlPanelWorksheet/" target="_blank"><i class="material-icons">search</i></a>' : '';
            frame += '<span><a href="' + li.editLink + '" target="_blank">' + li.displayText + '</a></span></li>';

            $('#panel-list').append(frame);
        },

        loopLiftStations: function() {

            var baseNew = 'http://eservices.cityoflewisville.com/psofia/node/index.html?form=';
            var baseEdit = 'http://eservices.cityoflewisville.com/psofia/editform/default.aspx?formnumber=';
            var baseHistorical = 'http://eservices.cityoflewisville.com/psofia/historysearch/default.aspx?dept=1';
            var baseSearch = 'http://eservices.cityoflewisville.com/WastewaterForms/viewControlPanelWorksheet/';
            var baseNewConfine = 'http://eservices.cityoflewisville.com/psofia/utilities/confinedspacereport/';
            var baseEquipReport = 'http://eservices.cityoflewisville.com/WastewaterForms/EquipmentReport/'
            // build panel options
            this.addPanelOption({ newLink: '', editLink: baseHistorical, searchLink: '', displayText: 'Historical Form Search' });
            this.addPanelOption({ newLink: baseNew + '2', editLink: baseEdit + '2', searchLink: '', displayText: 'Plant Report' });
            this.addPanelOption({ newLink: baseNew + '5', editLink: baseEdit + '5', searchLink: '', displayText: 'Mixed Liquor Settleability' });
            this.addPanelOption({ newLink: baseNew + '47', editLink: baseEdit + '47', searchLink: baseSearch, displayText: 'Control Panel Worksheet' });
            this.addPanelOption({ newLink: baseNew + '1', editLink: baseEdit + '1', searchLink: '', displayText: 'OperationsReport' });
            this.addPanelOption({ newLink: baseNew + '81', editLink: baseEdit + '81', searchLink: '', displayText: 'Lift Station Effluent' });
            this.addPanelOption({ newLink: '', editLink: baseEquipReport, searchLink: '', displayText: 'Equipment Report' });
            this.addPanelOption({ newLink: baseNewConfine, editLink: baseEdit + '46', searchLink: '', displayText: 'Confined Space' });

            $('#panel-list').append('<p style="font-weight: bold">Lift Stations</p>');
            var lifts = ['Lake Park', 'Forest Park', 'North Mill', 'Scottie\'s Point', 'Highland Lakes', 'San Antone', 'Valley Four', 'Chase Oaks', 'Lake Pointe', 'Metro-Park', 'Railroad', 'Hidden Cove', 'Ace Lane', 'Castle Hills', 'East Side Sanitary Sewer', 'Whippoorwill', 'Vista Ridge', 'New Timber Creek', 'Police & Fire Training'];
            for (var i in lifts) {
                i = Number(i)
                this.addPanelOption({
                    newLink: baseNew + (i + 17).toString(),
                    editLink: baseEdit + (i + 17).toString(),
                    searchLink: '',
                    displayText: lifts[i]
                })
            }
        },

        initAjaxCalls: function() {
            console.log(':: initAjaxCalls()')
            this.searchTotals();
            this.searchDOReadings();
            this.searchWaste();
            this.searchAmm();
            this.searchAmmDO_30();
        },

        start: function() {

            this.loopLiftStations();

            // refresh page every 5 minutes
            (function() {
                var f = function() { app.initAjaxCalls() }
                window.setInterval(f, 1000 * 60 * 5); // 5min
                f();
            })();

            // $.post('http://mygovhelp.info/LEWISVILLETX/ZAdmin/_ws/_wslib.asmx/GetServiceRequestTypesByCategory?authKey=Y4KSKzcL/iqF&categoryID=9&keywords=', function(data) {
            //     console.log(data);
            // })


            // hide scrollbar in side panel (aesthetics)
            // var parent = document.getElementById('side-panel-parent');
            // var child = document.getElementById('side-panel');
            // child.style.paddingRight = child.offsetWidth - child.clientWidth + 'px';
        }
    },

    // populate dropdowns on creation
    created: function() {}
});

// initial search
function googleReady() {
    app.start();
}

// handle scroll-to buttons
$(document).ready(function() {

    // show/hide scroll-to-top button
    $("#fab2").hide();
    $(window).scroll(function() {
        if ($(this).scrollTop()) {
            $('#fab2:hidden').stop(true, true).fadeIn("fast");
        } else {
            $('#fab2').stop(true, true).fadeOut("fast");
        }
    });

    // scroll-to-top of page
    $("#fab2").click(function(event) {
        $('html, body').animate({
            scrollTop: 0
        }, 500);
    });

    // handles scroll to anchor
    $(".link-td").click(function(event) {
        event.preventDefault();
        $('html, body').animate({
            scrollTop: $($.attr(this, 'href')).offset().top
        }, 500);
    });

    $(window).resize(function() {
        if (quickChart) app.drawQuickChart();

        if (app.isPanel) {
            if ($(window).width() < 700) {
                app.isPanel = false;
                app.menuBtnClass = 'menu';
            }
        }
    });
});
