def verify_arming_code(code)
  fill_in 'armingcode', with: code
  click_button 'Arm Bomb'
  expect(page).to have_text('Bomb Armed :true ')
end

def verify_disarming_code(code)
  fill_in 'disarmingcode', with: code
  click_button 'Disarm Bomb'
  expect(page).to have_text('Bomb Armed :false ')
end

Given(/^I am booting a bomb$/) do
  visit '/boot/'
end

When(/^I do not provide a custom activation code$/) do
  fill_in 'activation', with: ''
end

When(/^I create a new bomb$/) do
  click_button 'Create Bomb'
end

Then(/^the bomb boots$/) do
  expect(page).to have_text('Bomb Enabled :true')
end

Then(/^the bomb should not be activated$/) do
  expect(page).to have_text('Bomb Armed :false')
end

Then(/^I see a message that a new bomb was created$/) do
  expect(page).to have_text('Bomb Enabled :true')
end

Then(/^the bomb activation code should be set to (\d+)$/) do |code|
  verify_arming_code(code)
end

When(/^I provide a custom activation code "([^"]*)"$/) do |code|
  fill_in 'activation', with: code
end

Then(/^I see a message that a new bomb was not created$/) do
  expect(page).to have_text('Bomb creation failed')
end

Given(/^I already booted and activated the bomb$/) do
  visit '/boot/'
  fill_in 'activation', with: ''
  click_button 'Create Bomb'
  click_link('Boot A Bomb')
end