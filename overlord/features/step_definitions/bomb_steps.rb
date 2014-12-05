require 'pry'

Given /^I go to the home page (.+)$/ do |url|
  visit url
end

Given /^The bomb is not activate$/ do
  expect(page.find_by_id('bomb_state').text).to eq('Not Activate')
end

When /^I go to the home page "(.+)"$/ do |url|
  visit(url)
end

When /^I boot the bomb "(.+)"$/ do |url|
  visit "#{url}?activation_code=1234&deactivation_code=0000"
end

When /^I click "(.+)"$/ do |button_name|
  begin
    find_button(button_name).trigger('click')
    wait_for_ajax_call_complete
  rescue Capybara::NotSupportedByDriverError
    click_button(button_name)
  end
end

When /^I enter wrong deactivation code 3 times$/ do
  button = find_button('Deactivate')
  count = 0
  while count < 3
    fill_in('code', with: 1111)
    button.trigger('click')
    sleep(0.5)
    count += 1
  end
end

Then /^I should see the bomb info "(.+)"$/ do |message|
  expect(page.find('p').text).to eq(message)
end

Then /^the activation and deactivation should have default values$/ do
  expect(page.find_by_id('activation-code')[:placeholder]).to eq('1234')
  expect(page.find_by_id('deactivation-code')[:placeholder]).to eq('0000')
end

Then /^I enter the custom activation and deactivation code$/ do
  fill_in('activation-code', with: '1111')
  fill_in('deactivation-code', with: '2222')
  expect(page.find_by_id('activation-code').value).to eq('1111')
  expect(page.find_by_id('deactivation-code').value).to eq('2222')
end

Then /^I should see the bomb state : "(.+)"$/ do |state|
  expect(page.find_by_id('bomb_state').text).to eq(state)
end

Then /^I should see "(.+)" button$/ do |button_name|
  expect(page.find_button(button_name)).to be_truthy
end

Then /^I should be on the detonate page$/ do
  uri = URI.parse(current_url)
  expect(uri.path).to eq('/detonate')
  expect(page.find('h1').text).to eq('BOOM')
end

Then /^I enter activation code "(.+)"$/ do |code|
  expect(enter_activation_deactivation_code(code)).to be_truthy
end

Then /^I enter deactivation code "(.+)"$/ do |code|
  expect(enter_activation_deactivation_code(code)).to be_truthy
end

Then /^I should see alert message "(.+)"$/ do |message|
  expect(page.find_by_id('alert_message').text).to eq(message)
end

Then /^the bomb timer should stop$/ do
  sleep(2)
  timestamp = page.find_by_id('bomb_timer').text
  sleep(2)
  expect(page.find_by_id('bomb_timer').text).to eq(timestamp)
end

Then /^the bomb timer is counting down$/ do
  sleep(2)
  timestamp =  page.find_by_id('bomb_timer').text
  expect(valid_timestamp_format?(timestamp)).to be_truthy
  sleep(2)
  expect(page.find_by_id('bomb_timer')).not_to eq(timestamp)
end

def enter_activation_deactivation_code(code)
  fill_in('code', with: code)
  page.find_by_id('code').value == code
end

def valid_timestamp_format?(timestamp)
  !!(timestamp =~ /^(\d{2}\:?){3}$/)
end

def wait_for_ajax_call_complete
  Timeout.timeout(Capybara.default_wait_time)do
    loop do
      break page.evaluate_script('jQuery.active') == 0
    end
  end
end
