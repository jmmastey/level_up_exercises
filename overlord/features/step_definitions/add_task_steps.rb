Then(/^I should see a code entry box$/) do
  expect(page).to have_selector('#code-entry')
  expect(page).to have_content('Enter Code')
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
