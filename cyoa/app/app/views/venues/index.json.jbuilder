json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :city, :address, :url
  json.url venue_url(venue, format: :json)
end
