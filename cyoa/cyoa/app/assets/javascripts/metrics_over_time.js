$(function () {
  var artistMetrics = [];

  createChart = function () {

     $('#metrics-over-time').highcharts('StockChart', {
        rangeSelector: {
          inputEnabled: true
        },
        legend: {
          enabled: true
        },
        title: {
          text: 'Metrics Over Time'
        },
        series: artistMetrics
     });
  };

  $.getJSON(window.location.href + '.json', function (data) {

    services = Object.keys(data);

    $.each(services, function(i, service) {
      artistMetrics.push({
        name: service,
        data: data[service]
      });

      createChart();
    });
  });
});
