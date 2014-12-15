window.Eve or= {}

Eve.SelectBoxes =
	create_item_select: (selector) ->
		$(selector).select2
			minimumInputLength: 3
			ajax:
				url: "/items/search.json"
				dataType: "json"
				quietMillis: 1000,
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
			formatResult: Eve.SelectBoxes.format_item
			formatSelection: Eve.SelectBoxes.format_item
			placeholder: "Search for an item"
	create_region_select: (selector) ->
		$(selector).select2
			minimumInputLength: 3
			ajax:
				url: "/regions/search.json"
				dataType: "json"
				quietMillis: 1000,
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
			formatResult: Eve.SelectBoxes.format_region
			formatSelection: Eve.SelectBoxes.format_region
			placeholder: "Search for a region"
	create_station_select: (selector) ->
		$(selector).select2
			minimumInputLength: 3
			ajax:
				url: "/stations/search.json"
				dataType: "json"
				data: (term, page) -> {
					query: term
					page: page
				}
				quietMillis: 1000,
				results: (data, page) -> {
					results: data
				}
			initSelection: (element, callback) ->
				id = $(element).val()
				if (id != "")
					$.ajax("/stations/#{id}.json", { dataType: "json" }).done((data) -> callback(data))
			formatResult: Eve.SelectBoxes.format_station
			formatSelection: Eve.SelectBoxes.format_station
			placeholder: "Search for a station"

	format_item: (item) -> item.name
	format_region: (region) -> region.name
	format_station: (station) -> station.name
