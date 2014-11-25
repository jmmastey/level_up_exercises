Given(/^I have entered the activation and deactivation codes$/) do
  visit '/'
  fill_in('Set Activation Code', with: 4444)
  fill_in('Set Deactivation Code', with: 8888)
  click_button("Submit New Code and Boot")
end

Given(/^I am using the default codes$/) do
  visit '/'
  click_button("Boot Bomb")
end

Given(/^the bomb is active$/) do
  fill_in('Enter Code', with: 4444)
  click_button("Enter Code")
  expect(page).to have_content("active")
end

Given(/^I have a bomb with two incorrect attempts$/) do
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
end

Given(/^the bomb has exploded$/) do
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
end

When(/^I set the activation and deactivation codes$/) do
  fill_in('Set Activation Code', with: 5678)
  fill_in('Set Deactivation Code', with: 9123)
  click_button("Submit New Code and Boot")
end

When(/^I enter the default activation code$/) do
  fill_in('Enter Code', with: 4444)
  click_button("Enter Code")
end

When(/^I enter the incorrect deactivation code$/) do
  fill_in('Enter Code', with: 6987)
  click_button("Enter Code")
end

When(/^I enter my correct activation code$/) do
  fill_in('Enter Code', with: 1234)
  click_button("Enter Code")
end

When(/^I enter my correct deactivation code$/) do
  fill_in('Enter Code', with: 8888)
  click_button("Enter Code")
end

When(/^I enter the correct activation code twice$/) do
  fill_in('Enter Code', with: 4444)
  click_button("Enter Code")
  fill_in('Enter Code', with: 4444)
  click_button("Enter Code")
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

Then(/^the bomb should be (.+)$/) do |state|
  within(".activation-state") do
    expect(page).to have_content(state)
  end
end

Then(/^the Enter Code button should not work$/) do
  expect(current_path).to eq('/exploded')
end


