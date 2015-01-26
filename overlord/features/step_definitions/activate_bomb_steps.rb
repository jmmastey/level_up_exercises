Given(/^the bomb has been booted with the default codes$/) do
  visit "/"
  click_button("Boot bomb")
end

When(/^I enter the default activation code$/) do
  fill_in('submitted_act_code', with: "1234")
  click_button('Submit activation code')
end

When(/^I enter the correct activation code$/) do
  fill_in('submitted_act_code', with: "1111")
  click_button('Submit activation code')
end

Then(/^the bomb should be activated$/) do
  expect(page).to have_selector('.active_bomb')
end

Given(/^the bomb has been booted with a specified activation code$/) do
  visit "/"
  fill_in('act_code', with: "1111")
  click_button("Boot bomb")
end

When(/^I enter an incorrect activation code$/) do
  fill_in('submitted_act_code', with: "2222")
  click_button('Submit activation code')
end

Then(/^the bomb should not be activated yet$/) do
  expect(page).to have_selector('.not_activated')
end

Then(/^I should see a field to enter the activation code$/) do
  expect(page).to have_selector('.act_code')
end

Then(/^I should see a button to submit the activation code$/) do
  expect(page).to have_selector('.submit')
end

Then(/^I should see an incorrect activation code error message$/) do
  expect(page).to have_selector('.incorrect_act_code')
end
