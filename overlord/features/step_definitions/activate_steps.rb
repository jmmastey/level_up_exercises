ENV['RACK_ENV'] = 'test'
require 'rack/test'
require_relative '../../super_villain_tools.rb'
require_relative '../../overlord.rb'

Given(/^a bomb is created\/booted$/) do
  step "activation code input is empty"
  step 'I input an activation code "4242"'
  step "I click on create button"
  step 'set the activation code to "4242"'
end

When(/^click on activate button$/) do
  # do nothing yet
end

Then(/^activate the bomb$/) do
  page.driver.post '/activate_bomb', @options
end

Then(/^do not activate bomb$/) do
  step "activate the bomb"
end
