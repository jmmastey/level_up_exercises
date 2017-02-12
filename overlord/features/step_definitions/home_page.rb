Given(/^The bomb has been booted$/) do
  visit '/'
  click_button('save')
end

Then(/^I should see an entry field$/) do
  expect(page).to have_selector('input')
end

Then(/^I should see a submit button$/) do
  expect(page).to have_selector('input[type=submit]')
end

Given(/^The bomb has been configured with default codes$/) do
  true
end

When(/^I submit an incorrect activation code$/) do
  fill_in('code', :with => '9999')
  click_button('submit')
end

When(/^I submit the correct activation code$/) do
  submit_correct_activation_code
end

Given(/^The bomb has been activated$/) do
  submit_correct_activation_code
end

Then(/^I should still see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^I submit the correct deactivation code$/) do
  fill_in('code', :with => '0000')
  click_button('submit')
end

When(/^I submit an incorrect deactivation code one time$/) do
  submit_incorrect_deactivation_code
end

When(/^I submit an incorrect deactivation code two times$/) do
  2.times { submit_incorrect_deactivation_code }
end

When(/^I submit an incorrect deactivation code three times$/) do
  3.times { submit_incorrect_deactivation_code }
end

def submit_correct_activation_code
  fill_in('code', :with => '1234')
  click_button('submit')
end

def submit_incorrect_deactivation_code
  fill_in('code', :with => '9999')
  click_button('submit')
end
