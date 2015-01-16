require './spec/spec_helper.rb'
include OverlordTest

Then(/^the buttons work$/) do
  expect(page.status_code).to eq(200)
  expect(page).to have_button("submit", disabled: false)
end

Then(/^I am on the control page$/) do
  expect(page.status_code).to eq(200)
  expect(page).to have_field('code')
end
