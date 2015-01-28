Given(/^I am on the home page$/) do
  visit "/"
end

Then(/^I should see fields to enter codes to boot the bomb$/) do
  expect(page).to have_selector(".act_code_for_booting")
  expect(page).to have_selector(".deact_code_for_booting")
end

Then(/^I should see a button to boot the bomb$/) do
  expect(page).to have_selector(".boot_bomb_button")
end

When(/^I try to boot the bomb$/) do
  click_button("Boot bomb")
end

Then(/^the bomb should boot and be deactivated$/) do
  expect(page).to have_selector(".bomb_deactivated")
end

Given(/^I enter "(.*?)" for the activation code$/) do |activation_code|
  fill_in("act_code", with: activation_code)
end

Given(/^I enter "(.*?)" for the deactivation code$/) do |deactivation_code|
  fill_in("deact_code", with: deactivation_code)
end

Then(/^the bomb should not boot$/) do
  expect(page).to have_selector(".boot_bomb_button")
end
