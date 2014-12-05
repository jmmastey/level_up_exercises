window.Eve or= {}

Eve.Watches =
	init: ->
		this.init_select()

	init_select: ->
		Eve.SelectBoxes.create_item_select('input#watch_item_id')
		Eve.SelectBoxes.create_region_select('input#watch_region_id')
		Eve.SelectBoxes.create_station_select('input#watch_station_id')

$ -> Eve.Watches.init()
