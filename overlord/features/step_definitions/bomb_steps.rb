
require 'capybara/cucumber'
require 'capybara'

DEFAULT_ACTIVATION_CODE = "1234"
DEFAULT_DEACTIVATION_CODE = "0000"
SPECIFIED_ACTIVATION_CODE = "1444"
SPECIFIED_DEACTIVATION_CODE = "1111"

Given(/^the bomb page is loaded$/) do
  visit('/bomb')
end

Then(/^it is not activated$/) do
  expect(page).to have_content("inactive")
  click_button "newbomb"
end

When(/^I input the default activation code$/) do
  fill_in "activation_input", with: DEFAULT_ACTIVATION_CODE
  click_button 'submit'
end

And(/^the bomb is now active$/) do
  expect(page).to(have_content("active"))
  expect(page).not_to(have_content("inactive"))
end

Then(/^the bomb is active$/) do
  expect(page).to(have_content("active"))
  expect(page).not_to(have_content("inactive"))
  click_button "newbomb"
end

Given(/^the bomb page is loaded with specified$/) do
  visit("/newbomb/#{SPECIFIED_ACTIVATION_CODE}/#{SPECIFIED_DEACTIVATION_CODE}")
end

When(/^I input the specified activation code$/) do
  fill_in "activation_input", with: SPECIFIED_ACTIVATION_CODE
  click_button 'submit'
end

When(/^I input the wrong code$/) do
  fill_in "activation_input", with: "1"
  click_button 'submit'
end

Given(/^the bomb page is loaded with non numeric$/) do
  visit("/newbomb/1aaa/#{SPECIFIED_DEACTIVATION_CODE}")
end

Then(/^I get an error$/) do
  expect(page).to have_content("Error")
end

When(/^I input the default deactivation code$/) do
  fill_in "deactivation_input", with: DEFAULT_DEACTIVATION_CODE
  click_button 'submit'
end

When(/^I input the specified deactivation code$/) do
  fill_in "deactivation_input", with: SPECIFIED_DEACTIVATION_CODE
  click_button 'submit'
end

When(/^I input an incorrect deactivation code$/) do
  fill_in "deactivation_input", with: "1"
  click_button 'submit'
end

Then(/^the number of attempts remaining is (\d+)$/) do |arg1|
  expect(page).to have_content("Failed deactivations: #{3 - arg1.to_i} of 3")
  click_button "newbomb"
end

Then(/^the bomb explodes$/) do
  expect(page).to have_content("exploded")
end
