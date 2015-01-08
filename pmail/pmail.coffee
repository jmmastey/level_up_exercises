# pmail.js
# Dan Kotowski

init_dropdown = ->
  $('.dropdown-toggle').click (e) ->
    button = $(e.currentTarget)
    button.toggleClass('active')
    $(button.attr('data-target')).toggleClass('hidden')

init_message_list = ->
  $('input[name="selected_message"]').change (e) ->
    checkbox = $(e.currentTarget)
    if checkbox.prop('checked')
      checkbox.parents('.message').addClass('active')
    else
      checkbox.parents('.message').removeClass('active')

init_search_box = ->
  search_box = $('.search-box')
  search_input = $('.search-box input[type="search"]')
  search_input.focus ->
    search_box.addClass('focus')
  search_input.blur ->
    search_box.removeClass('focus')

init_sidebar = ->
  $('.sidebar-links li a').click (e) ->
    link = $(e.currentTarget)
    unless link.attr("data-target")
      $('.sidebar-links li').removeClass('active')
      $(e.currentTarget.parentNode).addClass('active')

resize_main_pane = ->
  $('.main-pane').css('width', $(window).width() - $('.sidebar').outerWidth())

$ ->
  init_dropdown()
  init_message_list()
  init_search_box()
  init_sidebar()
  resize_main_pane()
  $(window).resize(resize_main_pane)
