Given(/^I visit the bomb boot up page$/) do
  visit '/'
end

Given(/^I am on the page with text "(.*?)"$/) do |page_text|
  expect(page).to have_content page_text
end

When(/^I type in the activation code "(.*?)" and deactivation code "(.*?)"$/) do |activation_code, deactivation_code|
  fill_in 'setactivationcode_id', with: activation_code
  fill_in 'setdeactivationcode_id', with: deactivation_code
end

When(/^I type (activation|deactivation) code "(.*?)"$/) do |code_type, code|
  fill_in "#{code_type}code_id", with: code
end

And(/^I click the confirm button$/) do
  click_button 'Confirm'
end

Then(/^I should see "(.*?)" on the (bomb|boot) page$/) do |activepage_text, _|
  expect(page).to have_content activepage_text
end

Then(/^I should see less than 30 seconds and 2 attempts left message on the page$/) do
  message = /^You have (\d{2}) seconds and 2 attempts, to enter the right deactivation code.$/
  expect(find('#time_left_id').text).to match(message)
end
