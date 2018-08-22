"use strict";

// test url: http://apps.cityoflewisville.com/beta/liftstationreport/beta/?&record=DF16016348694FE192EFB18B21943C1A
// test url: http://apps.cityoflewisville.com/beta/liftstationreport/beta/?record=29216A641DB84F49A3DB6586BD783A76

$(document).ready(function() {

    // print button
    $("#fab").click(function(event) {
        event.preventDefault();
        window.print();
    });

    // scroll-to-top button
    $("#fab2").hide();
    $("#fab2").click(function(event) {
        $('html, body').animate({
            scrollTop: 0
        }, 500);
    });

    // show/hide scroll-to-top button
    var fab = document.getElementById("fab2");
    $(window).scroll(function() {
        if ($(this).scrollTop()) {
            $('#fab2:hidden').stop(true, true).fadeIn("fast");
        } else {
            $('#fab2').stop(true, true).fadeOut("fast");
        }
    });

    // scroll to anchor
    $(".link-td").click(function(event) {
        event.preventDefault();
        $('html, body').animate({
            scrollTop: $($.attr(this, 'href')).offset().top
        }, 500);
    });
});

// from stack overflow: http://stackoverflow.com/questions/19491336/get-url-parameter-jquery-or-how-to-get-query-string-values-in-js
function getUrlParameter(sParam) {
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
};

// 24 to 12 hr converter
function timeFormatter(time) {

    if (time == undefined || time == "") return "--";

    if (time.length < 5) return "--";

    // split time apart
    var hour = time.substr(0, 2);
    var min = time.substr(3, 2);
    var morn = time.substr(0, 2) >= 12 ? " PM" : " AM";
    if (hour === '00') hour = '12';
    // reconstruct
    return hour  + ":" + min + morn;
};

var card = new Vue({
    el: "#card",
    data: {
        "date": "--",
        "shift": "--",
        lp: {},
        fp: {},
        nm: {},
        sp: {},
        hl: {},
        sa: {},
        vf: {},
        co: {},
        lp2: {},
        mp: {},
        rr: {},
        hc: {},
        al: {},
        ch: {},
        esss: {},
        pf: {},
        ww: {},
        vr: {},
        ntc: {}
    }
});

// get date and shift from
var record = getUrlParameter("record");

// error, holder, loader divs
var loaderdiv = document.getElementById("loader");
var carddiv = document.getElementById("card");
var errordiv = document.getElementById("error");

// check if date and shift were retrieved
if (record == undefined) {

    // show error message
    alert("BAD URL PARAMETER(S)");
    loaderdiv.classList.add("inactive");
    loaderdiv.classList.remove("active");
    carddiv.classList.add("inactive");
    carddiv.classList.remove("active");

} else {

    // hit web service
    $.post('https://query.cityoflewisville.com/v2/', {
        auth_token: localStorage.colAuthToken,
        webservice: 'PublicServices/Wastewater/LiftStationReport',
        Record: record
    }, function(data) {

        // hide loading icon
        loaderdiv.classList.add("inactive");
        loaderdiv.classList.remove("active");
        carddiv.classList.add("active");
        carddiv.classList.remove("inactive");

        // log record for testing
        console.dir(data);

        // replace null or empty string with --
        function replaceNull(obj) {

            // loop through object properties
            Object.keys(obj).forEach(function(key, index) {
                if (obj[key] == null) obj[key] = "--";
                else if (obj[key] == "") obj[key] = "--";
                else if (obj[key].length == 0) obj[key] = "--";
            });
            return obj;
        }

        // date, shift
        card.date = data['LakePark'][0]['DateRpt'];
        card.shift = data['LakePark'][0]['WorkShift'];

        // in order list of station acronyms
        var lifts = ['lp', 'fp', 'nm', 'sp', 'hl', 'sa', 'vf', 'co', 'lp2', 'mp', 'rr', 'hc', 'al', 'ch', 'esss', 'ww', 'vr', 'ntc', 'pf'];

        // loop through properties
        Object.keys(data).forEach(function(key, i) {
            if (data[key][0] != undefined) {

                // format times
                Object.keys(data[key][0]).forEach(function(key2, i2) {
                    if (key2.toLowerCase().includes("time")) {
                      //console.log(data[key][0][key2])
                      //console.log(timeFormatter(replaceNull(data[key][0][key2])))
                        data[key][0][key2] = timeFormatter(replaceNull(data[key][0][key2]));
                    }
                });
                //console.log(lifts[i] + ', ' + JSON.stringify(data[key]));
                card[lifts[i]] = replaceNull(data[key][0]);
            }
        });
    });
}
