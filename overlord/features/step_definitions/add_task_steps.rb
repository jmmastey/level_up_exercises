Given(/^a bomb$/) do
  @bomb = Bomb.new
end

Given(/^the default activation and deactivation codes$/) do
  visit '/'
  click_button("Boot Bomb")
end

Given(/^user activation and deactivation codes$/) do
  visit '/'
  within('form-group') do
    fill_in('#set-activation-code', with: 4444)
  end
  within('form-group') do
    fill_in('#set-deactivation-code', with: 8888)
  end
  click_button("Submit New Code and Boot")
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
  within('form-group') do
    fill_in('#set-activation-code', with: code)
  end
end

When(/^I set the deactivation code to (\d+)$/) do |code|
  within('form-group') do
    fill_in('#set-deactivation-code', with: code)
  end
end

When(/^I click the (.+) button$/) do |button|
  click_button("#{button}")
end

When(/^I enter (\d+) in the enter code box$/) do |code|
  within('form-group') do
    fill_in('#code', with: code)
  end
end

Then(/^the bomb should be (.+)$/) do |state|
  expect(page).to have_content(state)
end

