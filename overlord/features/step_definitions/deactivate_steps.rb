DEFAULT_ACTIVATION_CODE = '1234'
DEFAULT_DEACTIVATION_CODE = '0000'
WRONG_DEACTIVATION_CODE = '1111'

Given(/^a bomb is activated$/) do
  visit('/')
  click_on('boot')
  fill_in('activate_code', with: DEFAULT_ACTIVATION_CODE)
  click_on('activate')
end

When(/^I enter the correct deactivation code$/) do
  fill_in('deactivate_code', with: DEFAULT_DEACTIVATION_CODE)
  click_on('deactivate')
end

Then(/^the bomb should be deactivated$/) do
  expect(page).to have_content(:inactive)
end

When(/^I enter the wrong deactivation code$/) do
  fill_in('deactivate_code', with: WRONG_DEACTIVATION_CODE)
  click_on('deactivate')
end

Then(/^the bomb should not be deactivated$/) do
  expect(page).to have_content(:active)
end

Then(/^the bomb is detonated$/) do
  expect(page.find_by_id('boom'))
end
