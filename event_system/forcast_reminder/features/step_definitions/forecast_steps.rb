Given(/^current weather exists for zip code (\d+)$/) do |zip_code|
  @current_conditions ||= {}
  @current_conditions[zip_code] = FactoryGirl.create(:current_weather,
                                                     zip_code: zip_code.to_i)
end

Then(/^I should see the current weather conditions for zip code (\d+)$/) do |zip_code|
  within("#current_conditions") do
    expect(page).to have_content "Current Temperature: #{@current_conditions[zip_code].temperature}"
    expect(page).to have_content "Current Condition: #{@current_conditions[zip_code].conditions}"
  end
end

Given(/^forecast weather data exists for zip code (\d+)$/) do |zip_code|
  @forecasts ||= {}
  @forecasts[zip_code] = 14.times.map do |i| 
    FactoryGirl.create(:forecast,
                       zip_code: zip_code.to_i,
                       date: DateTime.now + i * 0.5 + 1)
  end
end

Then(/^I should see the forecast data for zip code (\d+)$/) do |zip_code|
  within("#extended_forecast") do
    @forecasts[zip_code].each_with_index do |forecast, index|
      within("#extended_forecast-#{index}") do
        expect(page).to have_content(forecast.date_description)
        expect(page).to have_content(forecast.temperature)
        expect(page).to have_content(forecast.precipitation)
        expect(page).to have_content(forecast.condition)
      end
    end
  end
end

Given(/^hourly forecast weather data exists for zip code (\d+)$/) do |zip_code|
  @hourly_forecast ||= {}
  @hourly_forecast[zip_code] = 24.times.map do |i|
    FactoryGirl.create(:hourly_forecast,
                       zip_code: zip_code.to_i,
                       time: Time.zone.now + i * 3600)
  end
end

Then(/^I should see hourly forecast data for zip code (\d+)$/) do |zip_code|
  within("#hourly_forecast") do
    expect(page).to have_content "Hourly Forecast"
    @hourly_forecast[zip_code].each_with_index do |hourly, index|
      within("#hourly_forecast-#{index}") do
        expect(page).to have_content(hourly.time.to_s(:time))
        expect(page).to have_content(hourly.temperature)
        expect(page).to have_content(hourly.dew_point)
        expect(page).to have_content(hourly.wind_speed)
        expect(page).to have_content(hourly.wind_direction)
        expect(page).to have_content(hourly.cloud_cover)
        expect(page).to have_content(hourly.hazard)
      end
    end
  end
end
