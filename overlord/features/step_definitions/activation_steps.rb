require_relative '_helpers'

Given(/^I have booted a bomb with the default codes$/) do
  visit("/")
  click_on("Boot")
end

Given(/^the (?:code|time) (\d+) was entered$/) do |code|
  enter_code_on_keypad(code)
end

When(/^I enter a blank (?:code|time)/) do
  enter_code_on_keypad
end

When(/^I enter the (?:code|time) (\d+)$/) do |code|
  enter_code_on_keypad(code)
end

Then(/^I should see the time prompt$/) do
  expect(find(".message")).to have_content("TIMER")
end

Then(/^the bomb should be activated$/) do
  expect(find(".activation_status")).to have_content("ACTIVE")
end

Then(/^the bomb should be deactivated$/) do
  expect(find(".activation_status")).to have_content("INACTIVE")
end

Then(/^the number of remaining disarm attempts should be set to (\d+)$/) do |attempts|
  expect(page).to have_content("#{attempts} attempts until detonation")
end

Then(/^I should see the message "([^"]+)"$/) do |message|
  expect(find(".message")).to have_content(message)
end
