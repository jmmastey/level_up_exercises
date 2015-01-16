require './spec/spec_helper.rb'
include OverlordTest

Given /^I have booted the bomb$/ do
	visit '/'
end

Then(/^the status indicator shows as deactivated$/) do
	expect(page.status_code).to eq(200)
  expect(page).to have_content("The bomb is not active")
end
