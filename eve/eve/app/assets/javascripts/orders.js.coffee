window.Eve or= {}

Eve.Orders =
	init: ->
		this.init_select()

	init_select: ->
		Eve.SelectBoxes.create_item_select 'input#item'
		Eve.SelectBoxes.create_region_select 'input#region'
		Eve.SelectBoxes.create_station_select 'input#station'

$ -> Eve.Orders.init()
