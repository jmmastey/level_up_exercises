require_relative '../support/env'

Given(/^I visit the activation page$/) do
  activation_page
end

Given(/^Configure bomb with codes '(.*?)' and '(.*?)'$/) do |arg1, arg2|
  configure_bomb(arg1, arg2)
end

When(/^I fill in '(.*?)' to activate the bomb$/) do |arg1|
  activate_bomb(arg1)
end

Then(/^I should see 'Activated'$/) do
  pending # do a check to make sure the page shows activated
end

Then(/^I should see 'Deactivated'$/) do
  pending # do a check to make sure the page shows deactivated
end

Given(/^I attempt to deactivate the bomb with incorrect activation codes$/) do
  deactivate_bomb(1111)
end

When(/^I fill in '(\d+)', '(\d+)' and '(\d+)' to deactivate the bomb$/) do
|arg1, arg2, arg3|
  deactivate_bomb(arg1)
  deactivate_bomb(arg2)
  deactivate_bomb(arg3)
end

Then(/^I should see the bomb as 'Exploded'$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not be able to use any of the buttons$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I attempt to go back to the activation page$/) do
  activation_page
end

When(/^I do nothing on the deactivation page for 30 seconds$/) do
  activation_page
  configure_bomb(1111,2222)
  activate_bomb(1111)
  # Wait 30 seconds then verify exploded state
end

When(/^I fill in '(\d+)' to deactivate the bomb$/) do |arg1|
  deactivate_bomb(arg1)
end

When(/^I snip the wire$/) do
  pending # express the regexp above with the code you wish you had
end