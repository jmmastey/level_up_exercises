json.array!(@selection_criteria) do |selection_criteria|
  json.extract! selection_criteria, :id, :implementation_class, :configuration, :sql_expression
  json.url feed_selection_criteria_url(@feed, selection_criteria, format: :json)
end
