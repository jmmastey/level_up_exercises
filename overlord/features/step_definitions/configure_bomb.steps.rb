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
end

Given(/^I enter '(\d+)' for "([^"]*)"$/) do |value, field|
  fill_in(field, with: value)
end

When(/^I press "([^"]*)" within "([^"]*)"$/) do |button_name, _page|
  click_button(button_name)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
