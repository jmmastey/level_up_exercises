json.array!(@legislators) do |legislator|
  json.extract! legislator, :id
  json.url legislator_url(legislator, format: :json)
end
