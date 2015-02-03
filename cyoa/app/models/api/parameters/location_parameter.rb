class LocationParameter
  attr_reader :location_key, :latitude, :longitude

  def initialize(location)
    @location_key = location[:location_key]
    @latitude = location[:point][:@latitude]
    @longitude = location[:point][:@longitude]
  end
end