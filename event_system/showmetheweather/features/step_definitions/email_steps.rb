Given(/^I have a user account$/) do
  @user = FactoryGirl.create(:user)
end

When(/^the daily email forecast is sent to me$/) do
  forecast = Forecast.find_by(zip_code: @user.zip_code)
  ForecastMailer.daily_email(forecast, @user).deliver_now
end

Then(/^it contains the weather forecast for the zip code that I configured$/) do
  message = ActionMailer::Base.deliveries.last
  body = Capybara.string message.body.raw_source
  expect(body).to have_css("#forecast")
  expect(body.find("#forecast")).to have_content("Today")
  expect(body.find("#forecast")).to have_content("Tonight")
  expect(body.find("#forecast")).to have_content("100")
  expect(body.find("#forecast")).to have_content("75")
  expect(body.find("#forecast")).to have_content("50%")
  expect(body.find("#forecast")).to have_content("25%")
  expect(body.find("#forecast")).to have_content("Mostly Sunny")
  expect(body.find("#forecast")).to have_content("Mostly Cloudy")
end
