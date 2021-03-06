jQuery(function ($) {
  // Load Google visualization library if a chart element exists
  if ($('[data-chart]').length > 0) {
    $.getScript('https://www.google.com/jsapi', function (data, textStatus) {
      google.load('visualization', '1.0', { 'packages': ['corechart'], 'callback': function () {
        // Google visualization library loaded
        $('[data-chart]').each(function () {
          var div = $(this)
          // Fetch chart data
          $.getJSON(div.data('chart'), function (data) {
            // Create DataTable from received chart data
            var table = new google.visualization.DataTable();
            $.each(data.cols, function () { table.addColumn.apply(table, this); });
            table.addRows(data.rows);
            // Draw the chart
            var chart = new google.visualization.ChartWrapper();
            chart.setChartType(data.type);
            chart.setDataTable(table);
            chart.setOptions(data.options);
            chart.setOption('width', div.width());
            chart.setOption('height', div.height());
            chart.draw(div.get(0));

            var faye = new Faye.Client('http://localhost:9292/faye');
            faye.subscribe('/charts/new_answer',function(data){
              if (data=="updated") {
                $.getJSON(div.data('chart'),function(data){
                  var table = new google.visualization.DataTable();
                  $.each(data.cols, function () { table.addColumn.apply(table, this); });
                  table.addRows(data.rows);
                  chart.setDataTable(table);
                  chart.draw(div.get(0));
                });
              }
            });
          });
        });
      }});
    });
  }
});
