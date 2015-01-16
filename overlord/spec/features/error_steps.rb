require './spec/spec_helper.rb'
include OverlordTest

Then(/^the error message "(.*?)" shows$/) do |message|
  expect(page.status_code).to eq(200)
  expect(page).to have_content(message)
end
