window.Eve or= {}

Eve.Watches =
	init: ->
		this.init_item_select()

	init_item_select: ->
		$('#watch_item_id').select2
			minimumInputLength: 3
			ajax:
				url: "/items/index.json"
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
	
	format_item: (item) -> item.name

$ -> Eve.Watches.init()
