require_relative 'helpers'

Given(/^I am on the "([^"]*)" page$/) do |page_name|
  visit page_name
end

Then(/^I should see bomb is unbooted$/) do
  expect(page).to have_content('Bomb Status: Not Booted')
end

#
Given(/^I have an unbooted bomb$/) do
  shutdown_bomb
  expect(page).to have_content('Bomb Status: Not Booted')
end

Given(/^I enter '(\d+)' for "([^"]*)"$/) do |value, field|
  # save_and_open_page
  fill_in(field, with: value)
end

When(/^I press "([^"]*)" within "([^"]*)"$/) do |button_name, page|
  visit page
  click_button(button_name)
end

Then(/^I should see "([^"]*)" within "([^"]*)"$/) do |arg1, page|
  expect(page).to have_content(arg1)
end

When(/^I pry$/) do
  require 'pry'
  binding.pry
end
#
# #
# Given(/^the bomb arming code is not configured$/) do
#   expect(page).to have_content('Enter New Bomb Arming Code:')
# end
#