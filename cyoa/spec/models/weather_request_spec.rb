require 'savon'
require './app/models/weather_request'

describe WeatherRequest do
  describe "for one lat lon point", vcr: { cassette_name: "one lat lon point",
                                           record: :new_episodes } do
    let(:request) { WeatherRequest.new({ list_lat_lon: "41.837,-87.685",
                                          start_time:   "2015-01-30",
                                          end_time:     "2015-02-08" }) }
    it "has a response" do
      # puts request.response.temperatures.each { |key, value| puts "\n\n#{key}" }
      # puts request.response_data.each { |key, value| puts "\n\n#{key} => #{value}" }
      #expect(request.response_parameters).to have_key(:mint)
      # puts request.response.data.each
      puts request.response.weather_conditions
    end
  end
end
