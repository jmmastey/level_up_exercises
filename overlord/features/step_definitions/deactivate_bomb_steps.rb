Given(/^The bomb has been booted and activated with the default codes$/) do
  visit "/"
  click_button("Boot bomb")
  fill_in('submitted_act_code', with: "1234")
  click_button('Submit activation code')
end

When(/^I enter the default deactivation code$/) do
  fill_in('submitted_deact_code', with: "0000")
  click_button('Submit deactivation code')
end

Then(/^the bomb should deactivate$/) do
  expect(page).to have_selector('.deactivated')
end

When(/^I enter an incorrect activation code once$/) do
  fill_in('submitted_deact_code', with: "abcd")
  click_button('Submit deactivation code')
end

Then(/^the bomb should not deactivate$/) do
  expect(page).to have_selector('.active_bomb')
end

Then(/^the number of deactivation attempts remaining should be (\d+)$/) do |remaining_attempts|
  expect(page).to have_content("Attempts remaining: #{remaining_attempts}")
end

When(/^I enter an incorrect activation code twice$/) do
  2.times do
    fill_in('submitted_deact_code', with: "abcd")
    click_button('Submit deactivation code')
  end
end

When(/^I navigate back to the activation page$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see that the bomb has already been activated$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should not be able to re\-activate the bomb$/) do
  pending # express the regexp above with the code you wish you had
end