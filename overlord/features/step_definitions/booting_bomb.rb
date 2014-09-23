require "capybara/cucumber"
require "capybara/dsl"
require "capybara/rspec"
require_relative "../../overlord"

# Given #
Given(/^I first arrive at the bomb site$/) do
  visit("/")
end

# When #
When(/^I leave activation and deactivation fields blank$/) do
end

When(/^I enter custom codes (\d+) (\d+)$/) do |act_code, deact_code|
  fill_in("activation_code", with: act_code)
  fill_in("deactivation_code", with: deact_code)
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

# Then #
Then(/^I should see a status of "(.*?)"$/) do |status|
  page.should have_content(status)
end

Then(/^there should be a\/an "(.*?)" field$/) do |name|
  page.should have_field(name)
end

Then(/^I should stay on the page \(not be able to press boot, etc\.\)$/) do
  expect(page).not_to have_content "Activate"
end
