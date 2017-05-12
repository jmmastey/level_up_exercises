json.array!(@venues) do |venue|
  json.extract! venue, :id, :name, :address, :city, :zipcode, :description, :phone_number, :venue_url
  json.url venue_url(venue, format: :json)
end
