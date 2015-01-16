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

When(/^I enter the wrong activation code$/) do
  fill_in "code", with: "1111"
  click_button "submit"
end

When(/^I enter the wrong deactivation code$/) do
  fill_in "code", with: "1111"
  click_button "submit"
end

When(/^I submit with no activation code$/) do
  click_button "submit"
end

Then(/^a blank code warning shows$/) do
  expect(page.status_code).to eq(200)
  expect(page).to have_content("You must enter a code")
end

Then(/^the status indicator shows as activated$/) do
  expect(page.status_code).to eq(200)
  expect(page).to have_content("Bomb is active")
end
