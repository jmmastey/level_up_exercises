require "capybara/cucumber"
require "capybara/dsl"
require "capybara/rspec"
require_relative "../../overlord"

Capybara.app = Overlord

Given(/^my bomb is not booted$/) do
  visit("/")
end

When(/^I boot my bomb$/) do
  click_on("Boot")
end

Then(/^my bomb should be inactive$/) do
  expect(find(".activation_status")).to have_content("INACTIVE")
end

Given(/^I set my activation code to (\d+)$/) do |code|
  fill_in("activation_code", with: code)
end

Given(/^I set my deactivation code to (\d+)$/) do |code|
  fill_in("deactivation_code", with: code)
end

When(/^I set my activation code to "(.*?)"$/) do |code|
  fill_in("activation_code", with: code)
end
