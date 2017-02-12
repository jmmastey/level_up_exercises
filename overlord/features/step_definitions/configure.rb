Given(/^I have not booted the bomb$/) do
  # not sure if this is kosher but I'm not sure how to test this condition
  true
end

When(/^I visit the home page$/) do
  visit '/'
end

Then(/^I should see a configuration form$/) do
  expect(page).to have_field('arm_code')
  expect(page).to have_field('disarm_code')
  expect(page).to have_selector('input#save')
end

When(/^I submit an invalid activation code$/) do
  fill_in('arm_code', :with => "xyz") 
  click_button('save')
end

When(/^I submit an invalid deactivation code$/) do
  fill_in('disarm_code', :with => "xyz") 
  click_button('save')
end

When(/^I submit an invalid activation and deactivation code$/) do
  fill_in('arm_code', :with => "xyz") 
  fill_in('disarm_code', :with => "abc") 
  click_button('save')
end

When(/^I do not enter any codes$/) do
  fill_in('arm_code', :with => "") 
  fill_in('disarm_code', :with => "") 
end

When(/^I click the Save Codes button$/) do
  click_button('save')
end

When(/^I fill in arm_code with "(.*?)"$/) do |arg1|
  fill_in('arm_code', :with => arg1)
end

When(/^I fill in disarm_code with "(.*?)"$/) do |arg1|
  fill_in('disarm_code', :with => arg1)
end
