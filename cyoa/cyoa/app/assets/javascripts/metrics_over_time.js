$(function () {
    var artistMetrics = [],
        seriesCounter = 0,
        // create the chart when all data is loaded
    createChart = function () {

        $('#metrics-over-time').highcharts('StockChart', {

            rangeSelector: {
                selected: 4
            },

            yAxis: {
                labels: {
                    formatter: function () {
                        return (this.value > 0 ? ' + ' : '') + this.value + '%';
                    }
                },
                plotLines: [{
                    value: 0,
                    width: 2,
                    color: 'silver'
                }]
            },

            plotOptions: {
                series: {
                    compare: 'percent'
                }
            },

            tooltip: {
                pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.change}%)<br/>',
                valueDecimals: 2
            },

            series: artistMetrics
        });
    };


    $.getJSON('http://localhost:3000/artists/beyonce.json', function (data) {

        artistMetrics.push({
            name: data["name"],
            data: data["twitter"]
        });

        createChart();
    });
});