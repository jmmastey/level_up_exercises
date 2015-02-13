Given(/^that the bomb is booted with default codes$/) do
  visit '/'
  click_button("Boot")
end

Then(/^I see fields to enter the activation code$/) do
  expect(page).to have_selector(".activation_code")
end

Then(/^I see a button to activate the bomb$/) do
  expect(page).to have_selector(".activation_button")
end

When(/^I enter the default activation code$/) do
  fill_in('activation_code', with: "1234")
end

When(/^I press the activate button$/) do
  click_button("Activate")
end

Then(/^the bomb is active$/) do
  expect(page).to have_selector(".active")
end

Given(/^the bomb is booted with "(.*?)"$/) do |code|
  visit '/'
  fill_in('deactivation_code', with: code)
  fill_in('activation_code', with: code)
  click_button("Boot")
end

Then(/^to bomb warns me that I was wrong$/) do
  expect(page).to have_selector(".incorrect_code_submitted")
end

Then(/^it is not activated$/) do
  expect(page).to have_selector(".inactive")
end
