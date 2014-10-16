require_relative '../support/env'

Given(/^I visit the configuration page$/) do
  visit host_url
end

Then(/^I should remain on the deactivation page$/) do
  expect(page).to have_content("Activated")
end

Then(/^I should remain on the activation page$/) do
  expect(page).to have_content("Enter activation code")
end

Then(/^The bomb should not be configured$/) do
  expect(page).to have_content("Bomb Configuration")
end

Given(/^I have a configured bomb with default codes$/) do
  visit host_url
  click_button 'Configure'
end

Given(/^Configure bomb with codes '(\w+)' and '(\w+)'$/) do | act_code,
    deact_code |
  fill_in 'activation_code', with: act_code
  fill_in 'deactivation_code', with: deact_code
  click_button 'Configure'
end
