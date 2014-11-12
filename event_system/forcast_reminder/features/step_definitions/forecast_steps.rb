Given(/^current weather exists for station id "(.+)"$/) do |station_id|
  @current_conditions ||= {}
  @current_conditions[station_id] = FactoryGirl.create(:current_weather,
                                                     station_id: station_id) 
end

Then(/^I should see the current weather conditions for station id "(.+)"$/) do |station_id|
  condition = @current_conditions[station_id]
  within("#current_conditions") do
    expect(page).to have_content("Current Conditions")
    expect(page).to have_content("#{condition.temperature}°F")
    expect(page).to have_content("#{condition.condition}")
    expect(page).to have_content("#{condition.station_id}")
    expect(page).to have_content("#{condition.location_name}")
    expect(page).to have_content("#{condition.observation_time}")
    expect(page).to have_content("#{condition.wind}")
    expect(page).to have_content("#{condition.pressure} in")
    expect(page).to have_content("#{condition.dew_point}°F")
    expect(page).to have_content("#{condition.wind_chill}°F")
    expect(page).to have_content("#{condition.visibility} mi")
    expect(page).to have_content("#{condition.humidity}%")
    expect(page).to have_content("#{condition.icon_url}")
    expect(page).to have_content("#{condition.history_url}")
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
    expect(page).to have_content "Extended Forecast"
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
  @hourly_forecast[zip_code] = 8.times.map do |i|
    FactoryGirl.create(:hourly_forecast,
                       zip_code: zip_code.to_i,
                       time: Time.zone.now + i.hours * 3)
  end
end

Then(/^I should see hourly forecast data for zip code (\d+)$/) do |zip_code|
  within("#hourly_forecast") do
    expect(page).to have_content "Next 24 Hours"
    @hourly_forecast[zip_code].each_with_index do |hourly, index|
      within("#hourly_forecast-#{index}") do
        expect(page).to have_content(hourly.time.to_s(:time))
        expect(page).to have_content(hourly.temperature)
        expect(page).to have_content(hourly.dew_point)
        expect(page).to have_content(hourly.wind_speed)
        expect(page).to have_content(Geocoder::Calculations.compass_point(hourly.wind_direction))
        expect(page).to have_content(hourly.cloud_cover)
        expect(page).to have_content(hourly.hazard)
      end
    end
  end
end
