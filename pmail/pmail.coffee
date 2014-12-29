init_search_box = ->
	search_box = $('.search-box')
	search_input = $('.search-box input[type="search"]')
	search_input.focus ->
		search_box.addClass('focus')
	search_input.blur ->
		search_box.removeClass('focus')

init_search_dropdown = ->
	search_dropdown_button = $('.search-box .dropdown-toggle')
	dropdown_panel = $('.search-box .dropdown-panel')
	search_dropdown_button.click ->
		dropdown_panel.toggleClass('show')

init_sidebar = ->
	$('.sidebar-links li a').click (e) ->
		link = $(e.currentTarget)
		if link.attr("data-target") == undefined
			$('.sidebar-links li').removeClass('active')
			$(e.currentTarget.parentNode).addClass('active')

$ ->
	init_search_box()
	init_search_dropdown()
	init_sidebar()
