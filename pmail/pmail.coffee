init_dropdown = ->
	$('.dropdown-toggle').click (e) ->
		button = $(e.currentTarget)
		button.toggleClass('active')
		$(button.attr('data-target')).toggleClass('hidden')

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
		if link.attr("data-target") == undefined
			$('.sidebar-links li').removeClass('active')
			$(e.currentTarget.parentNode).addClass('active')
	$(window).resize(resize_main_pane)

resize_main_pane = ->
	$('.main-pane').css('width', $(window).width() - $('.sidebar').outerWidth() - 20)

$ ->
	init_dropdown()
	init_search_box()
	init_sidebar()
	resize_main_pane()
