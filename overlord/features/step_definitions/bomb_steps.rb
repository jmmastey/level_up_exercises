require File.join(File.dirname(__FILE__), '..', 'support/helpers.rb')

World Helpers

Given /^I am not yet playing$/ do
end

Given /^I have already activated the bomb$/ do
  activate("1234", "1234")
end

Given /^I have already activated with "(.*?)" and "(.*?)"$/ do |act, deact|
  activate(act, deact)
end

Given /^the bomb has already exploded$/ do
  activate("1234", "1234")
  attempt_bad_deactivations
end

Given /^I have attempted to deactivate it 1 time$/ do
  attempt_bad_deactivation
end

When /^I attempt to deactivate with the wrong code too many times$/ do
  attempt_bad_deactivations
end
