Given(/^I am on the bomb page$/) do
  visit '/bomb'
end

When(/^I set valid activation and deactivation codes$/) do
  ACTIVATION_CODE = 1234
  DEACTIVATION_CODE = 0000
  DUPLICATE_CODE = 1234
  INCORRECT_CODE = "asdf1234"
  BLANK_CODE = ""
  initialize_bomb(ACTIVATION_CODE, DEACTIVATION_CODE)
end

When(/^I set invalid activation or deactivation codes$/) do
  initialize_bomb(ACTIVATION_CODE, INCORRECT_CODE)
end

When(/^I set invalid duplicate activation or deactivation codes$/) do
  initialize_bomb(ACTIVATION_CODE, DUPLICATE_CODE)
end

When(/^I set blank activation or deactivation codes$/) do
  initialize_bomb(BLANK_CODE, BLANK_CODE)
end

Then(/^I should be directed to the inactive_bomb page$/) do
  expect(current_path).to eq '/inactive_bomb'
end

Given(/^I am on the inactive_bomb page$/) do
  visit '/bomb'
  initialize_bomb(ACTIVATION_CODE, DEACTIVATION_CODE)
end

When(/^I input the correct activation code$/) do
  validate_code('activation_code', ACTIVATION_CODE)
end

Then(/^I should be directed to the active_bomb page$/) do
  expect(current_path).to eq '/active_bomb'
end

When(/^I input the incorrect activation code$/) do
  validate_code('activation_code', INCORRECT_CODE)
end

Then(/the page should contain (.*)/) do |input|
  expect(page).to have_content(input)
end

Given(/^I am on the active_bomb page$/) do
  visit '/bomb'
  initialize_bomb(ACTIVATION_CODE, DEACTIVATION_CODE)
  validate_code('activation_code', ACTIVATION_CODE)
end

When(/^I input the correct deactivation code$/) do
  validate_code('deactivation_code', DEACTIVATION_CODE)
end

When(/^I input the incorrect deactivation code$/) do
  validate_code('deactivation_code', INCORRECT_CODE)
end

When(/^I input the incorrect deactivation code max times$/) do
  validate_code('deactivation_code', INCORRECT_CODE)
  validate_code('deactivation_code', INCORRECT_CODE)
  validate_code('deactivation_code', INCORRECT_CODE)
end

Then(/^I should be directed to the explosion page$/) do
  expect(current_path).to eq '/explosion'
end
