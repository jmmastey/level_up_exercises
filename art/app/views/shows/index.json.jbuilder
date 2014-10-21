json.array!(@shows) do |show|
  json.extract! show, :id, :name, :description
  json.url show_url(show, format: :json)
end
