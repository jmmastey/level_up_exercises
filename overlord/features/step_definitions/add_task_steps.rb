Then(/^I should see a code entry box$/) do
  expect(page).to have_selector('#code-entry')
  expect(page).to have_content('Enter Activation Code')
end

Then(/^the activation state of the bomb$/) do
  expect(page).to have_selector('.activation-state')
end

Given(/^it is my first time visiting the bomb interface$/) do
  @activation_code = 1234
  @incorrect_deactivation_code_count = 0
end

Then(/^I should see the activation state as de\-activated$/) do
  expect(page).to have_selector('.activation-state', text: "The bomb is inactivated.")
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
    fill_in('#set-deactivation-code', with: code)
  end
end

When(/^I set the deactivation code to (\d+)$/) do |code|
  within('form-group') do

  end
end

When(/^I click the boot bomb button$/) do
  click_button('Boot Bomb')
end

