Given(/^I am not logged in$/) do
  visit('/users/sign_out') # ensure that at least
end

Given(/^I am a new authenticated user in zip code (\d+) near station "(.*?)"$/) do |zip_code, station_id|
  email = 'testing@enova.com'
  password = 'secretpass'

  visit '/users/sign_up'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  fill_in "user_zip_code", with: zip_code
  fill_in "user_station_id", with: station_id
  click_button "Sign up"
  visit '/users/sign_out'

  visit '/users/sign_in'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end

Given(/^current weather exists for station id "(.+)"$/) do |station_id|
  @current_conditions ||= {}
  @current_conditions[station_id] = FactoryGirl.create(:current_weather,
    station_id: station_id)
end

Then(/^I should see the current weather conditions for station id "(.+)"$/) do |station_id|
  condition = @current_conditions[station_id]
  within("#current_conditions") do
    expect(page).to have_content("#{condition.location_name}")
  end
end

Given(/^forecast weather data exists for zip code (\d+)$/) do |zip_code|
  @forecasts ||= {}
  @forecasts[zip_code] = (1..12).map do |i|
    FactoryGirl.create(:forecast, zip_code: zip_code.to_i,
      time: Time.now + i.days * 0.5)
  end
end

Then(/^I should see the forecast data for zip code (\d+)$/) do |zip_code|
  within("#extended_forecast") do
    expect(page).to have_content "Extended Forecast"
    @forecasts[zip_code].each_with_index do |forecast, index|
      within("#extended_forecast-#{index}") do
        expect(page).to have_content(forecast.date_description)
      end
    end
  end
end

Given(/^hourly forecast weather data exists for zip code (\d+)$/) do |zip_code|
  @hourly_forecast ||= {}
  @hourly_forecast[zip_code] = 8.times.map do |i|
    FactoryGirl.create(:hourly_forecast, zip_code: zip_code.to_i,
      time: Time.zone.now + i.hours * 3)
  end
end

Then(/^I should see hourly forecast data for zip code (\d+)$/) do |zip_code|
  within("#hourly_forecast") do
    expect(page).to have_content "Next 24 Hours"
    @hourly_forecast[zip_code].each_with_index do |hourly, index|
      within("#hourly_forecast-#{index}") do
        expect(page).to have_content(hourly.time.to_s(:time))
      end
    end
  end
end
