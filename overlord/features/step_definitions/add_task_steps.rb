Given(/^a bomb$/) do
  @bomb = Bomb.new
end

Given(/^I have entered the activation and deactivation codes$/) do
  visit '/'
  fill_in('Set Activation Code', with: 4444)
  fill_in('Set Deactivation Code', with: 8888)
  click_button("Submit New Code and Boot")
end

Given(/^the bomb is active$/) do
  fill_in('Enter Code', with: 4444)
  click_button("Enter Code")
  expect(page).to have_content("active")
end

Then(/^I should see a code entry box$/) do
  expect(page).to have_selector('#code')
  expect(page).to have_content('Enter Code')
end

Then(/^the activation state of the bomb$/) do
  expect(page).to have_selector('.activation-state')
end

Then(/^I should see a set activation code entry box$/) do
  expect(page).to have_selector('#set-activation-code')
end

Then(/^I should see a set de\-activation code entry box$/) do
  expect(page).to have_selector('#set-deactivation-code')
end

Then(/^I should see a boot button$/) do
  expect(page).to have_selector('.boot-bomb-button')
end

When(/^I set the activation code to (\d+)$/) do |code|
  fill_in('Set Activation Code', with: code)
end

When(/^I set the deactivation code to (\d+)$/) do |code|
  fill_in('Set Deactivation Code', with: code)
end

When(/^I click the (.+) button$/) do |button|
  click_button("#{button}")
end

When(/^I enter (\d+) in the enter code box$/) do |code|
  fill_in('Enter Code', with: code)
end

Then(/^the bomb should be (.+)$/) do |state|
  expect(page).to have_content(state)
end

