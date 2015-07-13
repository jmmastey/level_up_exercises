require 'capybara/cucumber'

Given(/^Super villain is booting a bomb$/) do
  visit "http://localhost:8080/mybomb"
end

When(/^Super villain is on the main page$/) do
  expect(page).to have_button('New', disabled: false)
end

And(/^Super villain clicks the "([^"]*)" button$/) do |button_name|
  click_button button_name
end

And(/^Super villain does not provide a custom activation code$/) do
  fill_in "field-custom-activation-code", with: ""
end

When(/^the bomb boots$/) do
  expect(page).to have_text("Bomb booted successfully")
end

Then(/^the bomb should not be activated$/) do
  expect(page).to have_text("Bomb status: Inactive")
end

And(/^the Super villain should see a message that a new bomb was created$/) do
  expect(page).to have_text("Bomb created successfully")
end

And(/^the bomb activation code should be set to (\d+)$/) do |code|
  expect(page).to have_text("Bomb activation code: " + code)
end

And(/^Super villain does provide a custom activation code "([^"]*)"$/) do |code|
  fill_in "field-custom-activation-code", with: code
end

And(/^the Super villain should see a message that a new bomb was not created$/) do
  expect(page).to have_text("Bomb was not created")
end

Given(/^Super villain has an already booted and activated the bomb$/) do
  visit "http://localhost:8080/mybomb"
  expect(page).to have_text("Bomb status: Inactive")
end

And(/^the bomb activation code should not change$/) do
  expect(page).to have_text("Bomb activation code: 9999").to eq false
end


