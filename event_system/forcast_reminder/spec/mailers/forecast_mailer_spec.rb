require "rails_helper"

describe ForecastMailer, type: :mailer do
  describe "#update_email" do
    let(:user) { create(:user) }
    subject { ForecastMailer.update_email(user).deliver_now }

    it "is expected to send an email" do
      subject
      expect(ActionMailer::Base.deliveries).to_not be_empty
    end

    its(:body) { is_expected.to match "Hi #{user.email}, Here is Today's Forecast" }

    context "No forecast data available" do
      its(:body) do
        is_expected.to include "Current weather is not available for your location today"
        is_expected.to include "Forecast Not Available"
      end
    end

    context "Today's forecast data is available" do
      let!(:current_weather) { create(:current_weather) }

      its(:body) do
        is_expected.to include "Current Conditions"
        is_expected.to include "#{current_weather.location_name}"
        is_expected.to include "#{current_weather.condition}"
        is_expected.to include "#{current_weather.temperature}"
        is_expected.to include "#{current_weather.temperature}"
        is_expected.to include "wind chill #{current_weather.wind_chill}°F"
        is_expected.to include "#{current_weather.wind}"
        is_expected.to include "#{current_weather.pressure} in"
        is_expected.to include "#{current_weather.pressure} in"
      end
    end

    context "Hourly forecast data is available" do
      let!(:hourly_forecasts) do
        (1..8).map do |index|
          create(:hourly_forecast, zip_code: user.zip_code,
                 time: Time.now.beginning_of_hour + (3 * index).hours)
        end
      end

      its(:body) do
        is_expected.to include "Next 24 Hours"
        hourly_forecasts.each_with_index do |forecast, index|
          within("#hourly_forecast_#{index}") do
            is_expected.to include "#{forecast.time.strftime('%l%p')}"
            is_expected.to include "#{forecast.temperature}°F"
            is_expected.to include "#{forecast.wind_speed}mph (#{Geocoder::Calculations.compass_point(forecast.wind_direction)})"
            is_expected.to include "#{forecast.precipitation}% chance rain"
          end
        end
      end
    end

    context "Outdated hourly forecast data is not available" do
      let!(:hourly_forecasts) do
        8.times.map do |index|
          create(:hourly_forecast, zip_code: user.zip_code,
                 time: 2.days.ago.beginning_of_hour + (3 * index).hours)
        end
      end

      its(:body) { is_expected.to include "Forecast Not Available" }
    end

    context "Hourly precipitation not available" do
      let!(:hourly_forecasts) do
        create(:hourly_forecast, zip_code: user.zip_code, precipitation: nil)
      end

      its(:body) { is_expected.to_not include "% chance rain" }
    end
  end
end
