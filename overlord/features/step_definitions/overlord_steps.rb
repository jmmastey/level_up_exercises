ACTIVATION_CODE = 1234
DEACTIVATION_CODE = 0000
DUPLICATE_CODE = 1234
INCORRECT_CODE = "asdf1234"
BLANK_CODE = ""

When /^I am on the bomb page$/ do
  @bomb_page = BombPage.new
  @bomb_page.load
end

Then /^I should see instructions and the form to set and submit codes$/ do
  expect(@bomb_page).to have_instructions
  expect(@bomb_page).to have_activation_code_field
  expect(@bomb_page).to have_deactivation_code_field
  expect(@bomb_page).to have_submit_button
end

When(/^I set valid activation and deactivation codes$/) do
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
  @inactive_bomb_page = InactiveBombPage.new
  expect(@inactive_bomb_page).to be_displayed
end

When /^I am on the inactive_bomb page$/ do
  @inactive_bomb_page = InactiveBombPage.new
  @inactive_bomb_page.load
end

Then /^I should see instructions and the form to submit the activation code$/ do
  expect(@inactive_bomb_page).to have_instructions
  expect(@inactive_bomb_page).to have_activation_code_field
  expect(@inactive_bomb_page).to have_submit_button
end

When(/^I input the correct activation code$/) do
  initialize_bomb(ACTIVATION_CODE, DEACTIVATION_CODE)
  validate_code('activation_code', ACTIVATION_CODE)
end

Then(/^I should be directed to the active_bomb page$/) do
  @active_bomb_page = ActiveBombPage.new
  expect(@active_bomb_page).to be_displayed
end

When /^I am on the active_bomb page$/ do
  @active_bomb_page = ActiveBombPage.new
  @active_bomb_page.load
end

Then /^I should see instructions and the form to submit the deactivation code$/ do
  expect(@active_bomb_page).to have_instructions
  expect(@active_bomb_page).to have_deactivation_code_field
  expect(@active_bomb_page).to have_submit_button
end

When(/^I input the incorrect activation code$/) do
  initialize_bomb(ACTIVATION_CODE, DEACTIVATION_CODE)
  validate_code('activation_code', INCORRECT_CODE)
end

Then(/the page should contain (.*)/) do |input|
  expect(page).to have_content(input)
end

Given(/^I have successfully activated the bomb$/) do
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
  @explosion_page = ExplosionPage.new
  expect(@explosion_page).to be_displayed
end
