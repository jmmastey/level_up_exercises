Given(/^Bomb is configured with default codes$/) do
  visit('/configure')
  Bomb::COUNTDOWN = 5  # ONLY FOR TESTING PURPOSE
  click_button('boot')
end

When(/^Super Villain visits activate page$/) do
  visit('/activate')
end

Then(/^He should see bomb activation form$/) do
  expect(page).to have_field('activate_code')
  expect(page).to have_button('Activate')
end

Given(/^Super Villain is on Activate page$/) do
  visit('/configure')
  click_button('boot')
  visit('/activate')
end

When(/^Enters correct activation code$/) do
  fill_in('activate_code', with: '1234')
end

When(/^Enters incorrect activation code$/) do
  fill_in('activate_code', with: '1111')
end

When(/^Clicks Activate$/) do
  click_button('Activate')
end

Then(/^He should see deactivate page$/) do
  visit('/deactivate')
end

Then(/^Error message should be displayed$/) do
  expect(page).to have_content('Wrong activation code')
end
