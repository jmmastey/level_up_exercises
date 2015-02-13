def attempt_deactivate(code)
  fill_in('deactivation_code', with: code)
  click_button('Deactivate')
end

Given(/^that the bomb is booted and activated with default codes$/) do
  visit '/'
  click_button("Boot")
  fill_in('activation_code', with: '1234')
  click_button('Activate')
end

When(/^I enter the default codes$/) do
  fill_in('deactivation_code', with: '0000')
end

Then(/^the bomb is deactivated$/) do
  expect(page).to have_selector('.inactive')
end

When(/^I try to deactivate the bomb with the default codes$/) do
  attempt_deactivate('0000')
end

When(/^I try to deactivate the bomb with the wrong code once$/) do
  attempt_deactivate('9999')
end

When(/^I try to deactivate the bomb with the wrong code twice$/) do
  2.times do
    attempt_deactivate('9999')
  end
end

When(/^I try to deactivate the bomb with the wrong code three times$/) do
  3.times do
    attempt_deactivate('9999')
  end
end

Then(/^the bomb does not explode$/) do
  expect(page).to have_selector('.active')
end

Then(/^the bomb goes boom$/) do
  expect(page).to have_selector('.exploded')
end
