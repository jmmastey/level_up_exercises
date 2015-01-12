require_relative '../spec_helper.rb'
include OverlordTest

When(/^I enter the right activation code$/) do
  fill_in "code", with: "1234"
  click_button "submit"
end

When(/^I enter the right deactivation code$/) do
  fill_in "code", with: "0000"
  click_button "submit"
end

Then(/^the status indicator shows as activated$/) do
  expect(page).to have_content("Bomb is active")
end
