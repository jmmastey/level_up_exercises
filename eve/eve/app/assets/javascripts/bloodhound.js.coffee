window.Eve or= {}

Eve.Bloodhound =
	item_engine:
		datumTokenizer: (datum) ->
			
		remote: '/items/index?query=%QUERY'
