require 'savon'
require './app/models/weather_request.rb'

describe WeatherRequest do
  let(:client) { WeatherRequest.new }
  it "tells me the available operations" do
    puts client.operations
    
  end
end
