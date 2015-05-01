Given(/^I am on the bomb home page$/) do
  visit('/')
end

When(/^I boot the bomb$/) do
  click_button('Boot Bomb')
end

Then(/^I am prompted to provide activation and deactivation codes$/) do
  expect(page).to have_css("input#activation_code")
  expect(page).to have_css("input#deactivation_code")
  expect(page).to have_button("Submit Codes")
end



Given(/^I boot the bomb$/) do
  click_button('Boot Bomb')
end

When(/^I submit valid codes$/) do
  fill_in('Activation Code', with: 1234)
  fill_in('Deactivation Code', with: 0000)
  click_button('Submit Codes')
end

Then(/^I see the bomb has successfully booted$/) do
  expect(page).to have_content('The bomb successfully booted!')
end

Then(/^I see a prompt to enter activation code$/) do
  expect(page).to have_css("input#start_bomb")
end






When(/^I submit invalid codes$/) do
  fill_in('Activation Code', with: "abcd")
  fill_in('Deactivation Code', with: 0000)
end

Then(/^I see the bomb did not successfully boot$/) do
  expect(page).to have_content("Unfortunately your codes were invalid.")
end

