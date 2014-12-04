window.Eve or= {}

Eve.Watches =
	init: ->
		this.init_item_select()
		this.init_region_select()

	init_item_select: ->
		$('input#watch_item_id').select2
			minimumInputLength: 3
			ajax:
				url: "/items/search.json"
				dataType: "json"
				data: (term, page) -> {
					query: term
					page: page
				}
				results: (data, page) -> {
					results: data
				}
			initSelection: (element, callback) ->
				id = $(element).val()
				if (id != "")
					$.ajax("/items/#{id}.json", { dataType: "json" }).done((data) -> callback(data))
			formatResult: Eve.Watches.format_item
			formatSelection: Eve.Watches.format_item
			placeholder: "Search for an item"

	init_region_select: ->
		$('input#watch_region_id').select2
			minimumInputLength: 3
			ajax:
				url: "/regions/search.json"
				dataType: "json"
				data: (term, page) -> {
					query: term
					page: page
				}
				results: (data, page) -> {
					results: data
				}
			initSelection: (element, callback) ->
				id = $(element).val()
				if (id != "")
					$.ajax("/regions/#{id}.json", { dataType: "json" }).done((data) -> callback(data))
			formatResult: Eve.Watches.format_region
			formatSelection: Eve.Watches.format_region
			placeholder: "Search for a region"

	format_item: (item) -> item.name
	format_region: (region) -> region.name

$ -> Eve.Watches.init()
