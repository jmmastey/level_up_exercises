ENV['RACK_ENV'] = 'test'
require 'rack/test'
require_relative '../../super_villain_tools.rb'
require_relative '../../overlord.rb'

Given(/^a bomb is activated$/) do
  step "activation code input is empty"
  step 'I input an activation code "4242"'
  step 'I input a deactivation code "0000"'
  step "I click on create button"
  step 'set the activation code to "4242"'
  step 'set deactivation code to "0000"'
  step 'I input an activation code "4242"'
  step "click on activate button"
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
