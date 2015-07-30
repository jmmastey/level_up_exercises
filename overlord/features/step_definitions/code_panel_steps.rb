require_relative '../../bomb.rb'

Given(/^the bomb is armed$/) do
  submit_valid_input_sequence
  submit_valid_input_sequence
  submit_valid_input_sequence
end

When(/^I input "([^"]*)" for digit\-(\d+)$/) do |value, digitField|
  page.fill_in("digit-#{digitField}", with: value)
end

When(/^I submit a valid code input$/) do
  submit_valid_input_sequence
end

When(/^I submit an invalid code input$/) do
  submit_invalid_input_sequence
end

When(/^I submit no code input$/) do
  click_submit_button
end

When(/^I submit the default activation code$/) do
  submit_default_activation_code
end

When(/^I submit the default deactivation code$/) do
  submit_default_deactivation_code
end

When(/^I setup the bomb with the default activation code$/) do
  submit_default_activation_code
  submit_valid_input_sequence
end

When(/^I arm the bomb with the default deactivation code$/) do
  submit_valid_input_sequence
  submit_default_deactivation_code
  submit_valid_input_sequence
end

Then(/^all input fields flash a warning$/) do
  inputs_should_be_empty_with_selector('input.warning')
end

Then(/^all code input fields are empty$/) do
  inputs_should_be_empty_with_selector('input')
end

def inputs_should_be_empty_with_selector(selector)
  page.should have_css("#code-input-panel #{selector}", text: '', count: 4)
end

def submit_valid_input_sequence
  submit_input_sequence(5, 7, 2, 9)
end

def submit_invalid_input_sequence
  submit_input_sequence(5, 'e', 2, 7)
end

def submit_default_activation_code
  submit_input_sequence(*Bomb::DEFAULT_ACTIVATION_CODE.split(''))
end

def submit_default_deactivation_code
  submit_input_sequence(*Bomb::DEFAULT_DEACTIVATION_CODE.split(''))
end

def submit_input_sequence(digit_1, digit_2, digit_3, digit_4)
  page.fill_in('digit-1', with: digit_1)
  page.fill_in('digit-2', with: digit_2)
  page.fill_in('digit-3', with: digit_3)
  page.fill_in('digit-4', with: digit_4)
  click_submit_button
end

def click_submit_button
  page.click_button('input-submit')
end
