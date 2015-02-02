Given(/^I visit "(.*?)" page$/) do |arg1|
  visit arg1
end

Given(/^I submit the city name$/) do
  find(:css, "#city_name").set("Chicago")
  find(:link_or_button, "Send").click
end

Given(/^I did not submit the city name$/) do
  find(:css, "#city_name").set("Chicago")
end

Then(/^I should see temperature forecast$/) do
  expect(page).to have_selector('#temperatue_forecast_table')
end

Then(/^I should not see temperature forecast$/) do
  expect(page).to_not have_selector('#temperatue_forecast_table')
end