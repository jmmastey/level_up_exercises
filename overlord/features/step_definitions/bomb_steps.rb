Given(/^I visit the home page$/) do
  visit('/')
end

When(/^I do nothing$/) do
end

When(/^I boot the bomb$/) do
  click_button('Boot')
end

Then(/^the bomb should be booted$/) do
  expect(find('.bomb_status').text).to eq("Booted up!")
end

When(/^I configure the activation code "([^"]*)"$/) do |code|
  fill_in('configure_activation_code', with: code)
end

Then(/^the bomb should be off$/) do
  expect(find('.bomb_status').text).to eq("Off!")
end

Given(/^the bomb is booted with default config$/) do
  visit('/')
  click_button('Boot')
end

When(/^I submit the activation code "([^"]*)"$/) do |code|
  fill_in('submit_activation_code', with: code)
  click_button('Activate')
end

Then(/^the bomb is now activated$/) do
  expect(find('.bomb_status').text).to eq("Activated!")
end

Given(/^the bomb is activated with default config$/) do
  fill_in('submit_activation_code', with: "1234")
  click_button('Activate')
end

When(/^I submit the deactivation code "([^"]*)"$/) do |code|
  fill_in('submit_deactivation_code', with: code)
  click_button('Deactivate')
end

Then(/^the bomb should be deactivated$/) do
  expect(find('.bomb_status').text).to eq("Deactivated!")
end

Then(/^the bomb should explode$/) do
  expect(find('.bomb_status').text).to eq("Exploded!")
end
