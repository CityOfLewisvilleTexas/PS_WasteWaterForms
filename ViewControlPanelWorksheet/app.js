"use strict";

// Vue!
var app = new Vue({
    el: "#bigHolder",

    data: {
        years: [],
        months: [],
        days: [],
        sums: {},
        avgs: {},
        max: {},
        min: {},
        isLoading: true,
        isLoaded: false,
        collapse: [false, false, false, false],
        error: false,
        today: new Date(),
        mSelect: new Date().getMonth() + 1,
        ySelect: new Date().getFullYear() - 2016,
        icons: [{ c: true, e: false }, { c: true, e: false }, { c: true, e: false }, { c: true, e: false }],
        tops: {}
    },

    methods: {

        // open new form
        newForm: function() {
            window.open('http://apps.cityoflewisville.com/psofia/default.aspx?form=47', '_blank');
        },

        // search for new date based on Selects
        search: function() {

        	// clear variables
        	this.totalEffluent_top = '';

            // loading animation
            this.isLoading = true;
            this.isLoaded = false;
            this.error = false;

            // add correct number of days to table
            this.days = [];
            var numDays = new Date(this.ySelect + 2016, this.mSelect, 0).getDate();
            for (var i = 0; i < numDays; i++) {
                var obj = {};
                this.days.push(obj);
                this.days[i].Day = i + 1;
            }

            // hit web service
            $.post('https://query.cityoflewisville.com/v2/', {

                webservice: 'Public Services/Waste Water/Control Panel Worksheet',
                reportNum: 47,
                Month: app.mSelect,
                Year: app.ySelect + 2016

            }, function(data) {

                // readability
                var days = data[0];

                // check if actual data is returned
                if (days.length < 1) {
                    app.error = true;
                    app.isLoading = false;
                    app.isLoaded = true;
                    app.sums = {};
                    app.avgs = {};

                } else {

                    // hide loader, show table
                    app.isLoading = false;
                    app.isLoaded = true;

                    // debugging
                    console.dir(data[0]);

                    // loop through all returned data
                    var i = 0;
                    for (i in days) {

                        // replace empty strings with --
                        Object.keys(days[i]).forEach(function(key, index) {
                            if (!days[i][key]) days[i][key] = "--";
                        });

                        // populate each day in tables
                        var x = days[i]['Day'] - 1;
                        app.days[x] = days[i];

                        // sum for TotalInfluent
                        var a = parseInt(app.days[x]['PrairieCreek']);
                        var b = parseInt(app.days[x]['TimberCreek']);
                        app.days[x]['TotalInfluent'] = a + b;

                    }

                    // var r = app.days[0].TotalEffluent_r; console.log(r);
                    // var f = app.days[0].TotalEffluent_f; console.log(f);
                    // if (app.isNumeric(r) && app.isNumeric(f))
                    //     app.totalEffluent_top = parseFloat(r) - parseFloat(f);
                    // else
                    //     app.totalEffluent_top = 0;
                    app.calculateTop('TotalEffluent');
                    app.calculateTop('HeadPlant');
                    app.calculateTop('INF2T1');
                    app.calculateTop('INF2T2');
                    app.calculateTop('INF2T3');
                    app.calculateTop('INF3');
                    app.calculateTop('RAS1');
					app.calculateTop('RAS2T1');
					app.calculateTop('RAS2T2');
					app.calculateTop('RAS2T3');
					app.calculateTop('RAS2T4');
					app.calculateTop('RAS3');
					app.calculateTop('WAS1');
					app.calculateTop('WAS2T1');
					app.calculateTop('WAS2T2');
					app.calculateTop('WAS2T3');
					app.calculateTop('WAS2T4');
					app.calculateTop('WAS3');

                    // r = app.days[0].HeadPlant_r; console.log(r);
                    // f = app.days[0].HeadPlant_f; console.log(f);
                    // if (app.isNumeric(r) && app.isNumeric(f))
                    //     app.headOfPlant_top = parseFloat(r) - parseFloat(f);
                    // else
                    //     app.headOfPlant_top = 0;

                    // update sums/avgs
                    app.sum(i);
                    app.avg(parseInt(i));
                    app.findMax(i);
                    app.findMin(i);

                }
            });
        },

        calculateTop: function(name) {
        	var f = app.days[0][name + '_f'];
			var r = app.days[0][name + '_r'];
            if (this.isNumeric(r) && this.isNumeric(f)) this.tops[name + '_top'] = parseFloat(r) - parseFloat(f);
            else
                this.tops[name + '_top'] = 0;
        },

        // fill out the years/months arrays
        populateSelects: function() {

            // fill years array
            for (var i = 2016; i <= this.today.getFullYear(); i++) {
                var y = {
                    year: i,
                    index: i - 2016,
                    selected: (i == this.today.getFullYear()) ? true : false
                }
                this.years.push(y);
            }

            // fill months array
            var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            for (var i = 1; i < 13; i++) {
                var m = {
                    name: monthNames[i - 1],
                    index: i,
                    selected: (i == this.today.getMonth()) ? true : false
                }
                this.months.push(m);
            }
        },

        // update sums
        sum: function(num) {
            let self = this;
            // reset sums
            Object.keys(self.days[num]).forEach(function(key, index) {
                app.sums[key] = 0;
            });

            // loop through properties, sum up
            for (var i in self.days) {
                Object.keys(self.days[i]).forEach(function(key, index) {
                	app.sums[key] += (!app.isNumeric(app.days[i][key])) ? 0 : parseFloat(app.days[i][key]);
                });
            }
        },

        // update avgs
        avg: function(num) {
            let self = this;
            // reset avgs
            Object.keys(self.days[num]).forEach(function(key, index) {
                app.avgs[key] = 0;
            });

            // loop through properties, avg up
            for (var i in self.days) {
                Object.keys(self.days[i]).forEach(function(key, index) {
                    app.avgs[key] = (!app.isNumeric(app.sums[key])) ? 0.0 : parseFloat((parseFloat(app.sums[key]) / self.days.length).toFixed(2));
                });
            }
        },

        // find maximum
        findMax: function(num) {

            // reset max
            Object.keys(this.days[num]).forEach(function(key, index) {
                app.max[key] = app.isNumeric(app.days[0][key]) ? parseInt(app.days[0][key]) : 0;
            });

            // loop through properties, store max
            for (var i in this.days) {
                Object.keys(this.days[i]).forEach(function(key, index) {

                    if (app.isNumeric(app.days[i][key])) {
                        app.max[key] = (app.days[i][key] >= app.max[key]) ? parseFloat(app.days[i][key]) : parseFloat(app.max[key]);
                    }
                });
            }
        },

        // find minimum
        findMin: function(num) {

            // reset min
            Object.keys(this.days[num]).forEach(function(key, index) {
                app.min[key] = app.isNumeric(app.days[0][key]) ? parseInt(app.days[0][key]) : 0;
            });

            // loop through properties, store min
            for (var i in this.days) {
                Object.keys(this.days[i]).forEach(function(key, index) {

                    if (app.isNumeric(app.days[i][key])) {
                        app.min[key] = (app.days[i][key] <= app.min[key]) ? parseFloat(app.days[i][key]) : parseFloat(app.min[key]);
                    }
                });
            }
        },

        // for collapsing tables on title-click
        hideBody: function(x) {
            this.collapse[x] = !this.collapse[x];
            this.icons[x].c = !this.icons[x].c;
            this.icons[x].e = !this.icons[x].e;
        },

        // checks for numeric table data
        isNumeric: function(n) {
            return !isNaN(parseFloat(n)) && isFinite(n);
        },
        //// TESTING DOWNLOAD TO CSV FOR GLENN /////

    downloadCSV: function(csv, filename) {
      var csvFile;
      var downloadLink;

      // CSV file
      csvFile = new Blob([csv], {type: "text/csv"});

      // Download link
      downloadLink = document.createElement("a");

      // File name
      downloadLink.download = filename;

      // Create a link to the file
      downloadLink.href = window.URL.createObjectURL(csvFile);

      // Hide download link
      downloadLink.style.display = "none";

      // Add the link to DOM
      document.body.appendChild(downloadLink);

      // Click download link
      downloadLink.click();
    },

    exportTableToCSV: function(filename) {
      var csv = [];
      var rows = document.querySelectorAll("table tr");
      
      for (var i = 0; i < rows.length; i++) {
          var row = [], cols = rows[i].querySelectorAll("td, th");
          
          // NOTE: Changes were needed to capture the input values on the rounds sheet.
          // This is the only form that has input values at the moment - CF 12/21/17
          for (var j = 0; j < cols.length; j++) {
            if (cols[j].firstChild && cols[j].firstChild.value) {
              row.push(cols[j].firstChild.value.replace(/,/g, ''));
            } else {
              row.push(cols[j].innerText.replace(/,/g, ''));
            }
          }
          
          csv.push(row.join(","));        
      }

      // Download CSV file
      this.downloadCSV(csv.join("\n"), filename);
    },

    //////////////////////////////////////////
    },

    // populate dropdowns on creation
    created: function() {
        this.populateSelects();
    }
});

// initial search
app.search();

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
});
