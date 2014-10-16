require_relative '../support/env'

Given(/^I visit the configuration page$/) do
  visit host_url
  expect(page).to have_field("activation_code")
end

Given(/^Configure bomb with codes '(.*?)' and '(.*?)'$/) do | act_code,
    deact_code |
  fill_in 'activation_code', with: act_code
  fill_in 'deactivation_code', with: deact_code
  click_button 'Configure'
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

When(/^I do nothing on the deactivation page for 30 seconds$/) do
  sleep(30)
  expect(page).to have_content("BOOM")
end

When(/^I fill in '(\d+)' to deactivate the bomb$/) do | deact_code |
  fill_in 'deactivation_code', with: deact_code
  click_button 'Deactivate'
end

When(/^I snip the wire$/) do
  click_button 'snip'
  expect(page).to have_content("Phew")
end

When(/^I activate the bomb with code '(\d+)'$/) do | act_code |
  fill_in 'activation_code', with: act_code
  click_button 'Activate!'
end

When(/^I activate the bomb with code 'ABBA'$/) do
  pending
end

Then(/^I should remain on the activation page$/) do
  expect(page).to have_content("Enter activation code")
end

Then(/^The bomb should not be configured$/) do
  expect(page).to have_content("Bomb Configuration")
end
