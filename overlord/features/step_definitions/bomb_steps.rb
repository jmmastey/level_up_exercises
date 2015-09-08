Given(/^I am on the bomb page$/) do
  visit '/'
end

Given(/^the bomb is deactivated$/) do
  expect(page).to have_content("Deactivated")
end

When(/^I enter the correct activation code$/) do
  fill_in('formInput', with: '1234')
  click_button('Submit')
end

Then(/^the bomb is now activated$/) do
  expect(page).to have_content("Activated")
  expect(page).to have_selector('#timer', visible: true)
end

Given(/^the bomb is activated$/) do
  fill_in('formInput', with: '1234')
  click_button('Submit')
  expect(page).to have_content("Activated")
end

When(/^I enter the correct deactivation code$/) do
  fill_in('code', with: '0000')
  click_button('Submit')
end

Then(/^the bomb is now deactivated$/) do
  expect(page).to have_content("Deactivated")
  expect(page).to have_selector('#timer', visible: false)
end

When(/^I enter an activation code$/) do
  fill_in('code', with: '1234')
  click_button('Submit')
end

Then(/^nothing happens$/) do
  expect(page).to have_content("Activated")
  expect(page).not_to have_content("02:00")
end

When(/^I enter an incorrect activation code$/) do
  fill_in('code', with: '1111')
  click_button('Submit')
  expect(page).to have_content("Invalid!")
end

When(/^I enter an incorrect deactivation code$/) do
  fill_in('code', with: '1111')
  click_button('Submit')
  expect(page).to have_content("(2 attempts remaining!)")
end

When(/^I enter an incorrect deactivation code three times$/) do
  fill_in('code', with: '1111')
  click_button('Submit')
  expect(page).to have_content("(2 attempts remaining!)")
  fill_in('code', with: '1111')
  click_button('Submit')
  expect(page).to have_content("(1 attempts remaining!")
  fill_in('code', with: '1111')
  click_button('Submit')
end

Then(/^the bomb is exploded$/) do
  expect(page).to have_content("!@#$%^&*!@#&$!")
  expect(page).to have_button("formButton", disabled: true)
  expect(page).to have_selector('#timer', visible: false)
end

When(/^the bomb timer ends$/) do
  sleep(120.1) # Wait for 2 minutes for the timer to finish
end

Given(/^the bomb is not exploded$/) do
  expect(page).to have_content("Deactivated")
end

When(/^I enter an invalid code$/) do
  fill_in('code', with: 'a')
  click_button('Submit')
end

Then(/^I see that only numerical inputs are allowed$/) do
  page.has_content?("Only numeric input is allowed.")
end
