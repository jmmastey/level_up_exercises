$ ->
  $('.keys-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')
    $('.keys').addClass('chart-active')

  $('.clicks-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')
    $('.clicks').addClass('chart-active')

  $('.download-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')
    $('.download').addClass('chart-active')

  $('.upload-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')
    $('.upload').addClass('chart-active')

  $('.uptime-button').click ->
    $('.disabled').removeClass('disabled')
    $('.chart-active').removeClass('chart-active')
    $(this).addClass('disabled')
    $('.uptime').addClass('chart-active')
