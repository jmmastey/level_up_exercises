require 'rails_helper'

describe "forecast/index.html.erb", type: :view do
  context "No data available" do
    it "displays no weather available message" do
      render

      expect(rendered).to have_content("No current weather information available")
      expect(rendered).to have_content("No hourly forecast information available")
      expect(rendered).to have_content("No forecast weather information available")
    end
  end

  context "Data available" do
    it "displays current weather" do
      condition = create(:current_weather)
      assign(:conditions, condition)

      render

      expect(rendered).to have_content("Current Conditions")
      expect(rendered).to have_content("#{condition.temperature}°F")
      expect(rendered).to have_content("#{condition.condition}")
      expect(rendered).to have_content("#{condition.station_id}")
      expect(rendered).to have_content("#{condition.location_name}")
      expect(rendered).to have_content("#{condition.observation_time}")
      expect(rendered).to have_content("#{condition.wind}")
      expect(rendered).to have_content("#{condition.pressure} in")
      expect(rendered).to have_content("#{condition.dew_point}°F")
      expect(rendered).to have_content("#{condition.wind_chill}°F")
      expect(rendered).to have_content("#{condition.visibility} mi")
      expect(rendered).to have_content("#{condition.humidity}%")
      expect(rendered).to have_content("#{condition.icon_url}")
      expect(rendered).to have_content("#{condition.history_url}")
    end

    it "displays hourly forecast data" do
      forecasts = 8.times.map do |i|
        FactoryGirl.create(:hourly_forecast, zip_code: 60606,
                           time: Time.zone.now + i.hours * 3)
      end
      assign(:hourly_forecast, forecasts)

      render

      expect(rendered).to have_content "Next 24 Hours"
      forecasts.each_with_index do |hourly, index|
        within("#hourly_forecast-#{index}") do
          expect(rendered).to have_content(hourly.time.to_s(:time))
          expect(rendered).to have_content(hourly.temperature)
          expect(rendered).to have_content(hourly.dew_point)
          expect(rendered).to have_content(hourly.wind_speed)
          expect(rendered).to have_content(Geocoder::Calculations.compass_point(hourly.wind_direction))
          expect(rendered).to have_content(hourly.cloud_cover)
          expect(rendered).to have_content(hourly.hazard)
        end
      end

    end

    it "displays weekly forecasts" do
      forecasts = 14.times.map do |i|
        FactoryGirl.create(:forecast, zip_code: 60606,
                           time: Time.now.beginning_of_hour + i * 0.5)
      end
      assign(:forecasts, forecasts)

      render
      expect(rendered).to have_content "Extended Forecast"
      forecasts.each_with_index do |forecast, index|
        within("#extended_forecast-#{index}") do
          expect(rendered).to have_content(forecast.date_description)
          expect(rendered).to have_content(forecast.temperature)
          expect(rendered).to have_content(forecast.precipitation)
          expect(rendered).to have_content(forecast.condition)
        end
      end
    end
  end
end
