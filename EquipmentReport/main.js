
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
    start: '2018-05-01',
    end: '2018-05-02',
    col: 'ccp1',
    data: [],
  },
  created: function() {
    this.loading = true;
    this.record = $.QueryString["Record"];
    this.fetchData();
  },
  methods: {
    fetchData: function() {
      var self = this;

      $.post('https://query.cityoflewisville.com/v2/', {
          webservice : 'PublicServices/WasteWater/EquipmentReport',
          start: '2018-05-01',
          end: '2018-05-02',
          col: 'ccp'

      }, function(data) {
        self.loading = false;
        self.data = data;
        console.log(self.data);
      });
    },
  }
})