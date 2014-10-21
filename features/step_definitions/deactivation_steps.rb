require_relative '../support/env'

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

Given(/^I snip the wire$/) do
  click_button 'snip'
  expect(page).to have_content("Phew")
end