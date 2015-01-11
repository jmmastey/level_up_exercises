# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
current_page_num = 1

$ ->
  $('#start_date_picker, #end_date_picker').datetimepicker({ pickTime: false })
  $('.pagination > li:nth-child(2)').children('a').addClass('active_page')
  $(".pagination > li:first > a").prop("href","")
  if $(".pagination > li.page").length > 0
    $(".pagination > li:last > a").prop("href","/events/page/2")
  else
    $(".pagination > li:last > a").prop("href","")

  $(".pagination").on "click", ".page", (event) ->
    console.log('Test')
    total_pages = $(this).parent().children('li.page') 
    desire_page_num = parseInt($(this).text())
    if desire_page_num != current_page_num
      update_pages_status(desire_page_num, total_pages)
      current_page_num = desire_page_num
      update_pagination_url(desire_page_num, total_pages.length)

  $(".pagination > li:first, .pagination > li:last").on "click", (event) ->
    pathname = $(this).children("a").prop('pathname')
    return if pathname == "/"
    desire_page_num = parseInt(pathname.split("/")[3])
    total_pages = $(this).parent().children('li.page')
    #$(total_pages[current_page_num - 1]).children('a').removeClass('active_page')
    #$(total_pages[desire_page_num - 1]).children('a').addClass('active_page')
    update_pages_status(desire_page_num, total_pages)
    current_page_num = desire_page_num
    update_pagination_url(desire_page_num, total_pages.length)
    
update_pagination_url = (page_num, total_pages_count) ->
  num = if (page_num != 1) then "/events/page/" + (page_num - 1) else ""
  $(".pagination > li:first > a").prop("href", num)
  num = if (page_num < total_pages_count) then "/events/page/" + (page_num + 1) else ""
  $(".pagination > li:last > a").prop("href",num)

update_pages_status = (desire_page_num, total_pages) ->
  $(total_pages[current_page_num - 1]).children('a').removeClass('active_page')
  $(total_pages[desire_page_num - 1]).children('a').addClass('active_page')
    
