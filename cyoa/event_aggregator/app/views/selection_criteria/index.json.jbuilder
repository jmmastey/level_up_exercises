json.array!(@selection_criteria) do |selection_criterium|
  json.extract! selection_criterium, :id, :implementation_class, :configuration, :sql_expression
  json.url selection_criterium_url(selection_criterium, format: :json)
end
