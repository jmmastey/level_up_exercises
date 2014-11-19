require_relative '../support/helpers.rb'

Given /^the bomb is activated$/ do
  visit path_to('the home page')
  activate(1234)
end

Given /^the bomb is deactivated$/ do
end

Given /^the bomb is exploded$/ do
  step "the bomb is activated"
  visit path_to('the home page')
  attempt_deactivate('8888', (Bomb::MAX_ALLOWED_DEACTIVATION_ATTEMPS + 1))
end

Given /^I have inserted "(.*?)" as the activation code$/ do |code|
  visit path_to('the home page')
  fill_activate_code(code)
end

Given /^I have inserted "(.*?)" as the deactivation code$/ do |code|
  visit path_to('the home page')
  fill_deactivate_code(code)
end

Given /^I have tried to deactivate (.+) time(?:s)? unsuccesfully$/ do |tries|
  tries = tries.to_i unless tries == 'max'
  visit path_to('the home page')
  attempt_deactivate('8888', tries)
end

When /^I try to deactivate unsuccessfully again$/ do
  attempt_deactivate('8888')
end

Then /^the bomb should be ([^\s]+)$/ do |status|
  if status == "exploded"
    message = "The bomb exploded"
  else
    message = "The bomb is #{status}"
  end

  step "I should see \"#{message}\""
end

Then /^the bomb should be a new one$/ do
  step "the bomb should be deactivated"
end
