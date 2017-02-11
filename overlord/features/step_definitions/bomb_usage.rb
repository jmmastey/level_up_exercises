$LOAD_PATH << 'lib'

require 'bomb'

Given(/^I visit the root page$/) do
  visit("http://localhost:4567/")
  Bomb.new("1234", "0000")
end

When(/^I submit the activation code$/) do
  fill_in 'code', with: '1234'
  click_button 'Submit'
end

Then(/^the bomb will be active$/) do
  visit("http://localhost:4567/")
  expect(page).to have_content 'BOMB STATUS - ACTIVE'
end

Given(/^I visit the root page again$/) do
  visit("http://localhost:4567/")
end

When(/^I submit the deactivation code$/) do
  fill_in 'code', with: '0000'
  click_button 'Submit'
end

Then(/^the bomb will be Inactive$/) do
  expect(page).to have_content 'BOMB STATUS - INACTIVE'
end
