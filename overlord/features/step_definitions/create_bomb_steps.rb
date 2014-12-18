Given(/^I'm on the homepage$/) do
  visit('/')
end

Given(/^there is no bomb created yet$/) do
  # Relevant? How to check?
end

When(/^I create a bomb$/) do
  fill_in("create_activation_code", with: 1234)
  fill_in("create_deactivation_code", with: 1234)
  click_on('Create!')
end

# ================================================

When(/^I create a bomb with no activation or deactivation code$/) do
  click_on('Create!')
end

When(/^I create a bomb with only an activation code$/) do
  fill_in("create_activation_code", with: 1234)
  click_on('Create!')
end

When(/^I create a bomb with only a deactivation code$/) do
  fill_in("create_deactivation_code", with: 1234)
  click_on('Create!')
end

Then(/^I the bomb status should be Inactive$/) do
  expect(page).to have_content("Bomb Status: Inactive")
end

Then(/^I should still see "(.*?)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
