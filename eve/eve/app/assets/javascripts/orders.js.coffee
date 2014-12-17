window.Eve or= {}

Eve.Orders =
	init: ->
		this.init_select()
		this.init_form_freeze()

	init_form_freeze: ->
		$("form").submit(Eve.Orders.form_freeze)

	init_select: ->
		Eve.SelectBoxes.create_item_select 'input#item'
		Eve.SelectBoxes.create_region_select 'input#region'
		Eve.SelectBoxes.create_station_select 'input#station'

	form_freeze: (event) ->
		$("form").find("input").attr("readonly", true)
		$("form").find("button[type='submit']").text("Searching...").attr("disabled", "disabled")

$ -> Eve.Orders.init()
