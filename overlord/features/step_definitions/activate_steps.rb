ENV['RACK_ENV'] = 'test'
require 'rack/test'
require_relative '../../super_villain_tools.rb'
require_relative '../../overlord.rb'

Given(/^a bomb is created\/booted$/) do
  step "create a bomb"
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
