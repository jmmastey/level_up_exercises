Given(/^The bomb has been booted with the default codes$/) do
  visit "/"
  click_button("Boot bomb")
end

When(/^I enter the default activation code$/) do
  fill_in('submitted_act_code', with: 1234)
  click_button('Submit activation code')
end

When(/^I enter the correct activation code$/) do
  fill_in('submitted_act_code', with: 1111)
  click_button('Submit activation code')
end

Then(/^the bomb should be activated$/) do
  expect(page).to have_selector('.active_bomb')
end

Given(/^The bomb has been booted with a specified activation code$/) do
  visit "/"
  fill_in('act_code', with: 1111)
  click_button("Boot bomb")
end

When(/^I enter an incorrect activation code$/) do
  fill_in('submitted_act_code', with: 2222)
  click_button('Submit activation code')
end

Then(/^the bomb should not activate$/) do
  expect(page).to have_selector('.incorrect_act_code')
end