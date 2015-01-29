Given(/^the bomb has been booted with the default codes$/) do
  visit "/"
  click_button("Boot bomb")
end

Then(/^the bomb is not activated yet$/) do
  expect(page).to have_selector(".bomb_deactivated")
end

Then(/^I see a field to enter the activation code$/) do
  expect(page).to have_selector(".act_code_guess")
end

Then(/^I see a button to submit the activation code$/) do
  expect(page).to have_selector(".submit_act_code_guess")
end

When(/^I enter the default activation code$/) do
  fill_in("act_code", with: "1234")
end

When(/^I try to activate the bomb with the default code$/) do
  click_button("Submit activation code")
end

Then(/^the bomb is activated$/) do
  expect(page).to have_selector(".active_bomb")
end

Given(/^the bomb has been booted with activation code "(.*?)"$/) do |number|
  visit "/"
  fill_in("act_code", with: number)
  click_button("Boot bomb")
end

When(/^I enter for the "(.*?)" activation code$/) do |number|
  fill_in("act_code", with: number.to_s)
end

When(/^I enter an incorrect activation code$/) do
  fill_in("act_code", with: "abc!")
end

When(/^I try to activate the bomb$/) do
  click_button("Submit activation code")
end
