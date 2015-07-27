Given(/^the bomb is armed$/) do
  submit_input_sequence
  submit_input_sequence
  submit_input_sequence
end

When(/^I submit sequence code input$/) do
  submit_input_sequence
end

When(/^I input "([^"]*)" for digit\-(\d+)$/) do |value, digitField|
  page.fill_in "digit-#{digitField}", with: value
end

Then(/^the bomb state should be (.+?)$/) do |state|
  page.should have_css(".#{state}")
end

Then(/^the bomb lid should be open$/) do
  page.should have_css('#briefcase-lid.open')
end

def submit_input_sequence
  page.fill_in 'digit-1', with: 5
  page.fill_in 'digit-2', with: 9
  page.fill_in 'digit-3', with: 3
  page.fill_in 'digit-4', with: 2
  page.click_button 'input-submit'
end