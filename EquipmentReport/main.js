var app = new Vue({
  el: '#app',
  data: {
    loading: false, // for loading spinners
    drawer: null,
    start_date: null,
    end_date: null,
    start: null,
    end: null,
    col: null,
    columns: [],
    column_types: [],
    all_columns: [],
    data: [],
    headers: [],
    header_response: [],
    rows: [],
    dropdown: [
      // Add new equipment entries here.
      { title: 'PC Pumps', value: 'pcpumps' },
      { title: 'Fine Screens', value: 'finescreens' },
      { title: 'BTF Control Panel', value: 'btf' },
      { title: 'Compactor Control Panel 1', value: 'ccp1' },
      { title: 'Compactor Control Panel 2', value: 'ccp2' },
      { title: 'North Grit Unit', value: 'north_grit' },
      { title: 'South Grit Unit', value: 'south_grit' },
      { title: 'P1 Blowers', value: 'p1blowers' },
      { title: 'P2 Blowers', value: 'p2blowers' },
      { title: 'P3 Blowers', value: 'p3blowers' },
      { title: 'P1 Return', value: 'p1return' },
      { title: 'P2 Return', value: 'p2return' },
      { title: 'P3 Return', value: 'p3return' },
      { title: 'Recirculation Pumps', value: 'recircpumps' },
      { title: 'Plant Water', value: 'plantwater' },
      { title: 'Filter Pumps', value: 'filterpumps' },
      { title: 'Digester Blowers', value: 'digesterblowers' },
      { title: 'Press Pumps', value: 'presspumps' },
      { title: 'Head of Plant', value: 'headofplant' },
      { title: 'Sand Filters', value: 'sandfilters' },
      { title: 'CL2 Actuator Control Box', value: 'cl2' },
      { title: 'Chlorinators', value: 'chlor' },
      { title: 'Sulfonators', value: 'sulf' },
    ],
    menu1: false,
    menu2: false,
  },
  created: function() {
    this.loading = true;
    this.fetchData();
  },
  computed: {
    // For datepickers
    computedDateStartFormatted () {
      return this.formatDate(this.start)
    },
    computedDateEndFormatted () {
      return this.formatDate(this.end)
    }
  },
  methods: {
    fetchData: function() {
      var self = this;

      axios.post('https://query.cityoflewisville.com/v2/', {
          webservice : 'PublicServices/WasteWater/EquipmentReport',
          start: self.start,
          end: self.end,
          column: self.col

      }).then(function(response) {
        // reset
        self.column_types = [];
        self.columns = [];
        self.data = [];
        self.header_response = [];
        self.headers = [];
        self.all_columns = [];
        self.rows = [];
        self.loading = false;

        // Format responses i.e. response.data[0] is the table schema sort of (I called it headers), and response.data[1] is the actual data
        self.data = response.data[1];
        self.all_columns = Object.keys(self.data[1])
        self.rows = self.data;
        self.column_types = response.data[0].map(function(row) { return {[row.FieldID.toLowerCase()]: row.FieldType.toLowerCase()} })
        self.columns = response.data[0].map(function(row) { return row.FieldID.toLowerCase() })
        self.header_response = response.data[0]
        self.formatHeaders(response.data[0]);
      });
    },
    formatHeaders (rows) {
      var self = this;

      // Some of the column names don't match up very well, so if no headers we just use the key names from the dataset
      if (rows.length < 1) {
         // Set the date in a pretty way
        self.rows.forEach(function(row, index) {
          self.rows[index].date = moment(row.date).format('dddd, MMMM Do YYYY');
        });

        Object.keys(self.rows[0]).forEach(function(row, index) {
          if (row != 'psofia_recordid') {
            // Headers are the datatable are for <thead> tags
            self.headers.push({ text: row, value: row });
            // columns are the datatable are body tr td tags since we are dynamically building tables
            self.columns.push(row);
          }
        });
      } else {
        // Headers are the datatable are for <thead> tags
        self.headers.push({ text: 'Date', value: 'date' });
        self.headers.push({ text: 'Time', value: 'time' });
        self.headers.push({ text: 'Shift', value: 'shift' });

        // columns are the datatable are body tr td tags since we are dynamically building tables
        self.columns.unshift('shift');
        self.columns.unshift('time');
        self.columns.unshift('date');

        self.rows.forEach(function(row, index) {
          // Set the date in a pretty way
          self.rows[index].date = moment(row.date).format('dddd, MMMM Do YYYY');

          // Format the cells to be checkboxes if they are boolean
          self.column_types.forEach(function(col) {
            var key = Object.keys(col)[0]; // only 1 key
            self.rows[index][key] = { type: col[key], value: col[key] === 'checkbox' ? (row[key] == 'true') : row[key] }
          })
        });

        // add rest of headers
        rows.forEach(function(row, index) {
          self.headers.push({ text: row.FieldName, value: row.FieldID });
        });
      }
    },
    // For datepickers
    formatDate (date) {
      if (!date) return null

      const [year, month, day] = date.split('-')
      console.log(`${month}/${day}/${year}`)
      return `${month}/${day}/${year}`
    },
    parseDate (date) {
      if (!date) return null

      const [month, day, year] = date.split('/')
      return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`
    }
  }
})