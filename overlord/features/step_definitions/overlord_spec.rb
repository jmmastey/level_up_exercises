require_relative '../support/env'

Given(/^I visit the activation page$/) do
  activation_page
end

Given(/^Configure bomb with codes '(.*?)' and '(.*?)'$/) do |arg1, arg2|
  configure_bomb(arg1, arg2)
end

Then(/^I should see 'Activated'$/) do
  expect(page).to have_content("Activated")
end

Then(/^I should see 'Deactivated'$/) do
  expect(page).to have_content("Phew")
end

Then(/^I should see the bomb as 'Exploded'$/) do
  expect(page).to have_content("BOOM")
end

Then(/^I should not be able to use any of the buttons$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I do nothing on the deactivation page for 30 seconds$/) do
  sleep(30)
  expect(page).to have_content("BOOM")
end

When(/^I fill in '(\d+)' to deactivate the bomb$/) do |arg1|
  deactivate_bomb(arg1)
end

When(/^I snip the wire$/) do
  click_button 'snip'
  expect(page).to have_content("Phew")
end

When(/^I activate the bomb with code '(\d+)'$/) do |arg1|
  activate_bomb(arg1)
end

Then(/^I should remain on the activation page$/) do
  expect(page).to have_content("Enter activation code")
end