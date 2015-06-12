require './bomb'

Given(/^I am logged in as a villain$/) do
  step 'I visit the login page'
  step 'I login as villain'
end

Given(/^the bomb is inactive$/) do
  step 'I login as villain'
  step 'I boot the bomb'
end

When(/^I activate the bomb$/) do
  fill_in('code', :with => 1234)
end

Then(/^I should see an active bomb$/) do
  page.should have_content('Online')
  page.should have_content('Bomb Timer')
end

When(/^I use the wrong activation code$/) do
  fill_in('code', :with => 4321)
end

Then(/^I should see an inactive bomb$/) do
  page.should have_content('Inactive')
  page.should_not have_content('Bomb Timer')
end

Given(/^the bomb has not been booted$/) do
  # Filler.. this sentance is here just to make more sense to the reader.
end

Then(/^I should not be able to activate the bomb$/) do
  expect(page).to have_button('Submit', disabled: true)
end

Then(/^I should see a notification that I have used the wrong activation code$/) do
  find('error').text.should have_content('Incorrect activation code')
end

When(/^I use an invalid activation code$/) do
  fill_in('code', :with => "DARBY")
end

Then(/^I should see a notification with the rules for valid activation codes$/) do
  find('error').text.should have_content('Activation codes must be numeric')
end

When(/^I use the activation code$/) do
  step 'I activate the bomb'
end

Then(/^I should see a confirm button$/) do
  expect(page).to have_button('Confirm')
end

When(/^I cancel the activation sequence$/) do
  click('cancel')
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
  click('Boot')
end

Then(/^I should see a notification that the bomb has already been booted$/) do
  find('error').text.should have_content('The bomb has already been booted')
end

Then(/^I should see the status of the bomb is inactive$/) do
  step 'I should see an inactive bomb'
end

Given(/^I am logged in as a citizen$/) do
  step 'I visit the login page'
  fill_in('Username', :with => 'citizen')
  click('Login')
end

Given(/^I am logged in as a dev$/) do
  fill_in('Username', :with => 'dev')
  click('Login')
end

Given(/^the bomb is active$/) do
  step 'I activate the bomb'
end

When(/^I use the correct deactivation code$/) do
  fill_in('code', :with => 0000)
end

Given(/^I use the wrong deactivation code$/) do
  fill_in('code', :with => "DARBY")
end

Then(/^the number of defusal attempts should decrease$/) do
  find('defusal_attempts').text.should have_content(0)
end

When(/^the bomb timer runs out$/) do
  find_field('timer').value == 0
end

Then(/^I should see an explosion$/) do
  page.should have_content('activate')
end

When(/^the number of defusal attempts hits zero$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^bomb has exploded$/) do
  step 'the bomb has exploded'
end

Then(/^I should not be able to press buttons$/) do
  page.should have_content('activate')
end

When(/^I visit the bomb page$/) do
  visit '/bomb'
end

Then(/^I should be redirected to the login page$/) do
  current_path.should == '/login'
end

When(/^I login as villain$/) do
  fill_in('Username', :with => 'villain')
  click('Login')
end

Then(/^I should be redirected to the bomb page$/) do
  current_path.should == '/bomb'
end

Then(/^I should be logged in as villian$/) do
  page.should have_content('villain')
end

When(/^I login as dev$/) do
  fill_in('Username', :with => 'dev')
  click('Login')
end

Then(/^I should be logged in as dev$/) do
  page.should have_content('dev')
end

When(/^I login as civilian$/) do
  fill_in('Username', :with => 'civilian')
  click('Login')
end

Then(/^I should be logged in as civilian$/) do
  page.should have_content('civilian')
end

Given(/^I am logged in$/) do
  step 'I login as villain'
end

When(/^I visit the login page$/) do
  visit '/login'
end

When(/^I click the logout link$/) do
  click_link('logout')
end

Then(/^I should not be logged in$/) do
  current_path.should == '/login'
  page.should_not have_content('villain')
end

When(/^I visit the reset page$/) do
  visit '/reset'
end

Given(/^the bomb has exploded$/) do
  page.should_not have_content('explosion')
end

Then(/^I should be able to login$/) do
  step 'I visit the login page'
  step 'I login as civilian'
  step 'I should be logged in as civilian'
end

Then(/^I should see the bomb is offline$/) do
  page.should have_content('Offline')
end
