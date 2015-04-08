$ ->
  $('.chart-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')

    chartCss = '.'+$(this).attr('chart_for')
    $(chartCss).addClass('chart-active')
