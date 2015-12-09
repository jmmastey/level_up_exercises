
require 'capybara/cucumber'
require 'capybara'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :chrome
Capybara.configure do |config|
  config.run_server = false
  config.app_host = "localhost:4567"
end

Given(/^the bomb page is loaded$/) do
  visit('/bomb')
end

Then(/^it is not activated$/) do
  page.has_content?("inactive")
end

When(/^I input the default activation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb is active$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the status informs us that the bomb is active$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the bomb page is loaded with specified$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I input the specified activation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I input the wrong code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the bomb page is loaded with non numeric$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I get an error$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I input the default deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb is not activated$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^the bomb page is loaded with specified deactivation$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I input the specified deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

When(/^I input an incorrect deactivation code$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the number of attempts remaining is (\d+)$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb explodes$/) do
  pending # Write code here that turns the phrase above into concrete actions
end