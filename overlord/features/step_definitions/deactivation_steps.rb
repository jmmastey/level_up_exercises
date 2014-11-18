Given /^I have tried to deactivate (.+) time(?:s)? unsuccesfully$/ do |tries|
  tries = tries.to_i unless tries == 'max'
  visit path_to('the active page')
  attempt_deactivate('8888', 'max')
end

When(/^I try to deactivate unsuccessfully again$/) do
  attempt_deactivate('8888')
end

Given(/^the bomb is deactivated$/) do
end
