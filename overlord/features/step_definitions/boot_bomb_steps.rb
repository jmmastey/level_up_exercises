Given (/^I am on the home page$/) do
  visit "/"
end

Then(/^I should see fields to enter the activation and deactivation codes for the bomb$/) do
  expect(page).to have_content('Deactivation code:')
  expect(page).to have_content('Activation code:')
end

Then(/^I should see a button to boot the bomb$/) do
  expect(page).to have_selector('.boot-bomb')
end