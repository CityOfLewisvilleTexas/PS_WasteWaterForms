"use strict";

// test URLs
//  bad record: http://apps.cityoflewisville.com/beta/viewmixedliquor/default.aspx?record=abcdefghijklmnopqrstuvwxyz
// good record: http://apps.cityoflewisville.com/beta/viewmixedliquor/default.aspx?record=2c0c2d17ddf243d6b5d4e518292c4ca3

console.time("Load to render");

// new Google Charts API
google.charts.load('current', { 'packages': ['corechart'] });

// Vue!
var app = new Vue({
    
    el: "#app",

    data: {
        PlantOperator: '',
        Date: '',
        Shift: '',
        chartWidth: 400,
        chartHeight: 600,
        results: {},
        isLoading: true,
        isLoaded: false,
        isError: false,
        recordnumber: ''

    },

    methods: {
        
        // find a url parameter, sParam, and return the value of it
        getUrlParameter: function(sParam) {
            var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                sURLVariables = sPageURL.split('&'),
                sParameterName,
                i;

            for (i = 0; i < sURLVariables.length; i++) {
                sParameterName = sURLVariables[i].split('=');

                if (sParameterName[0] === sParam) {
                    return sParameterName[1] === undefined ? true : sParameterName[1];
                }
            }
        },

        // draw the charts on the page
        // useful for console debugging
        drawCharts: function() {

            // update info fields
            app.PlantOperator = app.results.PlantOperator;
            app.Date = app.results.Date;
            app.Shift = app.results.Shift;

            // chart styling
            var chart = new google.visualization.LineChart(document.getElementById('P1N'));
            var options = {
                title: '',
                width: app.chartWidth,
                height: app.chartHeight,
                pointSize: 7,
                lineSize: 3,
                titleTextStyle: {
                    fontSize: 20
                },
                legend: {
                    position: 'none'
                },
                chartArea: {
                    width: 'auto',
                    height: 'auto'
                },
                hAxis: {
                    title: 'minutes',
                    gridlines: {
                        color: 'transparent'
                    }
                },
                vAxis: {
                    title: 'milligrams / liter',
                    viewWindow: {
                        max: 1000,
                        min: 0
                    }
                }
            }

            // Plant 1N
            options.title = 'Plant 1 North';
            var data = new google.visualization.DataTable();
            data.addColumn("number", "Minutes");
            data.addColumn("number", "mg/L");
            data.addRows([
                [5, app.results.Plant1N_5],
                [10, app.results.Plant1N_10],
                [15, app.results.Plant1N_15],
                [20, app.results.Plant1N_20],
                [25, app.results.Plant1N_25],
                [30, app.results.Plant1N_30],
            ]);

            chart.draw(data, options);

            // Plant 1S
            chart = new google.visualization.LineChart(document.getElementById('P1S'));
            options.title = 'Plant 1 South'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant1S_5],
                [10, app.results.Plant1S_10],
                [15, app.results.Plant1S_15],
                [20, app.results.Plant1S_20],
                [25, app.results.Plant1S_25],
                [30, app.results.Plant1S_30],
            ]);

            chart.draw(data, options);

            // Plant 2T1
            chart = new google.visualization.LineChart(document.getElementById('2T1'));
            options.title = 'Plant 2T1'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant2T1_5],
                [10, app.results.Plant2T1_10],
                [15, app.results.Plant2T1_15],
                [20, app.results.Plant2T1_20],
                [25, app.results.Plant2T1_25],
                [30, app.results.Plant2T1_30],
            ]);

            chart.draw(data, options);

            // Plant 2T2
            chart = new google.visualization.LineChart(document.getElementById('2T2'));
            options.title = 'Plant 2T2'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant2T2_5],
                [10, app.results.Plant2T2_10],
                [15, app.results.Plant2T2_15],
                [20, app.results.Plant2T2_20],
                [25, app.results.Plant2T2_25],
                [30, app.results.Plant2T2_30],
            ]);

            chart.draw(data, options);

            // Plant 2T3
            chart = new google.visualization.LineChart(document.getElementById('2T3'));
            options.title = 'Plant 2T3'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant2T3_5],
                [10, app.results.Plant2T3_10],
                [15, app.results.Plant2T3_15],
                [20, app.results.Plant2T3_20],
                [25, app.results.Plant2T3_25],
                [30, app.results.Plant2T3_30],
            ]);

            chart.draw(data, options);


            // Plant 2T4
            chart = new google.visualization.LineChart(document.getElementById('2T4'));
            options.title = 'Plant 2T4'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant2T4_5],
                [10, app.results.Plant2T4_10],
                [15, app.results.Plant2T4_15],
                [20, app.results.Plant2T4_20],
                [25, app.results.Plant2T4_25],
                [30, app.results.Plant2T4_30],
            ]);

            chart.draw(data, options);

            // Plant 3N
            chart = new google.visualization.LineChart(document.getElementById('3N'));
            options.title = 'Plant 3N'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant3N_5],
                [10, app.results.Plant3N_10],
                [15, app.results.Plant3N_15],
                [20, app.results.Plant3N_20],
                [25, app.results.Plant3N_25],
                [30, app.results.Plant3N_30],
            ]);

            chart.draw(data, options);

            // Plant 3S
            chart = new google.visualization.LineChart(document.getElementById('3S'));
            options.title = 'Plant 3S'
            data.removeRows(0,6);
            data.addRows([
                [5, app.results.Plant3S_5],
                [10, app.results.Plant3S_10],
                [15, app.results.Plant3S_15],
                [20, app.results.Plant3S_20],
                [25, app.results.Plant3S_25],
                [30, app.results.Plant3S_30],
            ]);

            chart.draw(data, options);

            console.timeEnd("Load to render");
        },

        getData: function(loading, loaded, error) {

        	this.recordnumber = this.getUrlParameter('record');

            // isLoading
            this.isLoading = loading;
            this.isLoaded = loaded;
            this.isError = error;

            // hit web service
            $.post('https://query.cityoflewisville.com/v2/', {

                webservice: 'Public Services/Waste Water/View Mixed Liquor',
                RecordNum: this.recordnumber

            }, function(results) {
                
                app.results = results[0][0];
                console.log(">>> searching for: " + app.recordnumber);

                if (results[0].length == 0) {

                    // isError
                    app.isError = true;
                    app.isLoading = false;
                    app.isLoaded = false;

                    console.log(">>> error");


                } else {

                    // isLoaded
                    app.isLoaded = true;
                    app.isError = false;
                    app.isLoading = false;

                    console.log(">>> loaded: ");
                    console.dir(app.results);

                    app.drawCharts();

                }
            });


        }

    },

    created: function() {

        this.getData(true, false, false);
    }

});

// function getData(recordnumber) {

//     // isLoading
//     app.isLoading = true;
//     app.isLoaded = false;
//     app.isError = false;

//     // hit web service
//     $.post('https://query.cityoflewisville.com/v2/', {

//         webservice: 'Public Services/Waste Water/View Mixed Liquor',
//         Date_: _d,
//         WorkShift: _s,
//         RecordNum: recordnumber

//     }, function(results) {
//         var origData = results;
//         app.results = results[0][0];
//         console.dir(results);
//         console.log(recordnumber);

//         console.log(results[0].length);

//         if (results[0].length === 0) {

//             // isError
//             app.isError = true;
//             app.isLoading = false;
//             app.isLoaded = false;


//         } else {

//             app.isLoaded = 'isLoaded';
//             app.recordnumber = recordnumber;

//             app.drawCharts();

//         }
//     });


// };
