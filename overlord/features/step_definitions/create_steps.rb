ENV['RACK_ENV'] = 'test'
require 'rack/test'
require_relative '../../super_villain_tools.rb'
require_relative '../../overlord.rb'

Before do
  visit "/bomb_status"
  @options = {}
end

Given(/^no bomb is booted\/created$/) do
  page.should have_content "No Bomb"
end

When(/^I click on create button$/) do
  page.driver.post('/create_bomb', @options)
end

Then(/^create a bomb$/) do
  step "I click on create button"
end

Then(/^show a notification "([^"]*)"$/) do |status|
  raise "error" unless page.body.include? status
end

Given(/^activation code input is empty$/) do
  step "no bomb is booted/created"
end

Then(/^set activation code to (\d+)$/) do |activation_code|
  step "create a bomb"
end

When(/^I input an activation code "([^"]*)"$/) do |activation_code|
  @options["activation_code"] = activation_code
end

Then(/^set the activation code to "([^"]*)"$/) do |activation_code|
  step "create a bomb"
end

Given(/^deactivation code input is empty$/) do
  step "no bomb is booted/created"
end

Then(/^set deactivation code to "([^"]*)"$/) do |deactivation_code|
  step "create a bomb"
end

When(/^I input a deactivation code "([^"]*)"$/) do |deactivation_code|
  @options["deactivation_code"] = deactivation_code
end
