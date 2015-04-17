VALID_ACTIVATION_CODE = '123456'
VALID_DEACTIVATION_CODE = '999999'
INVALID_ACTIVATION_CODE = 'invalid'
INVALID_DEACTIVATION_CODE = 'invalid'
Given(/^I have a bomb$/) do
  visit('/')
end

Given(/^I enter valid activation code$/) do
  fill_in('activation_code', with: VALID_ACTIVATION_CODE)
end

Given(/^I enter valid deactivation code$/) do
  fill_in('deactivation_code', with: VALID_DEACTIVATION_CODE)
end

When(/^I boot the bomb$/) do
  click_on('boot')
end

Then(/^the bomb should be inactive$/) do
  expect(page).to have_content(:inactive)
end

Given(/^I enter invalid activation code$/) do
  fill_in('activation_code', with: INVALID_ACTIVATION_CODE)
end

Given(/^I enter invalid deactivation code$/) do
  fill_in('deactivation_code', with: INVALID_DEACTIVATION_CODE)
end

Then(/^I should see an error$/) do
  expect(page).to have_content('Error')
end
