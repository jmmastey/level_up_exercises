require 'rails_helper'

describe "forecast/index.html.erb", type: :view do
  context "No data available" do
    it "displays no weather available message" do
      render

      expect(rendered).to have_content("No current weather")
      expect(rendered).to have_content("No hourly forecast")
      expect(rendered).to have_content("No forecast weather")
    end
  end

  context "Current data available" do
    let(:condition) { create(:current_weather) }
    let(:hourly_forecasts) do
      8.times.map do |i|
        FactoryGirl.create(:hourly_forecast, zip_code: 60606,
                           time: Time.zone.now + i.hours * 3)
      end
    end
    let(:forecasts) do
      14.times.map do |i|
        create(:forecast, zip_code: 60606,
               time: Time.now.beginning_of_hour + i * 0.5)
      end
    end

    before do
      assign(:conditions, condition)
      assign(:hourly_forecast, hourly_forecasts)
      assign(:forecasts, forecasts)

      render
    end

    it "displays current weather" do
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
      expect(rendered).to have_content "Next 24 Hours"
      hourly_forecasts.each_with_index do |hourly, index|
        within("#hourly_forecast-#{index}") do
          expect(rendered).to have_content(hourly.time.to_s(:time))
          expect(rendered).to have_content(hourly.temperature)
          expect(rendered).to have_content(hourly.dew_point)
          expect(rendered).to have_content(hourly.wind_speed)
          expect(rendered).to have_content(hourly.wind_direction_string)
          expect(rendered).to have_content(hourly.cloud_cover)
          expect(rendered).to have_content(hourly.hazard)
        end
      end

    end

    it "displays weekly forecasts" do
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
