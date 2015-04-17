CORRECT_ACTIVATION_CODE = '1111'
WRONG_ACTIVATION_CODE = '2222'

Given(/^a bomb is installed$/) do
  visit('/')
  click_on('boot')
end

When(/^I enter the correct activation code$/) do
  fill_in('activate_code', with: CORRECT_ACTIVATION_CODE)
end

Then(/^the bomb should be activated$/) do
  expect(page).to have_content(:active)
end

When(/^I enter the wrong activation code$/) do
  fill_in('activate_code', with: WRONG_ACTIVATION_CODE)
end

Then(/^the bomb should not be activated$/) do
  expect(page).to have_content(:inactive)
end
