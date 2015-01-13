# pmail.js
# Dan Kotowski

init_dropdown = ->
  $('.dropdown-toggle').click ->
    $(this).siblings('.dropdown-panel').toggle()

init_refresh = ->
  $('button#refresh').click ->
    window.location.reload()

init_message_list = ->
  $('input[name="selected_message"]').change ->
    if $(this).prop('checked')
      $(this).parents('.message').addClass('active')
    else
      $(this).parents('.message').removeClass('active')

init_search_box = ->
  search_box = $('.search-box')
  search_input = $('.search-box input[type="search"]')
  search_input.focus ->
    search_box.addClass('focus')
  search_input.blur ->
    search_box.removeClass('focus')

init_sidebar = ->
  $('.sidebar-links li a').click ->
    if $(this).hasClass("dropdown-toggle")
      $('.sidebar-links#more-links').toggle()
    else
      $('.sidebar-links li').removeClass('active')
      $(this.parentNode).addClass('active')

$ ->
  init_dropdown()
  init_message_list()
  init_refresh()
  init_search_box()
  init_sidebar()
