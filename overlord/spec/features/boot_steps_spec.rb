require './spec/spec_helper.rb'
include OverlordTest

Given /^I have not booted the bomb$/ do
end

When /^I have booted the bomb$/ do
  visit '/'
end

Then(/^the status indicator shows as deactivated$/) do
  expect(page).to have_content("The bomb is not active")
end
