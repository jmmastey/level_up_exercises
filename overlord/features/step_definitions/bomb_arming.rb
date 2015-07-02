#encoding: utf-8
require './classes/bomb.rb'

Given(/^the bomb is disarmed$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I (don't )?know the correct bomb code$/) do |arg1|
  @code = arg1 ? 1234567890 : 8005882300
end

When(/^I enter the code and submit$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the bomb should (not )?arm$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^the timer should (not )?start$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end
