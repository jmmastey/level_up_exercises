require './spec/spec_helper.rb'
include OverlordTest

When(/^I change no configuration code$/) do
  click_button "submit"
end

When(/^I change the activation code to "(.*?)"$/) do |code|
  fill_in "activate_code", with: code
  click_button "submit"
  expect(page.status_code).to eq(200)
end

Given(/^I change the deactivation code to "(.*?)"$/) do |code|
  fill_in "deactivate_code", with: code
  click_button "submit"
  expect(page.status_code).to eq(200)
end

Given(/^I fill in the activation code as "(.*?)"$/) do |code|
  fill_in "activate_code", with: code
end

Given(/^I fill in the deactivation code as "(.*?)"$/) do |code|
  fill_in "deactivate_code", with: code
end

Given(/^I submit the configuration$/) do
  click_button "submit"
  expect(page.status_code).to eq(200)
end

Then(/^I am on the configuration page$/) do
  expect(page.status_code).to eq(200)
  expect(page).to have_content("Override")
end