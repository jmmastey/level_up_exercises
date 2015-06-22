require './bomb'

Given(/^I am logged in as a villain$/) do
  step 'I visit the login page'
  step 'I login as villain'
end

Given(/^the bomb is inactive$/) do
  step 'I boot the bomb'
end

When(/^I activate the bomb$/) do
  fill_in('code', with: "1234")
  click_button('Apply Code')
  page.find("#confirm_apply")
  click_button('Confirm Code')
end

Then(/^I should see an active bomb$/) do
  page.should have_content('Active')
end

When(/^I use the wrong activation code$/) do
  fill_in('code', with: "4321")
  click_button('Apply Code')
  page.find("#confirm_apply")
  click_button('Confirm Code')
end

Then(/^I should see an inactive bomb$/) do
  page.should have_content('Inactive')
end

Given(/^the bomb has not been booted$/) do
end

Then(/^I should see a message about the bomb not being booted$/) do
  expect(page).to have_content('The bomb has not been booted')
end

Then(/^I should see a notification that I have used the wrong activation code$/) do
  expect(page).to have_content('Incorrect activation code')
end

When(/^I use an invalid activation code$/) do
  fill_in('code', with: "DARBY")
  click_button('Apply Code')
  page.find("#confirm_apply")
  click_button('Confirm Code')
end

When(/^I boot with an invalid activation code$/) do
  fill_in('activation_code', with: "DARBY")
end

Then(/^I should see a notification with the rules for valid activation codes$/) do
  expect(page).to have_content('Activation codes must be numeric')
end

When(/^I use the activation code$/) do
  fill_in('code', with: "1234")
  click_button('Apply Code')
end

When(/^I cancel the activation sequence$/) do
  page.find("#cancel_apply")
  click_button('Cancel')
end

When(/^I login as a villain$/) do
  step 'I login as villain'
end

Then(/^I should see the status of the bomb is offline$/) do
  step 'I should see the bomb is offline'
end

Given(/^the bomb has been booted$/) do
  step 'I boot the bomb'
end

When(/^I boot the bomb$/) do
  click_on('Boot')
end

Then(/^I should see a notification that the bomb has already been booted$/) do
  page.should have_content('The bomb has already been booted')
end

Then(/^I should see the status of the bomb is inactive$/) do
  step 'I should see an inactive bomb'
end

Given(/^I am logged in as a citizen$/) do
  step 'I visit the login page'
  fill_in('username', with: 'citizen')
  click_on('Submit')
end

Given(/^I am logged in as a dev$/) do
  step 'I visit the login page'
  fill_in('username', with: 'dev')
  click_on('Submit')
end

Given(/^the bomb is active$/) do
  step 'I activate the bomb'
end

When(/^I use the correct deactivation code$/) do
  fill_in('code', with: "0000")
  click_button('Apply Code')
  page.find("#confirm_apply")
  click_button('Confirm Code')
end

Given(/^I use the wrong deactivation code$/) do
  fill_in('code', with: "DARBY")
  click_button('Apply Code')
  click_button('Confirm Code')
end

Then(/^the number of defusal attempts should decrease$/) do
  expect(page).to have_content('Defuse Attempts: 2')
end

Then(/^I should see an explosion$/) do
  page.should have_content('Exploded')
end

When(/^the number of defusal attempts hits zero$/) do
  3.times { step 'I use the wrong deactivation code' }
end

Given(/^bomb has exploded$/) do
  step 'the bomb has exploded'
end

Then(/^I should not be able to press buttons$/) do
  expect(page).should_not have_css('.explodable')
end

When(/^I visit the bomb page$/) do
  visit '/bomb'
end

Then(/^I should be redirected to the login page$/) do
  current_path.should eq '/'
end

When(/^I login as villain$/) do
  visit '/'
  fill_in('username', with: 'villain')
  click_on('Submit')
end

Then(/^I should be redirected to the bomb page$/) do
  current_path.should == '/bomb'
end

Then(/^I should be logged in as villian$/) do
  page.should have_content('villain')
end

When(/^I login as dev$/) do
  fill_in('username', with: 'dev')
  click_on('Submit')
end

Then(/^I should be logged in as dev$/) do
  page.should have_content('dev')
end

When(/^I login as civilian$/) do
  fill_in('username', with: 'civilian')
  click_on('Submit')
end

Then(/^I should be logged in as civilian$/) do
  page.should have_content('civilian')
end

Given(/^I am logged in$/) do
  step 'I login as villain'
end

When(/^I visit the login page$/) do
  visit '/'
end

Given(/^I am on the login page$/) do
  visit '/'
end

When(/^I click the logout link$/) do
  click_link('logout')
end

Then(/^I should not be logged in$/) do
  current_path.should eq '/'
  page.should_not have_content('villain')
end

When(/^I visit the reset page$/) do
  visit '/reset'
end

Given(/^the bomb has exploded$/) do
  step 'I am logged in as a villain'
  step 'the bomb has been booted'
  step 'the bomb is active'
  step 'the number of defusal attempts hits zero'
end

Then(/^I should be able to login$/) do
  step 'I visit the login page'
  step 'I login as civilian'
  step 'I should be logged in as civilian'
end

Then(/^I should see the bomb is offline$/) do
  page.should have_content('Offline')
end
