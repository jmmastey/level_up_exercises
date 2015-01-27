Given(/^I am on the home page$/) do
  visit "/"
end

When(/^I do not enter an activation code or deactivation code$/) do
  visit "/"
  click_button("Boot bomb")
end

Then(/^the bomb should boot and be deactivated$/) do
  expect(page).to have_selector('.not_activated')
end

Then(/^I should see fields to enter the activation and deactivation codes for the bomb$/) do
  expect(page).to have_selector('.act_code')
  expect(page).to have_selector('.deact_code')
end

Then(/^I should see a button to boot the bomb$/) do
  expect(page).to have_selector('.boot_bomb')
end

When(/^I enter "(.*?)" for the activation code$/) do |activation_code|
  fill_in('act_code', with: activation_code)
end

When(/^I enter "(.*?)" for the deactivation code$/) do |deactivation_code|
  fill_in('deact_code', with: deactivation_code)
  click_button("Boot bomb")
end
  
Then(/^the bomb should not boot$/) do
  expect(page).to have_selector('.act_code')
  expect(page).to have_selector('.deact_code')
end

Then(/^the bomb should boot with the default codes and be deactivated$/) do
  expect(page).to have_selector('.not_activated')
end