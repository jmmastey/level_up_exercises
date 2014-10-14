require_relative '../support/env'

Given(/^I visit the configuration page$/) do
  configuration_page
  expect(page).to have_field("activation_code")
end

Given(/^Configure bomb with codes '(.*?)' and '(.*?)'$/) do |act, deac|
  configure_bomb(act, deac)
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
  default_wait_time
  expect(page).to have_content("BOOM")
end

When(/^I fill in '(\d+)' to deactivate the bomb$/) do |arg1|
  deactivate_bomb(arg1)
end

When(/^I snip the wire$/) do
  snip_wire
  expect(page).to have_content("Phew")
end

When(/^I activate the bomb with code '(\d+)'$/) do |arg1|
  activate_bomb(arg1)
end

When(/^I activate the bomb with code 'ABBA'$/) do
  activate_bomb("ABBA")
end

Then(/^I should remain on the activation page$/) do
  expect(page).to have_content("Enter activation code")
end

Then(/^The bomb should not be configured$/) do
  expect(page).to have_content("Bomb Configuration")
end
