require 'pry'
Given /^The bomb is not activate$/ do
  expect(page.find_by_id('bomb_state').text).to eq('Not Activate')
end

Given /^I go to the home page$/ do
  visit('/')
end

Given /^I booted the bomb$/ do
  visit('/')
  fill_in('activation-code', with: '1234')
  fill_in('deactivation-code', with: '0000')
  find_button('Boot').trigger('click')
end

Given /^the bomb is not activated$/ do
  expect(find('#bomb-state').text).to eq('not activated')
end

Given /^I activated the bomb$/ do
  step 'I try to activate the bomb using the code "1234"'
  step 'the bomb timer is counting down'
end

When /^I enter wrong deactivation code 3 times$/ do
  button = find_button('Deactivate')
  3.times do
    fill_in('code', with: 1111)
    button.trigger('click')
    sleep(0.5)
  end
end

When /^I try to activate the bomb using the code "(.+)"$/ do |code|
  fill_in('code', with: code)
  find_button('Activate').trigger('click')
end

When /^I try to deactivate the bomb using the code "(.+)"$/ do |code|
  fill_in('code', with: code)
  find_button('Deactivate').trigger('click')
end

When /^I try to boot the bomb with the default codes$/ do
  find_button('Boot').trigger('click')
end

When /^I try to boot the bomb using "(.+)" and "(.+)"$/ do |activation, deactivation|
  find('#activation-code').set(activation)
  find('#deactivation-code').set(deactivation)
  find_button('Boot').trigger('click')
end

Then /^the button changed to "(.+)"$/ do |button_name|
  expect(has_button?(button_name)).to be_truthy
end

Then /^the "(.+)" button should remains on the page$/ do |button_name|
  expect(has_button?(button_name)).to be_truthy
end

Then /^I should see the bomb is "(.+)"$/ do |state|
  expect(find('#bomb-state').text).to eq(state)
end

Then /^I should see "(.+)" button$/ do |button_name|
  expect(page.find_button(button_name)).to be_truthy
end

Then /^I should be on the detonate page$/ do
  uri = URI.parse(current_url)
  expect(uri.path).to eq('/detonate')
end

Then /^I should see alert message "(.+)"$/ do |message|
  expect(page.find_by_id('alert-message').text).to eq(message)
end

Then /^the bomb timer should be stopped$/ do
  timestamp = find('#bomb-timer').text
  5.times do
    expect(find('#bomb-timer').text).to eq(timestamp)
  end
end

Then /^the bomb timer is counting down$/ do
  timestamp = find('#bomb-timer').text
  expect(valid_timestamp_format?(timestamp)).to be_truthy
  sleep(0.5)
  expect(find('#bomb-timer').text).not_to eq(timestamp)
end

def enter_activation_deactivation_code(code)
  fill_in('code', with: code)
  page.find_by_id('code').value == code
end

def valid_timestamp_format?(timestamp)
  !!(timestamp =~ /^(\d{2}\:){2}\d{3}$/)
end

def wait_for_ajax_call_complete
  Timeout.timeout(Capybara.default_wait_time)do
    loop do
      break page.evaluate_script('jQuery.active') == 0
    end
  end
end
