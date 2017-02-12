def submit_correct_activation_code
  fill_in('code', :with => '1234')
  click_button('submit')
end

Given(/^the bomb has been booted with default codes$/) do
  visit '/'
  click_button('save')
end

When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see an entry field$/) do
  expect(page).to have_selector('input')
end

Then(/^I should see a submit button$/) do
  expect(page).to have_selector('input[type=submit]')
end

When(/^I submit an incorrect activation code$/) do
  fill_in('code', :with => '9999')
  click_button('submit')
end

When(/^I submit the correct activation code$/) do
  submit_correct_activation_code
end

Given(/^the bomb has been activated$/) do
  submit_correct_activation_code
end
