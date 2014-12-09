window.Eve or= {}

Eve.Watches =
	init: ->
		this.init_select()
		this.init_tabs()

	init_select: ->
		Eve.SelectBoxes.create_item_select 'input#watch_item_id'
		Eve.SelectBoxes.create_region_select 'input#watch_region_id'
		Eve.SelectBoxes.create_station_select 'input#watch_station_id'

	init_tabs: ->
		$('.nav-tabs a').on "show.bs.tab", (e) ->
			field = $(e.relatedTarget).attr('data-field')
			$("##{field}").select2("val", "") unless field == undefined

$ -> Eve.Watches.init()
