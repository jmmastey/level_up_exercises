require 'spec_helper'
require 'parse_weather'
describe ParseWeather do
  context "data is first time to be pulled" do

    before do
      WeatherForecast.destroy_all
    end

    it "saves the data to database" do
      Class.new.extend(ParseWeather).parse_temperatures
      expect(WeatherForecast.count).to eq(5)
    end
  end

  context "trying to pull data again on same day " do
     before do
      WeatherForecast.destroy_all

      [Date.today, Date.today + 1.days, Date.today + 2.days].each do |date|
        wf = WeatherForecast.new
        wf.weather_day = date
        wf.high        = "34"
        wf.low         = "21"
        wf.save!
      end
     end

     it "does not do the web call to pull data" do
      expect(subject).to_not receive(:fetch_document)
      Class.new.extend(ParseWeather).parse_temperatures
     end
  end
end
