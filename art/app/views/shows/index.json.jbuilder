json.array!(@shows) do |show|
  json.extract! show, :id, :name, :description, :num_reviews
  json.url show_url(show, format: :json)
end
