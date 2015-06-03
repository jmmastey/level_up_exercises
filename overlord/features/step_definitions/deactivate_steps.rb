ENV['RACK_ENV'] = 'test'
require 'rack/test'
require_relative '../../super_villain_tools.rb'
require_relative '../../overlord.rb'

Given(/^a bomb is activated$/) do
  step "create a bomb"
  step 'I input an activation code "1234"'
  step "activate the bomb"
end

When(/^click on deactivate button$/) do
  page.driver.post '/deactivate_bomb', @options
end

Then(/^deactivate the bomb$/) do
  # do nothing here
end

Then(/^do not deactivate the bomb$/) do
  # do nothing here
end

Given(/^number of previous attempts is equal to (\d+)$/) do |code|
  step 'I input a deactivation code "' + code + '"'
  step "click on deactivate button"
  step 'I input a deactivation code "' + code + '"'
  step "click on deactivate button"
end

Then(/^detonate the bomb$/) do
  # do nothing here
end
