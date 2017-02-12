VALID_ARM_CODE = "1111"
VALID_DISARM_CODE = "2222"
INVALID_ARM_CODE = "xyz"
INVALID_DISARM_CODE = "abc"

Given(/^I am on the configure page$/) do
  visit '/configure'
end

When(/^I submit an invalid activation code$/) do
  fill_in('arm_code', :with => INVALID_ARM_CODE)
  click_button('save')
end

When(/^I submit an invalid deactivation code$/) do
  fill_in('disarm_code', :with => INVALID_ARM_CODE)
  click_button('save')
end

When(/^I submit an invalid activation and deactivation code$/) do
  fill_in('arm_code', :with => INVALID_ARM_CODE)
  fill_in('disarm_code', :with => INVALID_DISARM_CODE)
  click_button('save')
end

When(/^I do not enter any codes$/) do
  fill_in('arm_code', :with => "")
  fill_in('disarm_code', :with => "")
end

When(/^I submit the codes$/) do
  click_button('save')
end

When(/^I submit valid activation and deactivation codes$/) do
  fill_in('arm_code', :with => VALID_ARM_CODE)
  fill_in('disarm_code', :with => VALID_DISARM_CODE)
  click_button('save')
end
