window.Eve or= {}

Eve.Watches =
	init: ->
		init_item_typeahead()
	
	init_item_typeahead: ->
		$('#watch_item').typeahead
			name: 'items'
			displayKey: 'name'
			source: Eve.Bloodhound.item_engine.ttAdapter()

$ -> Eve.Watches.init
