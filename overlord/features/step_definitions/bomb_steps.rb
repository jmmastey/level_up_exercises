Given(/^I visit the bomb boot up page$/) do
  visit '/'
end

Given(/^I am on the page with text "(.*?)"$/) do |page_text|
  expect(page).to have_content page_text
end

When(/^I set the activation code as "(.*?)" and deactivation code as "(.*?)"$/) do |activation_code, deactivation_code|
  fill_in 'set_activation_code', with: activation_code
  fill_in 'set_deactivation_code', with: deactivation_code
  click_button 'Confirm'
end

When(/^I (activate|deactivate) the bomb with code "(.*?)"$/) do |code_type, code|
  fill_in code_type.chop + 'ion_code', with: code
  click_button 'Confirm'
end

When(/^I try to deactivate the bomb with wrong code "(.*?)" three times$/) do |code|
  3.times do
    fill_in 'deactivation_code', with: code
    click_button 'Confirm'
  end
end

Then(/^I should see "(.*?)" on the (bomb|boot) page$/) do |activepage_text, _|
  expect(page).to have_content activepage_text
end

Then(/^I should see less than 30 seconds and 2 attempts left message on the page$/) do
  message = /^You have (\d{2}) seconds and 2 attempts, to enter the right deactivation code.$/
  expect(find('#time_left_id').text).to match(message)
end
