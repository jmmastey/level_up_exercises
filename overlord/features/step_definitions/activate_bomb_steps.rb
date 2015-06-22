require 'pry'
Given(/^that I am on the activate bomb page$/) do
  visit('/')
  fill_in('activation_code', with: "3456")
  fill_in('deactivation_code', with: "9872")
  click_button('Boot Bomb')
end

When(/^I submit an invalid activation code$/) do
  fill_in('entered_activation_code', with: "34569")
  click_button('activate')
end

Then(/^I should see an activation code error message$/) do
  expect(page).to have_content('Please enter a valid 4 digit activation number')
end

When(/^I submit a valid activation code$/) do
  fill_in('entered_activation_code', with: "3456")
  click_button('activate')
end

Then(/^I should activate the bomb$/) do
  expect(page).to have_content('Time remaining until your destruction:')
end