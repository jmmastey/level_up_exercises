Given(/^The bomb is not booted$/) do
  visit "/"
end

Given(/^The bomb is available$/) do
  visit "/bomb"
end

When(/^The bomb is booted$/) do
  click_button('arm-button')
end

Then(/^The bomb should be activated$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^The deactivation code is used$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^The bomb should be deactivated$/) do
  pending # express the regexp above with the code you wish you had
end
