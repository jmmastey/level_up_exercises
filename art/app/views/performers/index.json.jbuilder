json.array!(@performers) do |performer|
  json.extract! performer, :id, :name, :description
  json.url performer_url(performer, format: :json)
end
