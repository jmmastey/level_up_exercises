def custom_code
  Array.new(4) { "#{rand(0..9)}" }.join
end

def close_alert_messages
  2.times do
    find('.sweet-alert .confirm').click
    find('.btn.deactivate-bomb').click
  end
  find('.sweet-alert .confirm').click
end

Given(/^I visit the home page$/) do
  visit('/')
end

Given(/^I use the default activation and deactivation codes$/) do
  @activation_code = "1234"
  @deactivation_code = "0000"
end

Given(/^I have a bomb with a custom activation code$/) do
  @activation_code = custom_code
  fill_in('activation_code', with: @activation_code)
  find('.set-bomb').click
end

Given(/^I have a bomb with a custom deactivation code$/) do
  @activation_code = "1234"
  @deactivation_code = custom_code
  fill_in('deactivation_code', with: @deactivation_code)
  find('.set-bomb').click
end

Given(/^I have a bomb with custom activation and deactivation codes$/) do
  @activation_code = custom_code
  @deactivation_code = custom_code
  fill_in('activation_code', with: @activation_code)
  fill_in('deactivation_code', with: @deactivation_code)
  find('.set-bomb').click
end

When(/^I do nothing$/) do
end

When(/^I boot up the bomb$/) do
  find('.set-bomb').click
end

When(/^I configure the activation code to be "(.*)"$/) do |code|
  fill_in('activation_code', with: code)
end

When(/^I configure the deactivation code to be "(.*)"$/) do |code|
  fill_in('deactivation_code', with: code)
end

When(/^I activate the bomb with code "(.*)"$/) do |code|
  fill_in('activation_code', with: code)
  find('.btn.activate-bomb').click
end

When(/^I deactivate the bomb with code "(.*)"$/) do |code|
  fill_in('deactivation_code', with: code)
  find('.btn.deactivate-bomb').click
end

When(/^I activate the bomb$/) do
  fill_in('activation_code', with: @activation_code)
  find('.btn.activate-bomb').click
end

When(/^I deactivate the bomb$/) do
  fill_in('deactivation_code', with: @deactivation_code)
  find('.btn.deactivate-bomb').click
end

When(/^I fail at deactivating the bomb$/) do
  fill_in('deactivation_code', with: "fail")
  find('.btn.deactivate-bomb').click
  close_alert_messages
end

When(/^I wait for (\d+) seconds$/) do |seconds|
  sleep(seconds.to_i)
end

Then(/^the bomb will be on$/) do
  expect(find('.bomb-state').text.downcase).to eq('on')
end

Then(/^the bomb will be off$/) do
  expect(find('.bomb-state').text.downcase).to eq('off')
end

Then(/^the bomb will be activated$/) do
  expect(find('.bomb-state').text.downcase).to eq('activated')
end

Then(/^the bomb will not be activated$/) do
  expect(find('.bomb-state').text.downcase).to_not eq('activated')
end

Then(/^the bomb will be deactivated$/) do
  expect(find('.bomb-state').text.downcase).to eq('deactivated')
end

Then(/^the world will be destroyed$/) do
  expect(find('.bomb-state').text.downcase).to eq('destroyed')
end

Then(/^I will see "(.*)"$/) do |message|
  expect(page).to have_content(message)
end
