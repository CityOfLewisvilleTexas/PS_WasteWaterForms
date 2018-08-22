// URL Parameter decoder
(function($) {
    $.QueryString = (function(a) {
        if (a == "") return {};
        var b = {};
        for (var i = 0; i < a.length; ++i)
        {
            var p=a[i].split('=', 2);
            if (p.length != 2) continue;
            b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
        }
        return b;
    })(window.location.search.substr(1).split('&'))
})(jQuery);

var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

var app = new Vue({
  el: '#app',
  data: {
    loading: false, // for loading spinners
    record: '',
    month: '',
    year: '',
    data: [],
    avg: [],
    total: [],
  },
  created: function() {
    this.loading = true;
    this.record = $.QueryString["record"];
    this.fetchData();
  },
  methods: {
    fetchData: function() {
      var self = this;
      // New v2 request format, don't use citydata anymore
      $.post('https://query.cityoflewisville.com/v2/', {
          webservice : 'PublicServices/Wastewater/LiftStation_Effluent',
          record: self.record

      }, function(data) {
        
        self.data = data[0];

        

        self.data.forEach((day) => {
          day.day = moment.utc(day.day);
          day.castlehills_flow = self.roundToDecimal(day.castlehills_flow, 2);
          day.hiddencove_pump1 = self.roundToDecimal(day.hiddencove_pump1, 2);
          day.hiddencove_pump2 = self.roundToDecimal(day.hiddencove_pump2, 2);
          day.hiddencove_total = self.roundToDecimal(day.hiddencove_total, 2);
          day.scottiespoint_flow = self.roundToDecimal(day.scottiespoint_flow, 2);
          day.vistaridge_pump1 = self.roundToDecimal(day.vistaridge_pump1, 2);
          day.vistaridge_pump2 = self.roundToDecimal(day.vistaridge_pump2, 2);
          day.vistaridge_pump3 = self.roundToDecimal(day.vistaridge_pump3, 2);
          day.vistaridge_total = self.roundToDecimal(day.vistaridge_total, 2);
          day.wip_flow = self.roundToDecimal(day.wip_flow, 2);
        });

        self.avg = self.data.pop();
        self.total = self.data.pop();

        self.month = self.data[0].day.get('month');
        self.year = self.data[0].day.get('year');

        console.log(self.data);
        self.loading = false;
      });
    },
    roundToDecimal: function(num, decimal) {
      return (num != null) ? num.toFixed(decimal) : null;
    },
    hiddenCoveTotal: function(index) {
      var pump1 = parseFloat(this.data[index].hiddencove_pump1) || 0.0;
      var pump2 = parseFloat(this.data[index].hiddencove_pump2) || 0.0;
      var total = pump1 + pump2;

      return (total === 0.0 || isNaN(total)) ? '' : total;
    },
    vistaRidgeTotal: function(index) {
      var pump1 = parseFloat(this.data[index].vistaridge_pump1) || 0.0;
      var pump2 = parseFloat(this.data[index].vistaridge_pump2) || 0.0;
      var pump3 = parseFloat(this.data[index].vistaridge_pump3) || 0.0;
      var total = pump1 + pump2 + pump3;

      return (total === 0.0 || isNaN(total)) ? '' : total;
    },
    operator: function(index) {
      var operator = this.data[index].operator;
      if (operator != null) {
        operator = operator.split('@')[0]
      }
      return (operator == null) ? '' : operator;
    }
  }
})
