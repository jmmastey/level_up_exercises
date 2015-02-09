Given(/^I can see the unbooted bomb$/) do
  visit '/'
end

Then(/^I see fields to enter activation\/deactivation codes$/) do
  expect(page).to have_selector(".boot_activation_code")
  expect(page).to have_selector(".boot_deactivation_code")
end

Then(/^I see a switch to boot the bomb$/) do
  expect(page).to have_selector(".boot_button")
end

When(/^I boot the bomb$/) do
  click_button("Boot")
end

Then(/^the bomb is booted, but deactivated$/) do
  expect(page).to have_selector(".inactive")
end

When(/^I enter "(.*?)" for the activation code$/) do |code|
  fill_in('activation_code', with: code )
end

When(/^I enter "(.*?)" for the deactivation code$/) do |code|
  fill_in('deactivation_code', with: code )
end

Then(/^the bomb is not booted$/) do
  expect(page).to have_selector('.activation_button')
end